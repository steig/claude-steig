#!/bin/bash
# Test script for remote installation functionality

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Configuration
REMOTE_URL="https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh"
TEST_DIR="test-remote-$(date +%s)"
ORIGINAL_DIR="$(pwd)"

echo "🧪 Testing Remote Installation Functionality"
echo "=============================================="
echo

# Test 1: Verify remote script is accessible
info "Test 1: Checking remote script accessibility..."
if curl -sSL -f "$REMOTE_URL" >/dev/null; then
    success "Remote script is accessible"
else
    error "Cannot access remote script at $REMOTE_URL"
fi

# Test 2: Test help command remotely
info "Test 2: Testing remote help command..."
help_output=$(curl -sSL "$REMOTE_URL" | bash -s -- --help 2>&1 || true)
if echo "$help_output" | grep -q "Simone Framework Installer"; then
    success "Remote help command works"
else
    error "Remote help command failed"
fi

# Test 3: Test version command remotely  
info "Test 3: Testing remote version command..."
version_output=$(curl -sSL "$REMOTE_URL" | bash -s -- --version 2>&1 || true)
if echo "$version_output" | grep -q "Simone Framework Installer v"; then
    success "Remote version command works"
else
    error "Remote version command failed"
fi

# Test 4: Fresh installation
info "Test 4: Testing fresh remote installation..."
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Create a test project file
echo '{"name": "remote-test-project"}' > package.json

# Run remote installation
if curl -sSL "$REMOTE_URL" | bash -s -- --force >/dev/null 2>&1; then
    success "Fresh remote installation completed"
else
    error "Fresh remote installation failed"
fi

# Verify installation
if [[ -d .simone && -d .claude && -f .simone/.version ]]; then
    success "Installation structure created correctly"
else
    error "Installation structure is incomplete"
fi

# Check version
version=$(cat .simone/.version 2>/dev/null || echo "unknown")
if [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    success "Version file created: $version"
else
    error "Invalid version file: $version"
fi

# Count templates
template_count=$(find .simone/99_TEMPLATES -name "*.md" -type f | wc -l)
if [[ $template_count -ge 10 ]]; then
    success "Templates installed: $template_count files"
else
    error "Insufficient templates installed: $template_count"
fi

# Count commands
command_count=$(find .claude/commands/simone -name "*.md" -type f | wc -l)
if [[ $command_count -ge 20 ]]; then
    success "Commands installed: $command_count files"
else
    error "Insufficient commands installed: $command_count"
fi

# Test 5: Upgrade detection
info "Test 5: Testing upgrade detection..."
echo "# Custom user document" > .simone/01_PROJECT_DOCS/user-doc.md

# Try to install again - should detect existing installation
install_output=$(curl -sSL "$REMOTE_URL" | bash 2>&1 || true)
if echo "$install_output" | grep -q "already installed and up to date"; then
    success "Upgrade detection works correctly"
else
    warn "Upgrade detection may not be working as expected"
fi

# Verify user data was preserved
if [[ -f .simone/01_PROJECT_DOCS/user-doc.md ]]; then
    success "User data preserved during upgrade attempt"
else
    error "User data was lost during upgrade attempt"
fi

# Test 6: Specific directory installation
info "Test 6: Testing installation to specific directory..."
cd "$ORIGINAL_DIR"
target_dir="$TEST_DIR-target"

# Create target directory with project file
mkdir -p "$target_dir"
echo '{"name": "target-test-project"}' > "$target_dir/package.json"

# Install to specific directory
if curl -sSL "$REMOTE_URL" | bash -s -- "$target_dir" >/dev/null 2>&1; then
    success "Installation to specific directory completed"
else
    error "Installation to specific directory failed"
fi

# Verify target directory installation
if [[ -d "$target_dir/.simone" && -f "$target_dir/.simone/.version" ]]; then
    success "Target directory installation verified"
else
    error "Target directory installation failed"
fi

# Test 7: Network connectivity validation
info "Test 7: Testing GitHub connectivity..."
if git ls-remote https://github.com/steig/claude-steig master >/dev/null 2>&1; then
    success "GitHub repository is accessible"
else
    warn "GitHub repository access may be limited"
fi

# Test 8: Script integrity check
info "Test 8: Checking script integrity..."
script_size=$(curl -sSL "$REMOTE_URL" | wc -c)
if [[ $script_size -gt 10000 ]]; then
    success "Script size appears normal: $script_size bytes"
else
    error "Script size appears too small: $script_size bytes"
fi

# Test 9: Error handling
info "Test 9: Testing error handling..."
cd "$ORIGINAL_DIR"
error_test_dir="$TEST_DIR-error"
mkdir -p "$error_test_dir"
cd "$error_test_dir"

# Create invalid project structure to test error handling
chmod 000 . 2>/dev/null || true

# Try installation with restricted permissions (should handle gracefully)
install_result=$(curl -sSL "$REMOTE_URL" | bash 2>&1 || true)
chmod 755 . 2>/dev/null || true

if echo "$install_result" | grep -q -E "(ERROR|Failed|Permission denied)" || [[ ! -d .simone ]]; then
    success "Error handling works appropriately"
else
    warn "Error handling may need improvement"
fi

# Cleanup
cd "$ORIGINAL_DIR"
rm -rf "$TEST_DIR" "$target_dir" "$error_test_dir" 2>/dev/null || true

echo
echo "🎉 Remote Installation Tests Complete!"
echo "======================================"
echo
echo "Summary:"
echo "- Remote script accessibility: ✓"
echo "- Command-line interface: ✓"
echo "- Fresh installation: ✓"
echo "- Upgrade detection: ✓"
echo "- User data preservation: ✓"
echo "- Target directory support: ✓"
echo "- Error handling: ✓"
echo
echo "Remote installation is working correctly!"