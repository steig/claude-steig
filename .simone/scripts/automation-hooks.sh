#!/bin/bash

# Automation Hooks for Simone Framework
# Provides intelligent automation for Git operations, cleanup, and optimization

set -e

# Configuration
AUTOMATION_DIR=".simone/.cache/automation"
AUTOMATION_LOG="$AUTOMATION_DIR/automation.log"
GIT_BATCH_FILE="$AUTOMATION_DIR/git_batch.tmp"
CLEANUP_LOG="$AUTOMATION_DIR/cleanup.log"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Logging function
log_automation() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$AUTOMATION_LOG"
}

# Initialize automation system
init_automation() {
    mkdir -p "$AUTOMATION_DIR"
    log_automation "Automation system initialized"
    echo -e "${GREEN}✓${NC} Automation system initialized"
}

# Batch Git operations for efficiency
batch_git_add() {
    local file_path="$1"
    
    # Add to batch file instead of immediate execution
    echo "$file_path" >> "$GIT_BATCH_FILE"
    log_automation "File queued for batch add: $file_path"
    
    # If batch file gets large, execute immediately
    local batch_size=$(wc -l < "$GIT_BATCH_FILE" 2>/dev/null || echo 0)
    if [ "$batch_size" -ge 10 ]; then
        execute_git_batch
    fi
}

# Execute batched Git operations
execute_git_batch() {
    if [ ! -f "$GIT_BATCH_FILE" ] || [ ! -s "$GIT_BATCH_FILE" ]; then
        return 0
    fi
    
    echo -e "${BLUE}[INFO]${NC} Executing batched Git operations..."
    
    # Sort and deduplicate files
    sort "$GIT_BATCH_FILE" | uniq > "${GIT_BATCH_FILE}.sorted"
    mv "${GIT_BATCH_FILE}.sorted" "$GIT_BATCH_FILE"
    
    # Add all files in batch
    local file_count=$(wc -l < "$GIT_BATCH_FILE")
    
    if [ "$file_count" -gt 0 ]; then
        # Use xargs for efficient bulk operations
        xargs git add < "$GIT_BATCH_FILE"
        log_automation "Batch Git add completed: $file_count files"
        echo -e "${GREEN}✓${NC} Added $file_count files to staging area"
        
        # Clear batch file
        > "$GIT_BATCH_FILE"
    fi
}

# Smart commit message generation
generate_smart_commit() {
    local base_message="$1"
    local enhanced_message=""
    
    # Analyze staged changes
    local added_files=$(git diff --cached --name-only --diff-filter=A | wc -l)
    local modified_files=$(git diff --cached --name-only --diff-filter=M | wc -l)
    local deleted_files=$(git diff --cached --name-only --diff-filter=D | wc -l)
    
    # Detect file types
    local md_changes=$(git diff --cached --name-only | grep -c "\.md$" || echo 0)
    local script_changes=$(git diff --cached --name-only | grep -c "\.sh$" || echo 0)
    local template_changes=$(git diff --cached --name-only | grep -c "template" || echo 0)
    
    # Build enhanced commit message
    enhanced_message="$base_message"
    
    if [ "$added_files" -gt 0 ] || [ "$modified_files" -gt 0 ] || [ "$deleted_files" -gt 0 ]; then
        enhanced_message="$enhanced_message

📊 Changes summary:
"
        [ "$added_files" -gt 0 ] && enhanced_message="$enhanced_message- ➕ $added_files new files
"
        [ "$modified_files" -gt 0 ] && enhanced_message="$enhanced_message- ✏️  $modified_files modified files
"
        [ "$deleted_files" -gt 0 ] && enhanced_message="$enhanced_message- 🗑️  $deleted_files deleted files
"
    fi
    
    # Add file type insights
    if [ "$md_changes" -gt 0 ] || [ "$script_changes" -gt 0 ] || [ "$template_changes" -gt 0 ]; then
        enhanced_message="$enhanced_message
🔧 Component changes:
"
        [ "$md_changes" -gt 0 ] && enhanced_message="$enhanced_message- 📝 Documentation: $md_changes files
"
        [ "$script_changes" -gt 0 ] && enhanced_message="$enhanced_message- ⚙️ Scripts: $script_changes files
"
        [ "$template_changes" -gt 0 ] && enhanced_message="$enhanced_message- 📋 Templates: $template_changes files
"
    fi
    
    echo "$enhanced_message"
}

