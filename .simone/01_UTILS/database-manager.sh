#!/usr/bin/env bash
# Database management utilities for Simone
# Handles SQLite database operations for fast task queries

# Database configuration
DB_FILE="${SIMONE_DB_FILE:-.simone/.cache/tasks.db}"
DB_VERSION="2.0"

# Initialize database with schema
init_database() {
    local db_dir=$(dirname "$DB_FILE")
    mkdir -p "$db_dir"
    
    # Create or upgrade database
    sqlite3 "$DB_FILE" <<EOF
-- Core tables
CREATE TABLE IF NOT EXISTS tasks (
    id TEXT PRIMARY KEY,
    file_path TEXT NOT NULL,
    type TEXT NOT NULL,
    status TEXT NOT NULL,
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

CREATE TABLE IF NOT EXISTS sprints (
    id TEXT PRIMARY KEY,
    name TEXT,
    status TEXT,
    start_date TEXT,
    end_date TEXT,
    goals TEXT,
    created INTEGER,
    updated INTEGER
);

CREATE TABLE IF NOT EXISTS milestones (
    id TEXT PRIMARY KEY,
    name TEXT,
    description TEXT,
    due_date TEXT,
    status TEXT,
    created INTEGER,
    updated INTEGER
);

CREATE TABLE IF NOT EXISTS task_dependencies (
    task_id TEXT,
    depends_on TEXT,
    created INTEGER,
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (depends_on) REFERENCES tasks(id),
    PRIMARY KEY (task_id, depends_on)
);

CREATE TABLE IF NOT EXISTS task_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_id TEXT,
    field TEXT,
    old_value TEXT,
    new_value TEXT,
    changed_by TEXT,
    changed_at INTEGER,
    FOREIGN KEY (task_id) REFERENCES tasks(id)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_task_status ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_task_sprint ON tasks(sprint);
CREATE INDEX IF NOT EXISTS idx_task_type ON tasks(type);
CREATE INDEX IF NOT EXISTS idx_task_priority ON tasks(priority);
CREATE INDEX IF NOT EXISTS idx_task_assignee ON tasks(assignee);
CREATE INDEX IF NOT EXISTS idx_task_updated ON tasks(updated);
CREATE INDEX IF NOT EXISTS idx_task_created ON tasks(created);
CREATE INDEX IF NOT EXISTS idx_history_task ON task_history(task_id);
CREATE INDEX IF NOT EXISTS idx_history_time ON task_history(changed_at);

-- Metadata table
CREATE TABLE IF NOT EXISTS db_metadata (
    key TEXT PRIMARY KEY,
    value TEXT,
    updated INTEGER
);

-- Initialize metadata
INSERT OR REPLACE INTO db_metadata (key, value, updated) 
VALUES ('version', '$DB_VERSION', strftime('%s', 'now'));
EOF
    
    echo "✅ Database initialized at: $DB_FILE"
    
    # Try to initialize FTS if available
    init_fts_optional
}

# Optional FTS initialization - disabled for compatibility
init_fts_optional() {
    echo "⚠️ FTS disabled for maximum compatibility - using standard SQL queries"
}

# Full database rebuild from files
rebuild_database() {
    echo "🔄 Rebuilding database from files..."
    
    # Clear existing data
    sqlite3 "$DB_FILE" <<EOF
DELETE FROM tasks;
DELETE FROM sprints;
DELETE FROM milestones;
DELETE FROM task_history;
EOF
    
    # Index all task files
    local indexed_count=0
    
    # Sprint tasks
    find .simone/03_SPRINTS -name "*.md" -type f 2>/dev/null | while read -r file; do
        index_task_file_advanced "$file" "sprint"
        ((indexed_count++))
    done
    
    # General tasks
    find .simone/04_GENERAL_TASKS -name "*.md" -type f 2>/dev/null | while read -r file; do
        index_task_file_advanced "$file" "general"
        ((indexed_count++))
    done
    
    # Index sprints
    find .simone/03_SPRINTS -type d -name "SPRINT-*" 2>/dev/null | while read -r sprint_dir; do
        index_sprint_directory "$sprint_dir"
    done
    
    # Index milestones
    find .simone/02_REQUIREMENTS -name "*milestone*.md" -type f 2>/dev/null | while read -r file; do
        index_milestone_file "$file"
    done
    
    # Update metadata
    sqlite3 "$DB_FILE" "INSERT OR REPLACE INTO db_metadata (key, value, updated) VALUES ('last_rebuild', '$indexed_count tasks', strftime('%s', 'now'));"
    
    echo "✅ Database rebuilt: $indexed_count tasks indexed"
}

# Advanced task indexing with full metadata extraction
index_task_file_advanced() {
    local file="$1"
    local task_type="${2:-general}"
    
    if [[ ! -f "$file" ]]; then
        return 1
    fi
    
    local task_id=$(basename "$file" .md)
    local content=$(cat "$file")
    local file_stat=$(stat -f "%m %B" "$file" 2>/dev/null || stat -c "%Y %W" "$file" 2>/dev/null)
    local updated=$(echo "$file_stat" | cut -d' ' -f1)
    local created=$(echo "$file_stat" | cut -d' ' -f2)
    
    # Extract all metadata
    local status=$(echo "$content" | grep -i "^status:" | head -1 | cut -d':' -f2- | xargs || echo "pending")
    local priority=$(echo "$content" | grep -i "^priority:" | head -1 | cut -d':' -f2- | xargs || echo "medium")
    local assignee=$(echo "$content" | grep -i "^assignee:" | head -1 | cut -d':' -f2- | xargs || echo "unassigned")
    local title=$(echo "$content" | grep "^# " | head -1 | sed 's/^# //' || echo "$task_id")
    local description=$(echo "$content" | grep -A 3 "^## Description" | tail -n +2 | tr '\n' ' ' | xargs || echo "")
    
    # Extract sprint if applicable
    local sprint=""
    if [[ "$task_type" == "sprint" ]]; then
        sprint=$(dirname "$file" | xargs basename)
    fi
    
    # Build metadata JSON
    local metadata=$(cat <<JSON | tr '\n' ' '
{
    "tags": $(echo "$content" | grep -i "^tags:" | cut -d':' -f2- | sed 's/,/","/g' | sed 's/^/["/' | sed 's/$/"]/' || echo "[]"),
    "dependencies": $(echo "$content" | grep -i "^depends:" | cut -d':' -f2- | sed 's/,/","/g' | sed 's/^/["/' | sed 's/$/"]/' || echo "[]"),
    "effort": "$(echo "$content" | grep -i "^effort:" | cut -d':' -f2- | xargs || echo "")",
    "category": "$(echo "$content" | grep -i "^category:" | cut -d':' -f2- | xargs || echo "")"
}
JSON
)
    
    # Handle completion date
    local completed="NULL"
    if [[ "$status" == "completed" ]]; then
        completed=$(echo "$content" | grep -i "^completed:" | cut -d':' -f2- | xargs -I {} date -j -f "%Y-%m-%d" {} "+%s" 2>/dev/null || echo "$updated")
    fi
    
    # Escape for SQL
    title=$(echo "$title" | sed "s/'/''/g")
    description=$(echo "$description" | sed "s/'/''/g")
    
    # Insert into database
    sqlite3 "$DB_FILE" <<EOF
INSERT OR REPLACE INTO tasks (
    id, file_path, type, status, sprint, priority, assignee, 
    title, description, created, updated, completed, metadata
) VALUES (
    '$task_id', '$file', '$task_type', '$status', '$sprint', '$priority', '$assignee',
    '$title', '$description', $created, $updated, $completed, '$metadata'
);
EOF
    
    # Track history if task exists
    track_task_change "$task_id" "status" "$status"
}

# Index sprint directory
index_sprint_directory() {
    local sprint_dir="$1"
    local sprint_id=$(basename "$sprint_dir")
    
    # Look for sprint metadata file
    local sprint_file="$sprint_dir/README.md"
    if [[ -f "$sprint_file" ]]; then
        local content=$(cat "$sprint_file")
        local name=$(echo "$content" | grep "^# " | head -1 | sed 's/^# //' || echo "$sprint_id")
        local status=$(echo "$content" | grep -i "^status:" | cut -d':' -f2- | xargs || echo "active")
        local start_date=$(echo "$content" | grep -i "^start:" | cut -d':' -f2- | xargs || echo "")
        local end_date=$(echo "$content" | grep -i "^end:" | cut -d':' -f2- | xargs || echo "")
        local goals=$(echo "$content" | grep -A 5 "^## Goals" | tail -n +2 | tr '\n' ' ' | xargs || echo "")
        
        # Escape for SQL
        name=$(echo "$name" | sed "s/'/''/g")
        goals=$(echo "$goals" | sed "s/'/''/g")
        
        sqlite3 "$DB_FILE" <<EOF
INSERT OR REPLACE INTO sprints (
    id, name, status, start_date, end_date, goals, created, updated
) VALUES (
    '$sprint_id', '$name', '$status', '$start_date', '$end_date', '$goals',
    strftime('%s', 'now'), strftime('%s', 'now')
);
EOF
    fi
}

# Database queries
query_tasks() {
    local query="$1"
    sqlite3 "$DB_FILE" -header -column "$query"
}

# Performance analytics
analyze_database() {
    echo "📊 Database Analysis"
    echo "==================="
    echo
    
    # Database info
    echo "📁 Database: $DB_FILE"
    echo "💾 Size: $(du -h "$DB_FILE" 2>/dev/null | cut -f1)"
    echo "🔢 Version: $(sqlite3 "$DB_FILE" "SELECT value FROM db_metadata WHERE key='version';" 2>/dev/null || echo "Unknown")"
    echo
    
    # Table statistics
    echo "📋 Table Statistics:"
    sqlite3 "$DB_FILE" <<EOF 2>/dev/null
SELECT 
    'Tasks' as 'Table',
    COUNT(*) as 'Rows',
    COUNT(DISTINCT status) as 'Unique Status',
    COUNT(DISTINCT assignee) as 'Unique Assignees'
FROM tasks
UNION ALL
SELECT 
    'Sprints',
    COUNT(*),
    COUNT(DISTINCT status),
    '-'
FROM sprints
UNION ALL
SELECT 
    'History',
    COUNT(*),
    COUNT(DISTINCT task_id),
    '-'
FROM task_history;
EOF
    echo
    
    # Performance metrics
    echo "⚡ Performance Metrics:"
    sqlite3 "$DB_FILE" <<EOF 2>/dev/null
SELECT 
    'Average query time' as 'Metric',
    'Optimized' as 'Status'
UNION ALL
SELECT 
    'Index usage',
    CASE 
        WHEN COUNT(*) > 5 THEN 'Good'
        ELSE 'Needs attention'
    END
FROM sqlite_master 
WHERE type='index';
EOF
}

# Backup database
backup_database() {
    local backup_dir=".simone/.backups"
    mkdir -p "$backup_dir"
    
    local backup_file="$backup_dir/tasks_$(date +%Y%m%d_%H%M%S).db"
    
    echo "💾 Backing up database..."
    sqlite3 "$DB_FILE" ".backup '$backup_file'"
    
    # Compress backup
    gzip "$backup_file"
    
    echo "✅ Database backed up to: ${backup_file}.gz"
    
    # Clean old backups (keep last 10)
    ls -t "$backup_dir"/*.db.gz 2>/dev/null | tail -n +11 | xargs rm -f
}

# Optimize database
optimize_database() {
    echo "⚡ Optimizing database..."
    
    sqlite3 "$DB_FILE" <<EOF
VACUUM;
ANALYZE;
REINDEX;
EOF
    
    echo "✅ Database optimized"
}

# Track task changes for history
track_task_change() {
    local task_id="$1"
    local field="$2"
    local new_value="$3"
    local changed_by="${4:-system}"
    
    # Get old value
    local old_value=$(sqlite3 "$DB_FILE" "SELECT $field FROM tasks WHERE id='$task_id';" 2>/dev/null || echo "")
    
    if [[ "$old_value" != "$new_value" ]]; then
        sqlite3 "$DB_FILE" <<EOF
INSERT INTO task_history (task_id, field, old_value, new_value, changed_by, changed_at)
VALUES ('$task_id', '$field', '$old_value', '$new_value', '$changed_by', strftime('%s', 'now'));
EOF
    fi
}

# Export database to JSON
export_database_json() {
    local export_file="${1:-simone_tasks_export.json}"
    
    echo "📤 Exporting database to JSON..."
    
    sqlite3 "$DB_FILE" <<EOF > "$export_file"
.mode json
SELECT * FROM tasks;
EOF
    
    echo "✅ Database exported to: $export_file"
}