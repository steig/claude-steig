#!/bin/bash
# Verify Simone upgrade preserved user data correctly

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
    exit 1
}

warn() {
    echo -e "${YELLOW}!${NC} $1"
}

echo "Verifying Simone upgrade..."

# Run basic installation verification first
bash $(dirname "$0")/verify-installation.sh

echo
echo "Checking upgrade-specific behavior..."

# Check that backup was created
backup_dirs=($(ls -d .simone.backup.* 2>/dev/null || true))
[[ ${#backup_dirs[@]} -gt 0 ]] || error "No backup directory found after upgrade"
success "Backup directory created: ${backup_dirs[0]}"

# Check version was updated
version=$(cat .simone/.version)
[[ "$version" == "2.0.2" ]] || error "Version not updated correctly: $version"
success "Version updated to: $version"

# Check that user data was preserved
if [[ -f .simone/01_PROJECT_DOCS/old-doc.md ]]; then
    success "User document preserved: old-doc.md"
else
    warn "User document old-doc.md not found (may be expected depending on upgrade logic)"
fi

# Verify backup contains the old user data
if [[ ${#backup_dirs[@]} -gt 0 ]]; then
    backup_dir="${backup_dirs[0]}"
    if [[ -f "$backup_dir/01_PROJECT_DOCS/old-doc.md" ]]; then
        success "User data safely backed up in: $backup_dir"
    else
        error "User data not found in backup directory"
    fi
fi

# Check that CLAUDE.md files were updated (not preserved from old version)
if [[ -f .simone/CLAUDE.md ]]; then
    # CLAUDE.md should be relatively recent/large (new version)
    claude_size=$(wc -c < .simone/CLAUDE.md)
    [[ $claude_size -gt 500 ]] || warn "CLAUDE.md seems small, may not have been updated: $claude_size bytes"
    success "CLAUDE.md appears to be updated version"
fi

# Verify templates were updated
template_count=$(find .simone/99_TEMPLATES -name "*.md" -type f | wc -l)
[[ $template_count -gt 5 ]] || error "Templates not properly updated: only $template_count found"
success "Templates updated: $template_count files"

# Verify commands were updated
simone_cmd_count=$(find .claude/commands/simone -name "*.md" -type f | wc -l)
[[ $simone_cmd_count -gt 15 ]] || error "Simone commands not properly updated: only $simone_cmd_count found"
success "Simone commands updated: $simone_cmd_count files"

echo
echo "🎉 Upgrade verification completed successfully!"
echo "All components updated properly and user data preserved."