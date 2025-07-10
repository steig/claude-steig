#!/bin/bash

# Simone Framework Documentation Testing Framework
# Tests that documentation examples and instructions actually work

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOCS_DIR="docs"
TEST_WORKSPACE="/tmp/simone-doc-test-$(date +%s)"
TEST_RESULTS_FILE="test-results.log"

# Counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_SKIPPED=0

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

skip() {
    echo -e "${YELLOW}[SKIP]${NC} $1"
    ((TESTS_SKIPPED++))
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Setup test environment
setup_test_environment() {
    log "Setting up test environment in $TEST_WORKSPACE"
    
    # Create clean test workspace
    if [[ -d "$TEST_WORKSPACE" ]]; then
        rm -rf "$TEST_WORKSPACE"
    fi
    mkdir -p "$TEST_WORKSPACE"
    
    # Copy necessary files for testing
    if [[ -f "install-simone.sh" ]]; then
        cp install-simone.sh "$TEST_WORKSPACE/"
    fi
    
    # Copy .claude directory if it exists
    if [[ -d ".claude" ]]; then
        cp -r .claude "$TEST_WORKSPACE/"
    fi
    
    success "Test environment created at $TEST_WORKSPACE"
}

# Cleanup test environment
cleanup_test_environment() {
    if [[ -d "$TEST_WORKSPACE" ]]; then
        log "Cleaning up test environment"
        rm -rf "$TEST_WORKSPACE"
        success "Test environment cleaned up"
    fi
}

# Test installation instructions
test_installation_instructions() {
    log "Testing installation instructions..."
    
    local install_doc="$DOCS_DIR/getting-started/installation.md"
    if [[ ! -f "$install_doc" ]]; then
        skip "Installation documentation not found: $install_doc"
        return
    fi
    
    # Extract bash code blocks from installation doc
    local code_blocks=$(awk '/```bash/,/```/ {if(/```bash/) next; if(/```/) exit; print}' "$install_doc")
    
    if [[ -z "$code_blocks" ]]; then
        skip "No bash code blocks found in installation documentation"
        return
    fi
    
    # Test in clean environment
    (
        cd "$TEST_WORKSPACE"
        
        # Execute extracted commands
        echo "$code_blocks" | while IFS= read -r line; do
            if [[ -n "$line" && ! "$line" =~ ^[[:space:]]*# ]]; then
                log "Testing command: $line"
                if eval "$line" 2>/dev/null; then
                    success "Command executed successfully: $line"
                else
                    fail "Command failed: $line"
                fi
            fi
        done
    )
}

# Test quick start guide
test_quick_start_guide() {
    log "Testing quick start guide..."
    
    local quickstart_doc="$DOCS_DIR/getting-started/quick-start.md"
    if [[ ! -f "$quickstart_doc" ]]; then
        skip "Quick start documentation not found: $quickstart_doc"
        return
    fi
    
    # Create a test project following quick start
    local test_project_dir="$TEST_WORKSPACE/quickstart-test"
    mkdir -p "$test_project_dir"
    
    (
        cd "$test_project_dir"
        
        # Test project initialization
        if [[ -f "../install-simone.sh" ]]; then
            log "Testing project initialization"
            if bash ../install-simone.sh 2>/dev/null; then
                success "Project initialization successful"
            else
                fail "Project initialization failed"
            fi
        else
            skip "Install script not available for quick start test"
        fi
        
        # Test basic directory structure creation
        if [[ -d ".simone" ]]; then
            success "Simone directory structure created"
        else
            fail "Simone directory structure not created"
        fi
        
        # Test manifest creation
        if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
            success "Project manifest created"
        else
            fail "Project manifest not created"
        fi
    )
}

# Test code examples in documentation
test_code_examples() {
    log "Testing code examples in documentation..."
    
    local docs_files
    mapfile -t docs_files < <(find "$DOCS_DIR" -name "*.md" -type f)
    
    for doc_file in "${docs_files[@]}"; do
        local doc_name=$(basename "$doc_file")
        log "Checking code examples in $doc_name"
        
        # Extract bash code blocks
        local bash_blocks=$(awk '/```bash/,/```/ {if(/```bash/) next; if(/```/) exit; print}' "$doc_file")
        
        if [[ -n "$bash_blocks" ]]; then
            # Test each non-comment line
            echo "$bash_blocks" | while IFS= read -r line; do
                if [[ -n "$line" && ! "$line" =~ ^[[:space:]]*# ]]; then
                    # Basic syntax check
                    if bash -n <<< "$line" 2>/dev/null; then
                        success "Valid bash syntax: $line (in $doc_name)"
                    else
                        fail "Invalid bash syntax: $line (in $doc_name)"
                    fi
                fi
            done
        fi
        
        # Check for broken command references
        local simone_commands=$(grep -o '/project:simone:[a-zA-Z_]*' "$doc_file" || true)
        if [[ -n "$simone_commands" ]]; then
            echo "$simone_commands" | while IFS= read -r cmd; do
                local cmd_name=$(echo "$cmd" | sed 's|/project:simone:||')
                if [[ -f ".claude/commands/simone/$cmd_name.md" ]]; then
                    success "Valid command reference: $cmd (in $doc_name)"
                else
                    fail "Invalid command reference: $cmd (in $doc_name)"
                fi
            done
        fi
    done
}

# Test template examples
test_template_examples() {
    log "Testing template examples..."
    
    local template_dir=".claude/templates/simone"
    if [[ ! -d "$template_dir" ]]; then
        skip "Template directory not found: $template_dir"
        return
    fi
    
    local template_files
    mapfile -t template_files < <(find "$template_dir" -name "*.md" -type f)
    
    for template_file in "${template_files[@]}"; do
        local template_name=$(basename "$template_file" .md)
        log "Testing template: $template_name"
        
        # Check YAML frontmatter validity
        if head -1 "$template_file" | grep -q '^---$'; then
            local yaml_end=$(tail -n +2 "$template_file" | grep -n '^---$' | head -1 | cut -d: -f1)
            if [[ -n "$yaml_end" ]]; then
                success "Valid YAML frontmatter in template: $template_name"
            else
                fail "Invalid YAML frontmatter in template: $template_name"
            fi
        else
            warn "No YAML frontmatter in template: $template_name"
        fi
        
        # Check for required template fields
        local required_fields=("title" "type" "created_date")
        for field in "${required_fields[@]}"; do
            if grep -q "^$field:" "$template_file"; then
                success "Required field '$field' found in template: $template_name"
            else
                fail "Required field '$field' missing in template: $template_name"
            fi
        done
    done
}

# Test example project structures
test_example_projects() {
    log "Testing example project structures..."
    
    local examples_dir="examples"
    if [[ ! -d "$examples_dir" ]]; then
        skip "Examples directory not found: $examples_dir"
        return
    fi
    
    local example_projects
    mapfile -t example_projects < <(find "$examples_dir" -mindepth 1 -maxdepth 1 -type d)
    
    for project_dir in "${example_projects[@]}"; do
        local project_name=$(basename "$project_dir")
        log "Testing example project: $project_name"
        
        # Check for required Simone structure
        if [[ -d "$project_dir/.simone" ]]; then
            success "Simone directory exists in example: $project_name"
        else
            fail "Simone directory missing in example: $project_name"
        fi
        
        # Check for project manifest
        if [[ -f "$project_dir/.simone/00_PROJECT_MANIFEST.md" ]]; then
            success "Project manifest exists in example: $project_name"
            
            # Validate manifest YAML
            local manifest="$project_dir/.simone/00_PROJECT_MANIFEST.md"
            if head -1 "$manifest" | grep -q '^---$'; then
                success "Valid manifest YAML in example: $project_name"
            else
                fail "Invalid manifest YAML in example: $project_name"
            fi
        else
            fail "Project manifest missing in example: $project_name"
        fi
        
        # Check for basic directory structure
        local required_dirs=("01_PROJECT_DOCS" "02_REQUIREMENTS")
        for dir in "${required_dirs[@]}"; do
            if [[ -d "$project_dir/.simone/$dir" ]]; then
                success "Required directory '$dir' exists in example: $project_name"
            else
                warn "Optional directory '$dir' missing in example: $project_name"
            fi
        done
    done
}

# Test documentation links
test_documentation_links() {
    log "Testing internal documentation links..."
    
    local docs_files
    mapfile -t docs_files < <(find "$DOCS_DIR" -name "*.md" -type f)
    
    for doc_file in "${docs_files[@]}"; do
        local doc_name=$(basename "$doc_file")
        
        # Extract relative markdown links
        local links=$(grep -o '\](\..*\.md[^)]*)' "$doc_file" | sed 's/](//' || true)
        
        if [[ -n "$links" ]]; then
            echo "$links" | while IFS= read -r link; do
                # Remove anchor fragments
                local file_link=$(echo "$link" | cut -d'#' -f1)
                local full_path=$(realpath "$(dirname "$doc_file")/$file_link" 2>/dev/null || echo "")
                
                if [[ -f "$full_path" ]]; then
                    success "Valid link: $link (in $doc_name)"
                else
                    fail "Broken link: $link (in $doc_name)"
                fi
            done
        fi
    done
}

# Test command documentation consistency
test_command_documentation() {
    log "Testing command documentation consistency..."
    
    local commands_dir=".claude/commands/simone"
    local command_ref="$DOCS_DIR/core-components/command-reference.md"
    
    if [[ ! -d "$commands_dir" ]]; then
        skip "Commands directory not found: $commands_dir"
        return
    fi
    
    if [[ ! -f "$command_ref" ]]; then
        skip "Command reference documentation not found: $command_ref"
        return
    fi
    
    # Check that all commands are documented
    local command_files
    mapfile -t command_files < <(find "$commands_dir" -name "*.md" -type f)
    
    for cmd_file in "${command_files[@]}"; do
        local cmd_name=$(basename "$cmd_file" .md)
        
        if grep -q "$cmd_name" "$command_ref"; then
            success "Command documented: $cmd_name"
        else
            fail "Command not documented: $cmd_name"
        fi
    done
}

# Generate test report
generate_test_report() {
    local report_file="$TEST_RESULTS_FILE"
    
    echo
    log "=== DOCUMENTATION TEST REPORT ==="
    echo
    
    # Summary
    echo -e "${BLUE}Test Summary:${NC}"
    echo -e "  Total Tests: $TESTS_RUN"
    echo -e "  ${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "  ${RED}Failed: $TESTS_FAILED${NC}"
    echo -e "  ${YELLOW}Skipped: $TESTS_SKIPPED${NC}"
    echo
    
    # Calculate success rate
    if [[ $TESTS_RUN -gt 0 ]]; then
        local success_rate=$((TESTS_PASSED * 100 / TESTS_RUN))
        echo -e "${BLUE}Success Rate: ${success_rate}%${NC}"
    fi
    echo
    
    # Save results to file
    cat > "$report_file" << EOF
Simone Documentation Test Results
Generated: $(date)

Summary:
- Total Tests: $TESTS_RUN
- Passed: $TESTS_PASSED
- Failed: $TESTS_FAILED
- Skipped: $TESTS_SKIPPED
- Success Rate: $((TESTS_RUN > 0 ? TESTS_PASSED * 100 / TESTS_RUN : 0))%

Test Categories:
- Installation Instructions
- Quick Start Guide
- Code Examples
- Template Examples
- Example Projects
- Documentation Links
- Command Documentation

EOF
    
    success "Test report saved to $report_file"
    
    # Return appropriate exit code
    if [[ $TESTS_FAILED -gt 0 ]]; then
        error "Some tests failed. See details above."
        return 1
    else
        success "All tests passed!"
        return 0
    fi
}

# Main test execution
main() {
    echo -e "${BLUE}📋 Simone Documentation Testing Framework${NC}"
    echo -e "${BLUE}=========================================${NC}"
    echo
    
    # Setup
    setup_test_environment
    
    # Run test suites
    test_installation_instructions
    test_quick_start_guide
    test_code_examples
    test_template_examples
    test_example_projects
    test_documentation_links
    test_command_documentation
    
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
case "${1:-}" in
    --help|-h)
        echo "Simone Documentation Testing Framework"
        echo
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --help, -h          Show this help message"
        echo "  --quick             Run only quick tests (no environment setup)"
        echo "  --verbose           Enable verbose output"
        echo "  --category <name>   Run only specific test category"
        echo
        echo "Test Categories:"
        echo "  installation        Test installation instructions"
        echo "  quickstart          Test quick start guide"
        echo "  examples            Test code examples"
        echo "  templates           Test template examples"
        echo "  projects            Test example projects"
        echo "  links               Test documentation links"
        echo "  commands            Test command documentation"
        echo
        echo "Output:"
        echo "  Results are displayed on console and saved to $TEST_RESULTS_FILE"
        echo
        exit 0
        ;;
    --quick)
        # Skip environment setup for quick tests
        log "Running quick tests only"
        test_code_examples
        test_documentation_links
        test_command_documentation
        generate_test_report
        exit $?
        ;;
    --verbose)
        set -x
        ;;
    --category)
        if [[ -z "${2:-}" ]]; then
            error "Category name required for --category option"
            exit 1
        fi
        case "$2" in
            installation) test_installation_instructions ;;
            quickstart) test_quick_start_guide ;;
            examples) test_code_examples ;;
            templates) test_template_examples ;;
            projects) test_example_projects ;;
            links) test_documentation_links ;;
            commands) test_command_documentation ;;
            *)
                error "Unknown test category: $2"
                exit 1
                ;;
        esac
        generate_test_report
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

# Run main function
main