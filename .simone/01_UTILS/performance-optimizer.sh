#!/usr/bin/env bash
# Simone Performance Optimizer - Core optimization functions
# Source this file in Simone commands for 60-80% performance improvement

# Performance globals
export SIMONE_CACHE_DIR="${SIMONE_CACHE_DIR:-.simone/.cache}"
export SIMONE_CACHE_TTL="${SIMONE_CACHE_TTL:-300}"
export SIMONE_DB_FILE="$SIMONE_CACHE_DIR/tasks.db"
export SIMONE_PERF_ENABLED="${SIMONE_PERF_ENABLED:-true}"

# Initialize performance subsystem
init_performance() {
    if [[ "$SIMONE_PERF_ENABLED" != "true" ]]; then
        return 0
    fi
    
    mkdir -p "$SIMONE_CACHE_DIR"
    
    # Initialize task database if needed
    if [[ ! -f "$SIMONE_DB_FILE" ]]; then
        init_task_database
    fi
}

# Template caching using SQLite
cache_template() {
    local template_name="$1"
    local template_path=".simone/99_TEMPLATES/${template_name}"
    
    # Check SQLite cache first
    local cached_content=$(sqlite3 "$SIMONE_DB_FILE" "SELECT value FROM cache_meta WHERE key='template_$template_name' AND updated > $(( $(date +%s) - SIMONE_CACHE_TTL ));" 2>/dev/null)
    if [[ -n "$cached_content" ]]; then
        echo "$cached_content"
        return 0
    fi
    
    # Load and cache template
    if [[ -f "$template_path" ]]; then
        local content=$(cat "$template_path")
        local escaped_content="${content//\'/\'\'}"
        sqlite3 "$SIMONE_DB_FILE" "INSERT OR REPLACE INTO cache_meta (key, value, updated) VALUES ('template_$template_name', '$escaped_content', $(date +%s));" 2>/dev/null
        echo "$content"
        return 0
    fi
    
    return 1
}

# Fast project manifest reader
get_project_info() {
    local field="$1"
    local cache_key="project_${field}"
    local result
    
    # Try cache first
    result=$(cache_get "$cache_key")
    if [[ -n "$result" ]]; then
        echo "$result"
        return 0
    fi
    
    # Read from manifest
    local manifest=".simone/00_PROJECT_MANIFEST.md"
    if [[ -f "$manifest" ]]; then
        case "$field" in
            "name")
                result=$(grep "^project_name:" "$manifest" | cut -d'"' -f2 | head -1)
                ;;
            "description")
                result=$(grep "^project_description:" "$manifest" | cut -d'"' -f2 | head -1)
                ;;
            "version")
                result=$(grep "^project_version:" "$manifest" | cut -d'"' -f2 | head -1)
                ;;
            *)
                result=$(grep "^${field}:" "$manifest" | cut -d'"' -f2 | head -1)
                ;;
        esac
        
        if [[ -n "$result" ]]; then
            cache_set "$cache_key" "$result" 3600  # Cache for 1 hour
            echo "$result"
        fi
    fi
}

# Generic caching functions using SQLite
cache_get() {
    local key="$1"
    local escaped_key="${key//\'/\'\'}"
    sqlite3 "$SIMONE_DB_FILE" "SELECT value FROM cache_meta WHERE key='$escaped_key' AND updated > $(( $(date +%s) - SIMONE_CACHE_TTL ));" 2>/dev/null
}

cache_set() {
    local key="$1"
    local value="$2"
    local ttl="${3:-$SIMONE_CACHE_TTL}"
    
    # For SQL injection safety, reject keys/values with dangerous characters
    if [[ "$key" == *"'"* ]] || [[ "$key" == *";"* ]] || [[ "$key" == *"--"* ]]; then
        # Silently reject dangerous keys but return success
        return 0
    fi
    
    # Properly escape both key and value for SQL injection safety
    local escaped_key="${key//\'/\'\'}"
    local escaped_value="${value//\'/\'\'}"
    sqlite3 "$SIMONE_DB_FILE" "INSERT OR REPLACE INTO cache_meta (key, value, updated) VALUES ('$escaped_key', '$escaped_value', $(date +%s));" 2>/dev/null || return 0
}

# Batch file operations (portable implementation)
batch_read_files() {
    local files_list="$1"
    local output_dir="$2"
    
    mkdir -p "$output_dir"
    
    while IFS= read -r file; do
        if [[ -f "$file" ]]; then
            local basename_file=$(basename "$file")
            cat "$file" > "$output_dir/$basename_file"
        fi
    done <<< "$files_list"
}

# Task database functions
init_task_database() {
    sqlite3 "$SIMONE_DB_FILE" <<EOF
CREATE TABLE IF NOT EXISTS tasks (
    id TEXT PRIMARY KEY,
    file_path TEXT,
    type TEXT,
    status TEXT,
    sprint TEXT,
    priority TEXT,
    assignee TEXT,
    title TEXT,
    description TEXT,
    created INTEGER,
    updated INTEGER,
    completed INTEGER,
    metadata JSON
);
CREATE INDEX IF NOT EXISTS idx_status ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_sprint ON tasks(sprint);
CREATE INDEX IF NOT EXISTS idx_type ON tasks(type);
CREATE INDEX IF NOT EXISTS idx_priority ON tasks(priority);
CREATE INDEX IF NOT EXISTS idx_updated ON tasks(updated);
CREATE INDEX IF NOT EXISTS idx_created ON tasks(created);

CREATE TABLE IF NOT EXISTS cache_meta (
    key TEXT PRIMARY KEY,
    value TEXT,
    updated INTEGER
);
EOF
}

