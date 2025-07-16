#!/usr/bin/env bash
# Fast command implementations for Simone
# Simplified to rely on Serena MCP for IO operations

# Fast status command - simple file-based
fast_status() {
    echo "=== Simone Status ==="
    echo
    
    # Basic project info
    if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
        local project_name=$(grep "^project_name:" ".simone/00_PROJECT_MANIFEST.md" | cut -d'"' -f2 2>/dev/null)
        if [[ -n "$project_name" ]]; then
            echo "📁 Project: $project_name"
            echo
        fi
    fi
    
    # Simple task counts from files
    echo "📊 Task Summary (file-based):"
    local total_files=$(find .simone -path "*/0[34]_*" -name "*.md" -type f 2>/dev/null | wc -l)
    local pending_files=$(grep -l "^status: pending" .simone/0[34]_*/*.md 2>/dev/null | wc -l)
    local progress_files=$(grep -l "^status: in_progress" .simone/0[34]_*/*.md 2>/dev/null | wc -l)
    local completed_files=$(grep -l "^status: completed" .simone/0[34]_*/*.md 2>/dev/null | wc -l)
    
    echo "  Total Tasks:  $total_files"
    echo "  Pending:      $pending_files"
    echo "  In Progress:  $progress_files"
    echo "  Completed:    $completed_files"
    
    if [[ $total_files -gt 0 ]]; then
        local completion_rate=$(( (completed_files * 100) / total_files ))
        echo "  Completion:   ${completion_rate}%"
    fi
}

# Fast task search - simple grep
fast_search() {
    local query="$1"
    
    if [[ -z "$query" ]]; then
        echo "Usage: fast_search <query>"
        return 1
    fi
    
    echo "🔍 Searching for: $query"
    echo
    
    # Simple grep search
    echo "Found in task files:"
    grep -r "$query" .simone/0[34]_* --include="*.md" 2>/dev/null | head -10
}

# Fast dashboard - simple overview
fast_dashboard() {
    echo "# Project Dashboard"
    echo "*Last Updated: $(date)*"
    echo
    echo "## 📊 Project Overview"
    fast_status
    echo
    echo "## 🎯 Quick Actions"
    echo "- Create Task: \`simone task create\`"
    echo "- View Status: \`simone status\`"
    echo "- Search Tasks: \`simone search <query>\`"
}

# Fast sprint status - simple file listing
fast_sprint_status() {
    local sprint_name="${1}"
    
    if [[ -z "$sprint_name" ]]; then
        echo "Active sprints:"
        find .simone/03_SPRINTS -type d -name "S*" 2>/dev/null | sort
        return 0
    fi
    
    echo "🏃 Sprint: $sprint_name"
    echo
    
    # Find sprint directory
    local sprint_dir=$(find .simone/03_SPRINTS -type d -name "*$sprint_name*" | head -1)
    if [[ -z "$sprint_dir" ]]; then
        echo "❌ Sprint not found: $sprint_name"
        return 1
    fi
    
    # Count tasks in sprint
    local total=$(find "$sprint_dir" -name "*.md" -not -name "*meta*" -type f 2>/dev/null | wc -l)
    local completed=$(grep -l "^status: completed" "$sprint_dir"/*.md 2>/dev/null | wc -l)
    local in_progress=$(grep -l "^status: in_progress" "$sprint_dir"/*.md 2>/dev/null | wc -l)
    local pending=$(grep -l "^status: pending" "$sprint_dir"/*.md 2>/dev/null | wc -l)
    
    echo "📊 Sprint Statistics:"
    echo "  Total Tasks:  $total"
    echo "  Completed:    $completed"
    echo "  In Progress:  $in_progress"
    echo "  Pending:      $pending"
    
    if [[ $total -gt 0 ]]; then
        local progress=$(( (completed * 100) / total ))
        echo "  Progress:     ${progress}%"
    fi
}