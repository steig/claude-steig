#!/bin/bash
# Verify Simone installation is correct

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

echo "Verifying Simone installation..."

# Check .simone directory structure
[[ -d .simone ]] || error ".simone directory not found"
success ".simone directory exists"

# Check required subdirectories
required_dirs=(
    ".simone/01_PROJECT_DOCS"
    ".simone/02_REQUIREMENTS" 
    ".simone/03_SPRINTS"
    ".simone/04_GENERAL_TASKS"
    ".simone/05_ARCHITECTURAL_DECISIONS"
    ".simone/10_STATE_OF_PROJECT"
    ".simone/99_TEMPLATES"
)

for dir in "${required_dirs[@]}"; do
    [[ -d "$dir" ]] || error "Required directory $dir not found"
    success "Directory $dir exists"
done

# Check version file
[[ -f .simone/.version ]] || error "Version file not found"
version=$(cat .simone/.version)
[[ "$version" == "2.1.0" ]] || error "Incorrect version: $version (expected 2.1.0)"
success "Version file correct: $version"

# Check templates exist
template_count=$(find .simone/99_TEMPLATES -name "*.md" -type f | wc -l)
[[ $template_count -gt 0 ]] || error "No templates found in .simone/99_TEMPLATES"
success "Templates installed: $template_count files"

# Check Claude commands directory
[[ -d .claude/commands ]] || error ".claude/commands directory not found"
success ".claude/commands directory exists"

# Check simone commands specifically
[[ -d .claude/commands/simone ]] || error ".claude/commands/simone directory not found"
success ".claude/commands/simone directory exists"

# Count simone command files
simone_cmd_count=$(find .claude/commands/simone -name "*.md" -type f | wc -l)
[[ $simone_cmd_count -gt 15 ]] || error "Expected more than 15 simone commands, found: $simone_cmd_count"
success "Simone commands installed: $simone_cmd_count files"

# Check for specific critical commands
critical_commands=(
    "initialize.md"
    "do_task.md"
    "create_sprint_tasks.md"
    "status.md"
    "project_review.md"
)

for cmd in "${critical_commands[@]}"; do
    [[ -f ".claude/commands/simone/$cmd" ]] || error "Critical command $cmd not found"
    success "Critical command $cmd exists"
done

# Check project manifest was created
[[ -f .simone/00_PROJECT_MANIFEST.md ]] || error "Project manifest not created"
success "Project manifest created"

# Verify manifest has content (not empty)
manifest_size=$(wc -c < .simone/00_PROJECT_MANIFEST.md)
[[ $manifest_size -gt 100 ]] || error "Project manifest appears empty or too small: $manifest_size bytes"
success "Project manifest has content: $manifest_size bytes"

# Check CLAUDE.md files exist in key directories
claude_files=(
    ".simone/CLAUDE.md"
    ".claude/CLAUDE.md"
)

for file in "${claude_files[@]}"; do
    if [[ -f "$file" ]]; then
        success "Claude instruction file $file exists"
    fi
done

echo
echo "🎉 Installation verification completed successfully!"
echo "All required components are properly installed."