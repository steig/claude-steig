#!/usr/bin/env bash
# Git automation utilities for Simone
# Provides intelligent automation for Git operations

# Source performance optimizer
source "$(dirname "${BASH_SOURCE[0]}")/performance-optimizer.sh"

# Configuration
AUTOMATION_DIR="${SIMONE_CACHE_DIR}/automation"
AUTOMATION_LOG="$AUTOMATION_DIR/automation.log"
GIT_BATCH_FILE="$AUTOMATION_DIR/git_batch.tmp"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Initialize automation
init_git_automation() {
    mkdir -p "$AUTOMATION_DIR"
    echo "✅ Git automation initialized"
}

# Batch Git operations for efficiency
batch_git_add() {
    local file_path="$1"
    
    # Add to batch file instead of immediate execution
    echo "$file_path" >> "$GIT_BATCH_FILE"
    
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
        [ "$script_changes" -gt 0 ] && enhanced_message="$enhanced_message- ⚙️  Scripts: $script_changes files
"
        [ "$template_changes" -gt 0 ] && enhanced_message="$enhanced_message- 📋 Templates: $template_changes files
"
    fi
    
    echo "$enhanced_message"
}

# Post-commit optimizations
post_commit_optimization() {
    echo -e "${BLUE}[INFO]${NC} Running post-commit optimizations..."
    
    # Update performance cache if templates changed
    if git diff --name-only HEAD~1 HEAD | grep -q "99_TEMPLATES"; then
        echo -e "${YELLOW}⚡${NC} Templates changed, refreshing cache..."
        # Refresh template cache
        if type cache_template >/dev/null 2>&1; then
            find .simone/99_TEMPLATES -name "*.md" -type f | while read template; do
                cache_template "$(basename "$template")" >/dev/null 2>&1
            done
        fi
    fi
    
    # Update task database if task files changed
    if git diff --name-only HEAD~1 HEAD | grep -E "(03_SPRINTS|04_GENERAL_TASKS)" | head -1; then
        echo -e "${YELLOW}⚡${NC} Tasks changed, updating database..."
        # Update affected tasks in database
        git diff --name-only HEAD~1 HEAD | grep -E "(03_SPRINTS|04_GENERAL_TASKS)" | while read file; do
            if [[ -f "$file" ]] && type index_task_file >/dev/null 2>&1; then
                index_task_file "$file"
            fi
        done
    fi
    
    echo -e "${GREEN}✓${NC} Post-commit optimizations completed"
}

# Optimize branches
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
            fi
        done
        echo -e "${YELLOW}💡${NC} Run 'git branch -d <branch>' to clean up merged branches"
    fi
    
    # Clean up remote tracking branches
    git remote prune origin 2>/dev/null || true
    
    echo -e "${GREEN}✓${NC} Branch optimization completed"
}

# Quality check for files
quality_check_file() {
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
                echo -e "${GREEN}✓${NC} Markdown formatting applied"
            fi
        fi
    fi
    
    # Shell script formatting
    if [[ "$file_path" == *.sh ]]; then
        if command -v shfmt &> /dev/null; then
            if shfmt -w "$file_path" 2>/dev/null; then
                echo -e "${GREEN}✓${NC} Shell script formatting applied"
            fi
        fi
        
        # Shellcheck for linting
        if command -v shellcheck &> /dev/null; then
            if ! shellcheck "$file_path" 2>/dev/null; then
                echo -e "${YELLOW}⚠${NC} ShellCheck found issues in: $file_path"
            fi
        fi
    fi
}