#!/usr/bin/env bash
# Claude Code Hooks Integration for Simone
# Provides automation hooks for Claude Code tool operations

# Source required modules
source "$(dirname "${BASH_SOURCE[0]}")/performance-optimizer.sh"
source "$(dirname "${BASH_SOURCE[0]}")/git-automation.sh"

# Hook configuration
HOOKS_LOG="${SIMONE_CACHE_DIR}/hooks.log"

# Initialize hooks system
init_hooks() {
    mkdir -p "$(dirname "$HOOKS_LOG")"
    echo "✅ Hooks system initialized"
}

# Log hook execution
log_hook() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$HOOKS_LOG"
}

# Post Write/Edit hook
post_file_change_hook() {
    local file_path="$1"
    local operation="${2:-edit}"
    
    log_hook "POST_${operation^^}: $file_path"
    
    # Quality check the file
    quality_check_file "$file_path"
    
    # Add to git batch if it's a tracked file
    if git ls-files --error-unmatch "$file_path" >/dev/null 2>&1 || [[ "$operation" == "write" ]]; then
        batch_git_add "$file_path"
    fi
    
    # Update task database if it's a task file
    if [[ "$file_path" =~ (03_SPRINTS|04_GENERAL_TASKS).*\.md$ ]]; then
        if type index_task_file >/dev/null 2>&1; then
            index_task_file "$file_path"
        fi
    fi
    
    # Update template cache if it's a template
    if [[ "$file_path" =~ 99_TEMPLATES.*\.md$ ]]; then
        if type cache_template >/dev/null 2>&1; then
            cache_template "$(basename "$file_path")"
        fi
    fi
}

# Pre-commit hook
pre_commit_hook() {
    local commit_message="$1"
    
    log_hook "PRE_COMMIT: Starting"
    
    # Execute any pending git batches
    execute_git_batch
    
    # Validate Simone metadata consistency
    validate_simone_metadata
    
    # Generate enhanced commit message
    enhanced_message=$(generate_smart_commit "$commit_message")
    echo "$enhanced_message"
}

# Post-commit hook
post_commit_hook() {
    log_hook "POST_COMMIT: Starting"
    
    # Run post-commit optimizations
    post_commit_optimization
    
    # Clean up temporary files
    cleanup_temp_files
}

# Session stop hook
session_stop_hook() {
    log_hook "SESSION_STOP: Starting cleanup"
    
    # Execute any pending git batches
    execute_git_batch
    
    # Optimize database if needed
    if type optimize_database >/dev/null 2>&1; then
        local task_count=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks;" 2>/dev/null || echo "0")
        if [[ $task_count -gt 100 ]]; then
            optimize_database
        fi
    fi
    
    # Clean up old cache entries
    if type cleanup_cache >/dev/null 2>&1; then
        cleanup_cache
    fi
    
    echo "✅ Session cleanup completed"
}

# Validate Simone metadata
validate_simone_metadata() {
    local issues=0
    
    # Check for orphaned task files
    find .simone -name "TASK_*.md" -type f | while read task_file; do
        if ! grep -q "^status:" "$task_file"; then
            echo "⚠️  Missing status in: $task_file"
            ((issues++))
        fi
    done
    
    # Check for naming convention violations
    find .simone -type f -name "*.md" | while read file; do
        basename "$file" | grep -E "^[0-9]{2}_|^TASK_|^ADR_|^S[0-9]{2}_M[0-9]{2}_" >/dev/null || {
            echo "⚠️  Naming convention violation: $file"
            ((issues++))
        }
    done
    
    if [[ $issues -gt 0 ]]; then
        echo "⚠️  Found $issues metadata issues"
        return 1
    fi
    
    return 0
}

# Clean up temporary files
cleanup_temp_files() {
    local cleaned_count=0
    
    # Clean Simone temporary files
    find .simone -name "*.tmp" -type f -mtime +1 -delete 2>/dev/null && ((cleaned_count++)) || true
    find .simone -name "*.bak" -type f -mtime +1 -delete 2>/dev/null && ((cleaned_count++)) || true
    
    # Clean system temporary files in project
    find . -name ".DS_Store" -type f -delete 2>/dev/null && ((cleaned_count++)) || true
    find . -name "Thumbs.db" -type f -delete 2>/dev/null && ((cleaned_count++)) || true
    
    # Clean empty directories in cache
    find .simone/.cache -type d -empty -delete 2>/dev/null || true
    
    if [ "$cleaned_count" -gt 0 ]; then
        log_hook "CLEANUP: Removed $cleaned_count temporary files"
        echo "✅ Cleaned $cleaned_count temporary files"
    fi
}

# Hook registration helper
register_hooks() {
    cat <<EOF
# Claude Code Hook Configuration
# Add these to your .claude/settings.json or environment:

{
  "hooks": {
    "PostToolUse": {
      "Write": ".simone/01_UTILS/hooks-integration.sh post-write \"\$TOOL_FILE_PATH\"",
      "Edit": ".simone/01_UTILS/hooks-integration.sh post-edit \"\$TOOL_FILE_PATH\"",
      "MultiEdit": ".simone/01_UTILS/hooks-integration.sh post-edit \"\$TOOL_FILE_PATH\""
    },
    "PreCommit": ".simone/01_UTILS/hooks-integration.sh pre-commit",
    "PostCommit": ".simone/01_UTILS/hooks-integration.sh post-commit",
    "Stop": ".simone/01_UTILS/hooks-integration.sh stop"
  }
}
EOF
}

# Main command routing - only execute if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    case "${1:-help}" in
        "post-write")
            post_file_change_hook "$2" "write"
            ;;
        "post-edit")
            post_file_change_hook "$2" "edit"
            ;;
        "pre-commit")
            pre_commit_hook "$2"
            ;;
        "post-commit")
            post_commit_hook
            ;;
        "stop")
            session_stop_hook
            ;;
        "register")
            register_hooks
            ;;
        *)
            echo "Simone Hooks Integration"
            echo "Usage: $0 {post-write|post-edit|pre-commit|post-commit|stop|register}"
            ;;
    esac
fi