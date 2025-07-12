#!/usr/bin/env bash
# Fast command implementations for Simone
# Source this file to get optimized versions of common commands

# Source the performance optimizer
source "$(dirname "${BASH_SOURCE[0]}")/performance-optimizer.sh"

# Fast status command
fast_status() {
    init_performance
    
    echo "=== Simone Status (Optimized) ==="
    echo
    
    # Get project info from cache
    local project_name=$(get_project_info "name")
    if [[ -n "$project_name" ]]; then
        echo "📁 Project: $project_name"
        echo
    fi
    
    # Get task counts from database
    if [[ -f "$SIMONE_DB_FILE" ]]; then
        local pending=$(count_tasks_by_status "pending")
        local in_progress=$(count_tasks_by_status "in_progress")
        local completed=$(count_tasks_by_status "completed")
        local total=$((pending + in_progress + completed))
        
        echo "📊 Task Summary:"
        echo "  Pending:     $pending"
        echo "  In Progress: $in_progress"
        echo "  Completed:   $completed"
        echo "  Total:       $total"
        
        if [[ $total -gt 0 ]]; then
            local completion_rate=$(( (completed * 100) / total ))
            echo "  Completion:  ${completion_rate}%"
        fi
        echo
        
        # Show active tasks
        if [[ $in_progress -gt 0 ]]; then
            echo "🔄 Tasks In Progress:"
            list_tasks_by_status "in_progress" 5 | while IFS='|' read -r id title priority assignee; do
                printf "  - [%s] %s\n" "$id" "$title"
                printf "    Priority: %s | Assignee: %s\n" "$priority" "$assignee"
            done
            echo
        fi
        
        # Show high priority pending tasks
        local high_priority=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE status='pending' AND priority='high';" 2>/dev/null || echo "0")
        if [[ $high_priority -gt 0 ]]; then
            echo "⚡ High Priority Tasks:"
            sqlite3 "$SIMONE_DB_FILE" -list "SELECT id || '|' || title || '|' || assignee FROM tasks WHERE status='pending' AND priority='high' ORDER BY updated DESC LIMIT 5;" 2>/dev/null | while IFS='|' read -r id title assignee; do
                printf "  - [%s] %s (Assignee: %s)\n" "$id" "$title" "$assignee"
            done
            echo
        fi
        
        # Show active sprint
        local active_sprint=$(sqlite3 "$SIMONE_DB_FILE" "SELECT DISTINCT sprint FROM tasks WHERE sprint != '' AND status != 'completed' ORDER BY sprint DESC LIMIT 1;" 2>/dev/null)
        if [[ -n "$active_sprint" ]]; then
            echo "🏃 Active Sprint: $active_sprint"
            local sprint_total=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE sprint='$active_sprint';" 2>/dev/null || echo "0")
            local sprint_completed=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE sprint='$active_sprint' AND status='completed';" 2>/dev/null || echo "0")
            if [[ $sprint_total -gt 0 ]]; then
                local sprint_progress=$(( (sprint_completed * 100) / sprint_total ))
                echo "  Progress: ${sprint_completed}/${sprint_total} tasks (${sprint_progress}%)"
            fi
        fi
    else
        # Fallback to file-based counting
        echo "📊 Task Summary (file-based):"
        local task_count=$(find .simone -name "*.md" -type f 2>/dev/null | wc -l)
        echo "  Total files: $task_count"
    fi
}

# Fast task search
fast_search() {
    local query="$1"
    init_performance
    
    if [[ -z "$query" ]]; then
        echo "Usage: fast_search <query>"
        return 1
    fi
    
    echo "🔍 Searching for: $query"
    echo
    
    if [[ -f "$SIMONE_DB_FILE" ]]; then
        # Search in database
        local results=$(sqlite3 "$SIMONE_DB_FILE" -list <<EOF 2>/dev/null
SELECT COUNT(*) FROM tasks 
WHERE title LIKE '%$query%' 
   OR id LIKE '%$query%' 
   OR file_path LIKE '%$query%';
EOF
)
        
        if [[ "$results" == "0" ]]; then
            echo "No tasks found matching '$query'"
            return 1
        fi
        
        echo "Found $results matching tasks:"
        echo
        
        sqlite3 "$SIMONE_DB_FILE" -column -header <<EOF 2>/dev/null
SELECT 
    substr(id, 1, 20) as "Task ID",
    substr(title, 1, 50) as "Title",
    status as "Status",
    type as "Type"
FROM tasks 
WHERE title LIKE '%$query%' 
   OR id LIKE '%$query%' 
   OR file_path LIKE '%$query%'
ORDER BY 
    CASE 
        WHEN title LIKE '$query%' THEN 1
        WHEN id LIKE '$query%' THEN 2
        ELSE 3
    END,
    updated DESC
LIMIT 20;
EOF
    else
        # Fallback to grep
        echo "Searching in files..."
        grep -r "$query" .simone --include="*.md" 2>/dev/null | head -20
    fi
}