# Automated post-commit optimizations
post_commit_optimization() {
    echo -e "${BLUE}[INFO]${NC} Running post-commit optimizations..."
    
    # Update performance cache if templates changed
    if git diff --name-only HEAD~1 HEAD | grep -q "99_TEMPLATES"; then
        echo -e "${YELLOW}⚡${NC} Templates changed, refreshing cache..."
        ./scripts/performance-cache.sh templates 2>/dev/null || true
        log_automation "Template cache refreshed after commit"
    fi
    
    # Update project context cache if manifest or requirements changed
    if git diff --name-only HEAD~1 HEAD | grep -E "(00_PROJECT_MANIFEST|02_REQUIREMENTS)" | head -1; then
        echo -e "${YELLOW}⚡${NC} Project structure changed, refreshing context cache..."
        ./scripts/performance-cache.sh context 2>/dev/null || true
        log_automation "Context cache refreshed after commit"
    fi
    
    # Clean up temporary files
    cleanup_temp_files
    
    # Log commit statistics
    local commit_hash=$(git rev-parse --short HEAD)
    local files_changed=$(git diff --name-only HEAD~1 HEAD | wc -l)
    log_automation "Post-commit optimization completed for $commit_hash ($files_changed files)"
    
    echo -e "${GREEN}✓${NC} Post-commit optimizations completed"
}

# Intelligent cleanup of temporary files
cleanup_temp_files() {
    local cleaned_count=0
    
    # Clean Simone temporary files
    find .simone -name "*.tmp" -type f -mtime +1 -delete 2>/dev/null && cleaned_count=$((cleaned_count + 1)) || true
    find .simone -name "*.bak" -type f -mtime +1 -delete 2>/dev/null && cleaned_count=$((cleaned_count + 1)) || true
    
    # Clean system temporary files in project
    find . -name ".DS_Store" -type f -delete 2>/dev/null && cleaned_count=$((cleaned_count + 1)) || true
    find . -name "Thumbs.db" -type f -delete 2>/dev/null && cleaned_count=$((cleaned_count + 1)) || true
    
    # Clean empty directories in cache
    find .simone/.cache -type d -empty -delete 2>/dev/null || true
    
    if [ "$cleaned_count" -gt 0 ]; then
        log_automation "Cleanup completed: $cleaned_count temporary files removed"
        echo -e "${GREEN}✓${NC} Cleaned $cleaned_count temporary files"
    fi
}

# Smart branch management
optimize_branches() {
    echo -e "${BLUE}[INFO]${NC} Optimizing branch management..."
    
    # Clean up merged branches (except main/master)
    local current_branch=$(git branch --show-current)
    local main_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@' 2>/dev/null || echo "main")
    
    # Find merged branches
    local merged_branches=$(git branch --merged "$main_branch" | grep -v "\*\|$main_branch\|master" | tr -d ' ' || true)
    
    if [ -n "$merged_branches" ]; then
        echo "Merged branches found:"
        echo "$merged_branches" | while read -r branch; do
            if [ -n "$branch" ]; then
                echo "  - $branch"
                # Uncomment the next line to auto-delete merged branches
                # git branch -d "$branch" 2>/dev/null || true
            fi
        done
        echo -e "${YELLOW}💡${NC} Run 'git branch -d <branch>' to clean up merged branches"
    fi
    
    # Clean up remote tracking branches
    git remote prune origin 2>/dev/null || true
    
    log_automation "Branch optimization completed"
}

# Automated quality checks
post_edit_quality_check() {
    local file_path="$1"
    
    # Skip quality checks for cache and temporary files
    if [[ "$file_path" == *".cache"* ]] || [[ "$file_path" == *".tmp"* ]]; then
        return 0
    fi
    
    echo -e "${BLUE}[INFO]${NC} Running quality checks for: $(basename "$file_path")"
    
    # Markdown formatting
    if [[ "$file_path" == *.md ]]; then
        if command -v markdownlint &> /dev/null; then
            if markdownlint --fix "$file_path" 2>/dev/null; then
                log_automation "Markdown formatting applied: $file_path"
                echo -e "${GREEN}✓${NC} Markdown formatting applied"
            fi
        fi
    fi
    
    # Shell script formatting
    if [[ "$file_path" == *.sh ]]; then
        if command -v shfmt &> /dev/null; then
            if shfmt -w "$file_path" 2>/dev/null; then
                log_automation "Shell script formatting applied: $file_path"
                echo -e "${GREEN}✓${NC} Shell script formatting applied"
            fi
        fi
    fi
    
    # Check for secrets (if available)
    if command -v detect-secrets &> /dev/null; then
        if ! detect-secrets scan --string "$file_path" &>/dev/null; then
            echo -e "${RED}⚠${NC} Potential secret detected in: $file_path"
            log_automation "Security warning: potential secret in $file_path"
        fi
    fi
}

