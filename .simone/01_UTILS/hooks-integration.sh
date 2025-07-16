#!/usr/bin/env bash
# Claude Code Hooks Integration for Simone
# Simplified to avoid MCP conflicts - basic file operations only

# Hook configuration - no complex caching
HOOKS_LOG=".simone/.temp/hooks.log"

# Initialize hooks system
init_hooks() {
    mkdir -p "$(dirname "$HOOKS_LOG")"
    echo "✅ Simple hooks system initialized"
}

# Log hook execution
log_hook() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$HOOKS_LOG"
}

# Post Write/Edit hook - simplified
post_file_change_hook() {
    local file_path="$1"
    local operation="${2:-edit}"
    
    log_hook "POST_${operation^^}: $file_path"
    
    # Basic validation only
    if [[ -f "$file_path" ]]; then
        echo "✅ File updated: $file_path"
    fi
}

# Pre-commit hook - minimal
pre_commit_hook() {
    local commit_message="$1"
    
    log_hook "PRE_COMMIT: Starting"
    
    # Just pass through the commit message
    echo "$commit_message"
}

# Post-commit hook - minimal
post_commit_hook() {
    log_hook "POST_COMMIT: Completed"
    echo "✅ Commit completed"
}

# Session stop hook - simple cleanup
session_stop_hook() {
    log_hook "SESSION_STOP: Starting cleanup"
    
    # Clean up only temporary files
    find .simone -name "*.tmp" -type f -mtime +1 -delete 2>/dev/null || true
    find .simone -name "*.bak" -type f -mtime +1 -delete 2>/dev/null || true
    
    echo "✅ Simple session cleanup completed"
}

# Hook registration helper
register_hooks() {
    cat <<EOF
# Claude Code Hook Configuration (Simplified)
# Add these to your .claude/settings.json:

{
  "hooks": {
    "PostToolUse": {
      "Write": ".simone/01_UTILS/hooks-integration.sh post-write \"\$TOOL_FILE_PATH\"",
      "Edit": ".simone/01_UTILS/hooks-integration.sh post-edit \"\$TOOL_FILE_PATH\""
    },
    "Stop": ".simone/01_UTILS/hooks-integration.sh stop"
  }
}
EOF
}

# Main command routing
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
            echo "Simone Hooks Integration (Simplified)"
            echo "Usage: $0 {post-write|post-edit|pre-commit|post-commit|stop|register}"
            ;;
    esac
fi