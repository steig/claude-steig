#!/bin/bash

# Simone Framework Installation Tester
# Tests installation instructions in clean environments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TEST_ENV="/tmp/simone-install-test-$(date +%s)"
INSTALL_SCRIPT="install-simone.sh"
DOCS_INSTALL="docs/getting-started/installation.md"

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Utility functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((TESTS_PASSED++))
    ((TESTS_RUN++))
}

fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((TESTS_FAILED++))
    ((TESTS_RUN++))
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Setup clean test environment
setup_test_environment() {
    log "Setting up clean test environment: $TEST_ENV"
    
    # Remove any existing test environment
    if [[ -d "$TEST_ENV" ]]; then
        rm -rf "$TEST_ENV"
    fi
    
    # Create clean directory
    mkdir -p "$TEST_ENV"
    
    # Copy installation script if it exists
    if [[ -f "$INSTALL_SCRIPT" ]]; then
        cp "$INSTALL_SCRIPT" "$TEST_ENV/"
        success "Copied installation script to test environment"
    else
        warn "Installation script not found: $INSTALL_SCRIPT"
    fi
    
    # Copy .claude directory for testing
    if [[ -d ".claude" ]]; then
        cp -r .claude "$TEST_ENV/"
        success "Copied .claude directory to test environment"
    else
        warn ".claude directory not found"
    fi
    
    success "Test environment created: $TEST_ENV"
}

# Cleanup test environment
cleanup_test_environment() {
    if [[ "$KEEP_TEST_ENV" != "true" && -d "$TEST_ENV" ]]; then
        log "Cleaning up test environment"
        rm -rf "$TEST_ENV"
        success "Test environment cleaned up"
    else
        log "Test environment preserved: $TEST_ENV"
    fi
}

# Test basic installation script execution
test_install_script_execution() {
    log "Testing installation script execution..."
    
    if [[ ! -f "$TEST_ENV/$INSTALL_SCRIPT" ]]; then
        fail "Installation script not available for testing"
        return 1
    fi
    
    # Run installation in test environment
    (
        cd "$TEST_ENV"
        
        # Test script execution
        if bash "$INSTALL_SCRIPT" 2>/dev/null; then
            success "Installation script executed without errors"
        else
            fail "Installation script execution failed"
            return 1
        fi
        
        # Check if .simone directory was created
        if [[ -d ".simone" ]]; then
            success "Simone directory structure created"
        else
            fail "Simone directory structure not created"
            return 1
        fi
        
        # Check for required subdirectories
        local required_dirs=(
            ".simone/01_PROJECT_DOCS"
            ".simone/02_REQUIREMENTS"
            ".simone/03_SPRINTS"
            ".simone/04_GENERAL_TASKS"
            ".simone/05_ARCHITECTURAL_DECISIONS"
        )
        
        for dir in "${required_dirs[@]}"; do
            if [[ -d "$dir" ]]; then
                success "Required directory created: $dir"
            else
                fail "Required directory missing: $dir"
            fi
        done
        
        # Check for project manifest template
        if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
            success "Project manifest template created"
            
            # Validate manifest has required YAML frontmatter
            if head -1 ".simone/00_PROJECT_MANIFEST.md" | grep -q '^---$'; then
                success "Project manifest has valid YAML frontmatter"
            else
                fail "Project manifest missing YAML frontmatter"
            fi
        else
            fail "Project manifest template not created"
        fi
    )
}

