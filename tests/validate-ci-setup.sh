#!/bin/bash
# CI/CD Setup Validation Script
# Validates that GitHub Actions workflows will run correctly

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validation counters
CHECKS_TOTAL=0
CHECKS_PASSED=0
CHECKS_FAILED=0

# Utility functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((CHECKS_PASSED++))
}

fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((CHECKS_FAILED++))
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

check_item() {
    local description="$1"
    local check_command="$2"
    
    ((CHECKS_TOTAL++))
    
    if eval "$check_command" >/dev/null 2>&1; then
        success "$description"
    else
        fail "$description"
    fi
}

# Validate workflow files
validate_workflow_files() {
    log "Validating GitHub Actions workflow files..."
    
    check_item "Performance test workflow exists" "[[ -f '.github/workflows/test-performance.yml' ]]"
    check_item "Installation test workflow exists" "[[ -f '.github/workflows/test-install.yml' ]]"
    
    # Validate workflow syntax (basic YAML check)
    if command -v yamllint >/dev/null 2>&1; then
        check_item "Performance workflow YAML syntax" "yamllint .github/workflows/test-performance.yml"
        check_item "Installation workflow YAML syntax" "yamllint .github/workflows/test-install.yml"
    else
        warn "yamllint not available - skipping YAML syntax validation"
    fi
    
    # Check for required workflow components
    check_item "Performance workflow has job definitions" "grep -q 'jobs:' .github/workflows/test-performance.yml"
    check_item "Performance workflow has matrix strategy" "grep -q 'matrix:' .github/workflows/test-performance.yml"
    check_item "Performance workflow has ubuntu and macos" "grep -q 'ubuntu-latest.*macos-latest' .github/workflows/test-performance.yml"
}

# Validate test files
validate_test_files() {
    log "Validating test file structure..."
    
    # Check test files exist
    check_item "Performance infrastructure tests exist" "[[ -f 'tests/test-performance-infrastructure.bats' ]]"
    check_item "Performance commands tests exist" "[[ -f 'tests/test-performance-commands.bats' ]]"
    check_item "Performance integration tests exist" "[[ -f 'tests/test-performance-integration.sh' ]]"
    check_item "Performance test runner exists" "[[ -f 'tests/run-performance-tests.sh' ]]"
    check_item "Validation script exists" "[[ -f 'tests/validate-ci-setup.sh' ]]"
    
    # Check test files are executable
    check_item "Performance integration tests executable" "[[ -x 'tests/test-performance-integration.sh' ]]"
    check_item "Performance test runner executable" "[[ -x 'tests/run-performance-tests.sh' ]]"
    check_item "Validation script executable" "[[ -x 'tests/validate-ci-setup.sh' ]]"
    
    # Check existing test files
    check_item "Installation unit tests exist" "[[ -f 'tests/test-install-unit.bats' ]]"
    check_item "Installation verification exists" "[[ -f 'tests/verify-installation.sh' ]]"
    check_item "Command verification exists" "[[ -f 'tests/verify-commands.sh' ]]"
}

# Validate performance system components
validate_performance_system() {
    log "Validating performance system components..."
    
    # Check performance utility files
    check_item "Performance optimizer exists" "[[ -f '.simone/01_UTILS/performance-optimizer.sh' ]]"
    check_item "Cache manager exists" "[[ -f '.simone/01_UTILS/cache-manager.sh' ]]"
    check_item "Database manager exists" "[[ -f '.simone/01_UTILS/database-manager.sh' ]]"
    check_item "Fast commands exist" "[[ -f '.simone/01_UTILS/fast-commands.sh' ]]"
    check_item "Git automation exists" "[[ -f '.simone/01_UTILS/git-automation.sh' ]]"
    check_item "Hooks integration exists" "[[ -f '.simone/01_UTILS/hooks-integration.sh' ]]"
    check_item "Performance main exists" "[[ -f '.simone/01_UTILS/performance-main.sh' ]]"
    
    # Check performance optimizer syntax
    check_item "Performance optimizer has init function" "grep -q 'init_performance()' .simone/01_UTILS/performance-optimizer.sh"
    check_item "Performance optimizer has cache functions" "grep -q 'cache_set\\|cache_get' .simone/01_UTILS/performance-optimizer.sh"
    check_item "Performance optimizer has database functions" "grep -q 'count_tasks_by_status' .simone/01_UTILS/performance-optimizer.sh"
}

# Validate dependencies and environment
validate_dependencies() {
    log "Validating CI dependencies and environment..."
    
    # Check for tools that GitHub Actions will need
    local tools=("git" "bash" "sqlite3")
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" >/dev/null 2>&1; then
            success "$tool available"
            ((CHECKS_PASSED++))
        else
            fail "$tool not available (required for CI)"
            ((CHECKS_FAILED++))
        fi
        ((CHECKS_TOTAL++))
    done
    
    # Check optional tools
    local optional_tools=("bc" "bats" "yamllint")
    
    for tool in "${optional_tools[@]}"; do
        if command -v "$tool" >/dev/null 2>&1; then
            success "$tool available (optional)"
        else
            warn "$tool not available (will be installed in CI)"
        fi
    done
    
    # Check project structure
    check_item "Project is in git repository" "[[ -d '.git' ]]"
    check_item "Simone structure exists" "[[ -d '.simone' ]]"
    check_item "Install script exists" "[[ -f 'install-simone.sh' ]]"
    check_item "CHANGELOG exists with performance info" "grep -q '60-80% Faster' CHANGELOG.md"
}