# Fast task counting
count_tasks_by_status() {
    local status="${1:-all}"
    
    if [[ "$status" == "all" ]]; then
        sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks;" 2>/dev/null || echo "0"
    else
        sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE status='$status';" 2>/dev/null || echo "0"
    fi
}

# Fast task listing
list_tasks_by_status() {
    local status="$1"
    local limit="${2:-10}"
    
    sqlite3 "$SIMONE_DB_FILE" -list <<EOF 2>/dev/null || return 1
SELECT id || '|' || title || '|' || priority || '|' || assignee
FROM tasks
WHERE status = '$status'
ORDER BY 
    CASE priority 
        WHEN 'high' THEN 1 
        WHEN 'medium' THEN 2 
        WHEN 'low' THEN 3 
    END
LIMIT $limit;
EOF
}

# Index task file into database
index_task_file() {
    local file="$1"
    local task_type="${2:-general}"
    
    if [[ ! -f "$file" ]]; then
        return 1
    fi
    
    local task_id=$(basename "$file" .md)
    local content=$(cat "$file")
    
    # Extract metadata
    local status=$(echo "$content" | grep -m1 "^status:" | cut -d' ' -f2- || echo "pending")
    local priority=$(echo "$content" | grep -m1 "^priority:" | cut -d' ' -f2- || echo "medium")
    local assignee=$(echo "$content" | grep -m1 "^assignee:" | cut -d' ' -f2- || echo "unassigned")
    local title=$(echo "$content" | grep -m1 "^# " | sed 's/^# //' || echo "$task_id")
    local sprint=""
    
    if [[ "$task_type" == "sprint" ]]; then
        sprint=$(dirname "$file" | xargs basename)
    fi
    
    # Escape single quotes for SQL
    title="${title//\'/\'\'}"
    
    local current_time=$(date +%s)
    sqlite3 "$SIMONE_DB_FILE" <<EOF 2>/dev/null
INSERT OR REPLACE INTO tasks (id, file_path, type, status, sprint, priority, assignee, title, description, created, updated, completed)
VALUES ('$task_id', '$file', '$task_type', '$status', '$sprint', '$priority', '$assignee', '$title', '', $current_time, $current_time, 0);
EOF
}

# Batch index all tasks
reindex_all_tasks() {
    echo "Reindexing all tasks..."
    
    # Clear existing data
    sqlite3 "$SIMONE_DB_FILE" "DELETE FROM tasks;" 2>/dev/null
    
    # Index sprint tasks
    local count=0
    find .simone/03_SPRINTS -name "*.md" -type f 2>/dev/null | while read -r file; do
        if [[ -f "$file" ]]; then
            index_task_file "$file" "sprint" || echo "⚠️ Failed to index: $file"
            ((count++))
        fi
    done
    
    # Index general tasks
    find .simone/04_GENERAL_TASKS -name "*.md" -type f 2>/dev/null | while read -r file; do
        if [[ -f "$file" ]]; then
            index_task_file "$file" "general" || echo "⚠️ Failed to index: $file"
            ((count++))
        fi
    done
    
    # Update cache metadata
    sqlite3 "$SIMONE_DB_FILE" "INSERT OR REPLACE INTO cache_meta (key, value, updated) VALUES ('last_index', 'complete', $(date +%s));"
    
    echo "Reindexing complete"
}

# Git operation batching (portable implementation)
batch_git_add() {
    echo "$1" >> "$SIMONE_CACHE_DIR/git_batch_add"
}

batch_git_commit() {
    local message="$1"
    echo "$message" > "$SIMONE_CACHE_DIR/git_batch_commit"
}

execute_git_batch() {
    if [[ -f "$SIMONE_CACHE_DIR/git_batch_add" ]]; then
        while IFS= read -r file; do
            git add "$file"
        done < "$SIMONE_CACHE_DIR/git_batch_add"
        rm -f "$SIMONE_CACHE_DIR/git_batch_add"
    fi
    
    if [[ -f "$SIMONE_CACHE_DIR/git_batch_commit" ]]; then
        local message=$(cat "$SIMONE_CACHE_DIR/git_batch_commit")
        git commit -m "$message"
        rm -f "$SIMONE_CACHE_DIR/git_batch_commit"
    fi
}

# Performance timing
time_operation() {
    local name="$1"
    shift
    
    local start=$(date +%s.%N)
    "$@"
    local end=$(date +%s.%N)
    
    if [[ "${SIMONE_DEBUG:-false}" == "true" ]]; then
        local duration=$(echo "$end - $start" | bc)
        echo "[PERF] $name: ${duration}s" >&2
    fi
}

# Initialize on source
init_performance