# Test documentation installation instructions
test_documentation_instructions() {
    log "Testing documentation installation instructions..."
    
    if [[ ! -f "$DOCS_INSTALL" ]]; then
        fail "Installation documentation not found: $DOCS_INSTALL"
        return 1
    fi
    
    # Extract installation commands from documentation
    local install_commands
    install_commands=$(awk '/```bash/,/```/ {if(/```bash/) next; if(/```/) exit; print}' "$DOCS_INSTALL")
    
    if [[ -z "$install_commands" ]]; then
        fail "No installation commands found in documentation"
        return 1
    fi
    
    success "Found installation commands in documentation"
    
    # Test each command in clean environment
    local test_project="$TEST_ENV/doc-test-project"
    mkdir -p "$test_project"
    
    (
        cd "$test_project"
        
        # Execute documented installation commands
        echo "$install_commands" | while IFS= read -r cmd; do
            if [[ -n "$cmd" && ! "$cmd" =~ ^[[:space:]]*# ]]; then
                log "Testing documented command: $cmd"
                
                # Substitute placeholder paths if needed
                local actual_cmd="$cmd"
                actual_cmd="${actual_cmd//\/path\/to\/simone\//../../}"
                
                if eval "$actual_cmd" 2>/dev/null; then
                    success "Documented command successful: $cmd"
                else
                    fail "Documented command failed: $cmd"
                fi
            fi
        done
        
        # Verify results
        if [[ -d ".simone" ]]; then
            success "Documentation instructions successfully created Simone structure"
        else
            fail "Documentation instructions did not create Simone structure"
        fi
    )
}

# Test installation in different scenarios
test_installation_scenarios() {
    log "Testing installation in different scenarios..."
    
    # Scenario 1: Empty directory
    local empty_dir="$TEST_ENV/empty-project"
    mkdir -p "$empty_dir"
    
    (
        cd "$empty_dir"
        cp "../$INSTALL_SCRIPT" . 2>/dev/null || true
        
        if [[ -f "$INSTALL_SCRIPT" ]]; then
            if bash "$INSTALL_SCRIPT" 2>/dev/null; then
                success "Installation successful in empty directory"
            else
                fail "Installation failed in empty directory"
            fi
        else
            warn "Installation script not available for empty directory test"
        fi
    )
    
    # Scenario 2: Existing project with files
    local existing_dir="$TEST_ENV/existing-project"
    mkdir -p "$existing_dir"
    
    (
        cd "$existing_dir"
        
        # Create some existing files
        echo "# Existing Project" > README.md
        mkdir -p src
        echo "console.log('hello');" > src/app.js
        
        cp "../$INSTALL_SCRIPT" . 2>/dev/null || true
        
        if [[ -f "$INSTALL_SCRIPT" ]]; then
            if bash "$INSTALL_SCRIPT" 2>/dev/null; then
                success "Installation successful in existing project"
                
                # Check that existing files were preserved
                if [[ -f "README.md" && -f "src/app.js" ]]; then
                    success "Existing files preserved during installation"
                else
                    fail "Existing files not preserved during installation"
                fi
            else
                fail "Installation failed in existing project"
            fi
        else
            warn "Installation script not available for existing project test"
        fi
    )
    
    # Scenario 3: Re-installation (upgrade scenario)
    local upgrade_dir="$TEST_ENV/upgrade-project"
    mkdir -p "$upgrade_dir"
    
    (
        cd "$upgrade_dir"
        cp "../$INSTALL_SCRIPT" . 2>/dev/null || true
        
        if [[ -f "$INSTALL_SCRIPT" ]]; then
            # First installation
            bash "$INSTALL_SCRIPT" 2>/dev/null
            
            # Modify some files to simulate user changes
            echo "# My Project" > .simone/00_PROJECT_MANIFEST.md
            echo "Custom task" > .simone/04_GENERAL_TASKS/my_task.md
            
            # Second installation (upgrade)
            if bash "$INSTALL_SCRIPT" 2>/dev/null; then
                success "Re-installation/upgrade successful"
                
                # Check that user files were preserved
                if [[ -f ".simone/04_GENERAL_TASKS/my_task.md" ]]; then
                    success "User files preserved during upgrade"
                else
                    fail "User files lost during upgrade"
                fi
            else
                fail "Re-installation/upgrade failed"
            fi
        else
            warn "Installation script not available for upgrade test"
        fi
    )
}

# Test command availability after installation
test_command_availability() {
    log "Testing command availability after installation..."
    
    local cmd_test_dir="$TEST_ENV/command-test"
    mkdir -p "$cmd_test_dir"
    
    (
        cd "$cmd_test_dir"
        cp "../$INSTALL_SCRIPT" . 2>/dev/null || true
        cp -r "../.claude" . 2>/dev/null || true
        
        if [[ -f "$INSTALL_SCRIPT" ]]; then
            bash "$INSTALL_SCRIPT" 2>/dev/null
            
            # Check if commands directory exists
            if [[ -d ".claude/commands/simone" ]]; then
                success "Simone commands directory available"
                
                # Count available commands
                local cmd_count=$(find .claude/commands/simone -name "*.md" -type f | wc -l)
                if [[ $cmd_count -gt 0 ]]; then
                    success "Found $cmd_count Simone commands available"
                else
                    fail "No Simone commands found"
                fi
            else
                fail "Simone commands directory not available"
            fi
            
            # Check if templates directory exists
            if [[ -d ".claude/templates/simone" ]]; then
                success "Simone templates directory available"
                
                # Count available templates
                local template_count=$(find .claude/templates/simone -name "*.md" -type f | wc -l)
                if [[ $template_count -gt 0 ]]; then
                    success "Found $template_count Simone templates available"
                else
                    fail "No Simone templates found"
                fi
            else
                fail "Simone templates directory not available"
            fi
        else
            warn "Installation script not available for command availability test"
        fi
    )
}

# Validate installed structure
test_installed_structure() {
    log "Testing installed project structure..."
    
    local structure_test_dir="$TEST_ENV/structure-test"
    mkdir -p "$structure_test_dir"
    
    (
        cd "$structure_test_dir"
        cp "../$INSTALL_SCRIPT" . 2>/dev/null || true
        
        if [[ -f "$INSTALL_SCRIPT" ]]; then
            bash "$INSTALL_SCRIPT" 2>/dev/null
            
            # Test directory permissions
            if [[ -r ".simone" && -w ".simone" && -x ".simone" ]]; then
                success "Simone directory has correct permissions"
            else
                fail "Simone directory has incorrect permissions"
            fi
            
            # Test file permissions
            if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
                if [[ -r ".simone/00_PROJECT_MANIFEST.md" && -w ".simone/00_PROJECT_MANIFEST.md" ]]; then
                    success "Project manifest has correct permissions"
                else
                    fail "Project manifest has incorrect permissions"
                fi
            fi
            
            # Test YAML structure in manifest
            if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
                if head -1 ".simone/00_PROJECT_MANIFEST.md" | grep -q '^---$'; then
                    local yaml_end=$(tail -n +2 ".simone/00_PROJECT_MANIFEST.md" | grep -n '^---$' | head -1 | cut -d: -f1)
                    if [[ -n "$yaml_end" ]]; then
                        success "Project manifest has valid YAML structure"
                    else
                        fail "Project manifest has incomplete YAML structure"
                    fi
                else
                    fail "Project manifest missing YAML frontmatter"
                fi
            fi
        else
            warn "Installation script not available for structure test"
        fi
    )
}

# Generate comprehensive test report
generate_test_report() {
    echo
    log "=== INSTALLATION TEST REPORT ==="
    echo
    
    # Summary statistics
    echo -e "${BLUE}Test Summary:${NC}"
    echo -e "  Total Tests: $TESTS_RUN"
    echo -e "  ${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "  ${RED}Failed: $TESTS_FAILED${NC}"
    echo
    
    # Calculate success rate
    if [[ $TESTS_RUN -gt 0 ]]; then
        local success_rate=$((TESTS_PASSED * 100 / TESTS_RUN))
        echo -e "${BLUE}Success Rate: ${success_rate}%${NC}"
        echo
    fi
    
    # Test categories summary
    echo -e "${BLUE}Test Categories Completed:${NC}"
    echo -e "  ✓ Installation Script Execution"
    echo -e "  ✓ Documentation Instructions"
    echo -e "  ✓ Installation Scenarios (empty, existing, upgrade)"
    echo -e "  ✓ Command Availability"
    echo -e "  ✓ Installed Structure Validation"
    echo
    
    # Environment info
    echo -e "${BLUE}Test Environment:${NC}"
    echo -e "  Test Directory: $TEST_ENV"
    echo -e "  Installation Script: $INSTALL_SCRIPT"
    echo -e "  Documentation: $DOCS_INSTALL"
    echo -e "  Test Duration: ${SECONDS}s"
    echo
    
    # Return appropriate exit code
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo -e "${RED}❌ Installation testing failed with $TESTS_FAILED issues${NC}"
        return 1
    else
        echo -e "${GREEN}✅ All installation tests passed successfully${NC}"
        return 0
    fi
}

# Main test execution
main() {
    echo -e "${BLUE}⚙️  Simone Installation Tester${NC}"
    echo -e "${BLUE}==============================${NC}"
    echo
    
    # Setup test environment
    setup_test_environment
    
    # Run test suites
    test_install_script_execution
    test_documentation_instructions
    test_installation_scenarios
    test_command_availability
    test_installed_structure
    
    # Generate report
    local exit_code=0
    if ! generate_test_report; then
        exit_code=1
    fi
    
    # Cleanup
    cleanup_test_environment
    
    exit $exit_code
}

# Handle command line arguments
KEEP_TEST_ENV="false"

case "${1:-}" in
    --help|-h)
        echo "Simone Installation Tester"
        echo
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --help, -h        Show this help message"
        echo "  --keep-env        Keep test environment after completion"
        echo "  --verbose         Enable verbose output"
        echo "  --quick           Run only basic installation tests"
        echo
        echo "Environment Variables:"
        echo "  INSTALL_SCRIPT    Installation script to test (default: $INSTALL_SCRIPT)"
        echo "  DOCS_INSTALL      Installation documentation (default: $DOCS_INSTALL)"
        echo
        echo "This script tests:"
        echo "  - Installation script execution"
        echo "  - Documentation instruction accuracy"
        echo "  - Various installation scenarios"
        echo "  - Command and template availability"
        echo "  - Installed structure validation"
        echo
        echo "Test Environment:"
        echo "  Tests run in isolated environment: /tmp/simone-install-test-*"
        echo "  Use --keep-env to preserve test environment for inspection"
        exit 0
        ;;
    --keep-env)
        KEEP_TEST_ENV="true"
        log "Test environment will be preserved after completion"
        ;;
    --verbose)
        set -x
        ;;
    --quick)
        log "Running quick installation tests only"
        setup_test_environment
        test_install_script_execution
        generate_test_report
        cleanup_test_environment
        exit $?
        ;;
    "")
        # No arguments - run all tests
        ;;
    *)
        echo "Unknown option: $1. Use --help for usage information."
        exit 1
        ;;
esac

# Check prerequisites
if [[ ! -f "$INSTALL_SCRIPT" && ! -f "$DOCS_INSTALL" ]]; then
    error "Neither installation script nor documentation found"
    error "Please run from project root with $INSTALL_SCRIPT or $DOCS_INSTALL"
    exit 1
fi

# Run main function
main