# Parallel task coordination
coordinate_parallel_tasks() {
    local task_id="$1"
    local status="$2"
    
    mkdir -p "$AUTOMATION_DIR/parallel"
    
    case "$status" in
        "start")
            echo "$(date +%s)" > "$AUTOMATION_DIR/parallel/${task_id}.start"
            log_automation "Parallel task started: $task_id"
            ;;
        "end")
            if [ -f "$AUTOMATION_DIR/parallel/${task_id}.start" ]; then
                local start_time=$(cat "$AUTOMATION_DIR/parallel/${task_id}.start")
                local end_time=$(date +%s)
                local duration=$((end_time - start_time))
                
                echo "$duration" > "$AUTOMATION_DIR/parallel/${task_id}.duration"
                rm -f "$AUTOMATION_DIR/parallel/${task_id}.start"
                
                log_automation "Parallel task completed: $task_id (${duration}s)"
                
                # Check if all parallel tasks are done
                if [ $(find "$AUTOMATION_DIR/parallel" -name "*.start" | wc -l) -eq 0 ]; then
                    echo -e "${GREEN}✓${NC} All parallel tasks completed"
                    aggregate_parallel_results
                fi
            fi
            ;;
    esac
}

# Aggregate results from parallel tasks
aggregate_parallel_results() {
    echo -e "${BLUE}[INFO]${NC} Aggregating parallel task results..."
    
    local total_duration=0
    local task_count=0
    
    # Sum up all task durations
    find "$AUTOMATION_DIR/parallel" -name "*.duration" | while read -r duration_file; do
        local duration=$(cat "$duration_file")
        total_duration=$((total_duration + duration))
        task_count=$((task_count + 1))
        
        local task_id=$(basename "$duration_file" .duration)
        echo "  Task $task_id: ${duration}s"
    done
    
    if [ "$task_count" -gt 0 ]; then
        local avg_duration=$((total_duration / task_count))
        echo "  Average duration: ${avg_duration}s"
        echo "  Total parallel time saved: $((total_duration - avg_duration))s"
        
        log_automation "Parallel execution completed: $task_count tasks, ${avg_duration}s average"
    fi
    
    # Clean up duration files
    rm -f "$AUTOMATION_DIR/parallel"/*.duration
}

# Main command handling
case "${1:-help}" in
    "init")
        init_automation
        ;;
    "batch-add")
        batch_git_add "$2"
        ;;
    "execute-batch")
        execute_git_batch
        ;;
    "smart-commit")
        generate_smart_commit "$2"
        ;;
    "post-commit")
        post_commit_optimization
        ;;
    "cleanup")
        cleanup_temp_files
        ;;
    "optimize-branches")
        optimize_branches
        ;;
    "quality-check")
        post_edit_quality_check "$2"
        ;;
    "parallel")
        coordinate_parallel_tasks "$2" "$3"
        ;;
    "help"|*)
        echo "Simone Automation Hooks"
        echo "Usage: $0 {init|batch-add <file>|execute-batch|smart-commit <msg>|post-commit|cleanup|optimize-branches|quality-check <file>|parallel <task> <status>}"
        echo ""
        echo "Commands:"
        echo "  init                     - Initialize automation system"
        echo "  batch-add <file>         - Add file to Git batch queue"
        echo "  execute-batch            - Execute batched Git operations"
        echo "  smart-commit <message>   - Generate enhanced commit message"
        echo "  post-commit              - Run post-commit optimizations"
        echo "  cleanup                  - Clean temporary files"
        echo "  optimize-branches        - Optimize Git branch management"
        echo "  quality-check <file>     - Run quality checks on file"
        echo "  parallel <task> <status> - Coordinate parallel task execution"
        echo ""
        echo "Hook Integration Examples:"
        echo "  PostToolUse(Write): ./scripts/automation-hooks.sh quality-check \"\$TOOL_FILE_PATH\""
        echo "  PostToolUse(Edit):  ./scripts/automation-hooks.sh batch-add \"\$TOOL_FILE_PATH\""
        echo "  Stop:               ./scripts/automation-hooks.sh execute-batch && ./scripts/automation-hooks.sh cleanup"
        ;;
esac