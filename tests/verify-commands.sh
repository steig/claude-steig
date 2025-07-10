#!/bin/bash
# Verify all Simone commands are properly installed

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
    exit 1
}

echo "Verifying Simone commands installation..."

# Check simone commands directory exists
[[ -d .claude/commands/simone ]] || error ".claude/commands/simone directory not found"
success "Simone commands directory exists"

# Expected Simone commands based on the repository
expected_commands=(
    "code_review.md"
    "commit.md"
    "create_bug.md"
    "create_general_task.md"
    "create_pr.md"
    "create_sprint_tasks.md"
    "create_sprints_from_milestone.md"
    "discuss_review.md"
    "do_task.md"
    "fix_bug.md"
    "initialize.md"
    "merge.md"
    "prime.md"
    "project_review.md"
    "review_pr.md"
    "start_task.md"
    "status.md"
    "sync.md"
    "test.md"
    "testing_review.md"
    "update_task_status.md"
    "version.md"
    "yolo.md"
)

# Check each expected command exists
missing_commands=()
for cmd in "${expected_commands[@]}"; do
    if [[ -f ".claude/commands/simone/$cmd" ]]; then
        success "Command exists: $cmd"
    else
        missing_commands+=("$cmd")
        error "Missing command: $cmd"
    fi
done

# Report summary
total_expected=${#expected_commands[@]}
total_found=$((total_expected - ${#missing_commands[@]}))

echo
echo "Command installation summary:"
echo "Expected: $total_expected commands"
echo "Found: $total_found commands"

if [[ ${#missing_commands[@]} -eq 0 ]]; then
    success "All expected Simone commands are installed!"
else
    echo "Missing commands:"
    for cmd in "${missing_commands[@]}"; do
        echo "  - $cmd"
    done
    error "Some Simone commands are missing"
fi

# Verify command files have content
echo
echo "Verifying command files have content..."

empty_commands=()
for cmd in "${expected_commands[@]}"; do
    cmd_path=".claude/commands/simone/$cmd"
    if [[ -f "$cmd_path" ]]; then
        file_size=$(wc -c < "$cmd_path")
        if [[ $file_size -lt 50 ]]; then
            empty_commands+=("$cmd")
        else
            success "$cmd has content ($file_size bytes)"
        fi
    fi
done

if [[ ${#empty_commands[@]} -gt 0 ]]; then
    echo "Commands that appear empty or too small:"
    for cmd in "${empty_commands[@]}"; do
        echo "  - $cmd"
    done
    error "Some command files appear to be empty"
fi

# Check for common command patterns
echo
echo "Verifying command file structure..."

# Check that commands contain typical markdown patterns
pattern_checks=0
for cmd_file in .claude/commands/simone/*.md; do
    if [[ -f "$cmd_file" ]]; then
        # Look for common patterns that should be in command files
        if grep -q "^#" "$cmd_file" 2>/dev/null; then
            ((pattern_checks++))
        fi
    fi
done

[[ $pattern_checks -gt 10 ]] || error "Commands don't appear to have proper markdown structure"
success "Commands have proper markdown structure ($pattern_checks files checked)"

echo
echo "🎉 Simone commands verification completed successfully!"
echo "All $total_found commands are properly installed and formatted."