# Fast task creation with caching
fast_create_task() {
    local task_type="${1:-general}"
    local task_title="${2:-New Task}"
    local task_priority="${3:-medium}"
    local task_assignee="${4:-unassigned}"
    
    init_performance
    
    # Generate task ID
    local timestamp=$(date +%Y%m%d%H%M%S)
    local task_id="TASK-${timestamp}"
    
    # Determine directory
    local task_dir=".simone/04_GENERAL_TASKS"
    if [[ "$task_type" == "sprint" ]]; then
        # Find active sprint
        local active_sprint=$(find .simone/03_SPRINTS -type d -name "SPRINT-*" | sort -r | head -1)
        if [[ -n "$active_sprint" ]]; then
            task_dir="$active_sprint"
        else
            echo "❌ No active sprint found. Creating general task instead."
            task_type="general"
        fi
    fi
    
    # Get template from cache
    local template_content=$(cache_template "task.md" 2>/dev/null || cat <<EOF
# $task_title

## Task ID: $task_id

### Metadata
- **Status**: pending
- **Priority**: $task_priority
- **Type**: $task_type
- **Assignee**: $task_assignee
- **Created**: $(date +%Y-%m-%d)
- **Updated**: $(date +%Y-%m-%d)

### Description
[Task description here]

### Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

### Notes
[Implementation notes]
EOF
)
    
    # Create task file
    local task_file="${task_dir}/${task_id}.md"
    echo "$template_content" > "$task_file"
    
    # Index immediately
    index_task_file "$task_file" "$task_type"
    
    echo "✅ Created task: $task_id"
    echo "   Type: $task_type"
    echo "   File: $task_file"
}

# Fast dashboard update
fast_dashboard() {
    init_performance
    
    local dashboard_file=".simone/00_PROJECT_MANIFEST/dashboard.md"
    local cache_key="dashboard_content"
    
    # Check if we can use cached version
    if [[ -f "$dashboard_file" ]]; then
        local last_modified=$(stat -f %m "$dashboard_file" 2>/dev/null || stat -c %Y "$dashboard_file" 2>/dev/null)
        local cache_time=$(stat -f %m "$SIMONE_CACHE_DIR/$cache_key" 2>/dev/null || stat -c %Y "$SIMONE_CACHE_DIR/$cache_key" 2>/dev/null || echo "0")
        
        if [[ $cache_time -gt $last_modified ]]; then
            cat "$SIMONE_CACHE_DIR/$cache_key"
            return 0
        fi
    fi
    
    # Generate dashboard
    local content=$(cat <<EOF
# Project Dashboard
*Last Updated: $(date)*

## 📊 Project Overview
$(fast_status)

## 🎯 Quick Actions
- Create Task: \`simone task create\`
- View Status: \`simone status\`
- Search Tasks: \`simone search <query>\`

## 📈 Metrics
- Cache Performance: $(du -sh "$SIMONE_CACHE_DIR" 2>/dev/null | cut -f1 || echo "N/A")
- Database Size: $(du -sh "$SIMONE_DB_FILE" 2>/dev/null | cut -f1 || echo "N/A")
EOF
)
    
    # Cache the result
    cache_set "$cache_key" "$content" 3600
    
    echo "$content"
}

# Fast sprint management
fast_sprint_status() {
    local sprint_id="${1:-active}"
    init_performance
    
    if [[ "$sprint_id" == "active" ]]; then
        # Find active sprint
        sprint_id=$(sqlite3 "$SIMONE_DB_FILE" "SELECT DISTINCT sprint FROM tasks WHERE sprint != '' ORDER BY sprint DESC LIMIT 1;" 2>/dev/null)
        if [[ -z "$sprint_id" ]]; then
            echo "❌ No active sprint found"
            return 1
        fi
    fi
    
    echo "🏃 Sprint: $sprint_id"
    echo
    
    # Get sprint statistics
    local total=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE sprint='$sprint_id';" 2>/dev/null || echo "0")
    local completed=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE sprint='$sprint_id' AND status='completed';" 2>/dev/null || echo "0")
    local in_progress=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE sprint='$sprint_id' AND status='in_progress';" 2>/dev/null || echo "0")
    local pending=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks WHERE sprint='$sprint_id' AND status='pending';" 2>/dev/null || echo "0")
    
    echo "📊 Sprint Statistics:"
    echo "  Total Tasks:  $total"
    echo "  Completed:    $completed"
    echo "  In Progress:  $in_progress"
    echo "  Pending:      $pending"
    
    if [[ $total -gt 0 ]]; then
        local progress=$(( (completed * 100) / total ))
        echo "  Progress:     ${progress}%"
        
        # Progress bar
        echo -n "  ["
        local bar_length=20
        local filled=$(( (progress * bar_length) / 100 ))
        for ((i=0; i<filled; i++)); do echo -n "="; done
        for ((i=filled; i<bar_length; i++)); do echo -n " "; done
        echo "]"
    fi
    echo
    
    # Show sprint tasks by status
    if [[ $in_progress -gt 0 ]]; then
        echo "🔄 In Progress:"
        sqlite3 "$SIMONE_DB_FILE" -list "SELECT id || '|' || substr(title, 1, 40) || '|' || assignee FROM tasks WHERE sprint='$sprint_id' AND status='in_progress' ORDER BY priority='high' DESC, priority='medium' DESC;" 2>/dev/null | while IFS='|' read -r id title assignee; do
            printf "  - [%s] %s (Assignee: %s)\n" "$id" "$title" "$assignee"
        done
        echo
    fi
    
    if [[ $pending -gt 0 ]]; then
        echo "⏳ Pending (Top 5):"
        sqlite3 "$SIMONE_DB_FILE" -list "SELECT id || '|' || substr(title, 1, 40) || '|' || priority FROM tasks WHERE sprint='$sprint_id' AND status='pending' ORDER BY priority='high' DESC, priority='medium' DESC LIMIT 5;" 2>/dev/null | while IFS='|' read -r id title priority; do
            printf "  - [%s] %s (Priority: %s)\n" "$id" "$title" "$priority"
        done
    fi
}