# Validate workflow triggers
validate_workflow_triggers() {
    log "Validating workflow trigger configuration..."
    
    # Check trigger paths in performance workflow
    check_item "Performance workflow triggers on performance utils" "grep -A 10 'paths:' .github/workflows/test-performance.yml | grep -q '.simone/01_UTILS/'"
    check_item "Performance workflow triggers on performance tests" "grep -A 10 'paths:' .github/workflows/test-performance.yml | grep -q 'test-performance-'"
    check_item "Performance workflow has manual trigger" "grep -q 'workflow_dispatch:' .github/workflows/test-performance.yml"
    
    # Check installation workflow updates
    check_item "Installation workflow has performance validation" "grep -q 'test-performance-post-install' .github/workflows/test-install.yml"
    check_item "Installation workflow tests performance system" "grep -q 'performance-optimizer.sh' .github/workflows/test-install.yml"
}

# Test basic functionality
test_basic_functionality() {
    log "Testing basic performance functionality..."
    
    # Create temporary test environment
    local test_dir="validate-test-$$"
    mkdir -p "$test_dir"
    cd "$test_dir"
    
    # Copy performance system
    cp -r ../.simone . 2>/dev/null || true
    
    # Test performance system initialization
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        ((CHECKS_TOTAL++))
        if source .simone/01_UTILS/performance-optimizer.sh && \
           export SIMONE_PERF_ENABLED="true" && \
           init_performance >/dev/null 2>&1; then
            success "Performance system initializes correctly"
            ((CHECKS_PASSED++))
            
            # Test basic cache operations
            ((CHECKS_TOTAL++))
            if cache_set "validate_test" "value" 300 >/dev/null 2>&1 && \
               [[ "$(cache_get "validate_test" 2>/dev/null)" == "value" ]]; then
                success "Cache operations work correctly"
                ((CHECKS_PASSED++))
            else
                fail "Cache operations failed"
                ((CHECKS_FAILED++))
            fi
        else
            fail "Performance system initialization failed"
            ((CHECKS_FAILED++))
        fi
    else
        fail "Performance optimizer not found"
        ((CHECKS_FAILED++))
        ((CHECKS_TOTAL++))
    fi
    
    cd ..
    rm -rf "$test_dir"
}

# Generate validation report
generate_validation_report() {
    echo
    echo -e "${BLUE}=== CI/CD SETUP VALIDATION REPORT ===${NC}"
    echo
    
    # Summary statistics
    echo -e "${BLUE}Validation Summary:${NC}"
    echo -e "  Total Checks: $CHECKS_TOTAL"
    echo -e "  ${GREEN}Passed: $CHECKS_PASSED${NC}"
    echo -e "  ${RED}Failed: $CHECKS_FAILED${NC}"
    echo
    
    # Calculate success rate
    if [[ $CHECKS_TOTAL -gt 0 ]]; then
        local success_rate=$((CHECKS_PASSED * 100 / CHECKS_TOTAL))
        echo -e "${BLUE}Success Rate: ${success_rate}%${NC}"
    else
        echo -e "${YELLOW}No checks were run${NC}"
    fi
    echo
    
    # Validation categories
    echo -e "${BLUE}Validation Categories:${NC}"
    echo -e "  ✓ GitHub Actions workflow files"
    echo -e "  ✓ Performance test file structure"
    echo -e "  ✓ Performance system components"
    echo -e "  ✓ CI dependencies and environment"
    echo -e "  ✓ Workflow trigger configuration"
    echo -e "  ✓ Basic functionality testing"
    echo
    
    # CI readiness assessment
    if [[ $CHECKS_FAILED -eq 0 ]]; then
        echo -e "${GREEN}✅ CI/CD setup is ready for GitHub Actions${NC}"
        echo -e "${GREEN}   All performance tests should run successfully in CI${NC}"
    elif [[ $CHECKS_FAILED -le 2 ]]; then
        echo -e "${YELLOW}⚠️  CI/CD setup mostly ready with minor issues${NC}"
        echo -e "${YELLOW}   Performance tests should run but may have some failures${NC}"
    else
        echo -e "${RED}❌ CI/CD setup has significant issues${NC}"
        echo -e "${RED}   Performance tests may fail in GitHub Actions${NC}"
    fi
    echo
    
    # Next steps
    echo -e "${BLUE}Next Steps:${NC}"
    if [[ $CHECKS_FAILED -eq 0 ]]; then
        echo -e "  1. Commit and push changes to trigger workflows"
        echo -e "  2. Monitor GitHub Actions for performance test results"
        echo -e "  3. Review performance benchmarks in PR summaries"
    else
        echo -e "  1. Fix failed validation checks above"
        echo -e "  2. Re-run this validation script"
        echo -e "  3. Test performance system locally before pushing"
    fi
    
    # Return appropriate exit code
    if [[ $CHECKS_FAILED -gt 2 ]]; then
        return 1
    else
        return 0
    fi
}

# Main execution
main() {
    echo -e "${BLUE}🔍 Simone CI/CD Setup Validator${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
    
    # Run validation categories
    validate_workflow_files
    validate_test_files
    validate_performance_system
    validate_dependencies
    validate_workflow_triggers
    test_basic_functionality
    
    # Generate report
    local exit_code=0
    if ! generate_validation_report; then
        exit_code=1
    fi
    
    exit $exit_code
}

# Handle command line arguments
case "${1:-}" in
    --help|-h|help)
        echo "Simone CI/CD Setup Validator"
        echo
        echo "Usage: $0"
        echo
        echo "This script validates that:"
        echo "  - GitHub Actions workflows are properly configured"
        echo "  - Performance test files exist and are executable"
        echo "  - Performance system components are available"
        echo "  - Required dependencies are available"
        echo "  - Workflow triggers are correctly configured"
        echo "  - Basic performance functionality works"
        echo
        echo "Run this before pushing changes to ensure CI will work correctly."
        exit 0
        ;;
esac

# Run main function
main