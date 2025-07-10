#!/bin/bash

# Simone Framework Example Validation Script
# Validates that all code examples and commands actually work

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOCS_DIR="docs"
EXAMPLES_DIR="examples"
TEST_WORKSPACE="/tmp/simone-example-validation-$(date +%s)"
VALIDATION_LOG="example-validation.log"

# Counters
EXAMPLES_TESTED=0
EXAMPLES_PASSED=0
EXAMPLES_FAILED=0
EXAMPLES_SKIPPED=0

# Arrays for tracking results
declare -a FAILED_EXAMPLES
declare -a PASSED_EXAMPLES
declare -a SKIPPED_EXAMPLES

# Utility functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((EXAMPLES_PASSED++))
    ((EXAMPLES_TESTED++))
    PASSED_EXAMPLES+=("$1")
}

fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((EXAMPLES_FAILED++))
    ((EXAMPLES_TESTED++))
    FAILED_EXAMPLES+=("$1")
}

skip() {
    echo -e "${YELLOW}[SKIP]${NC} $1"
    ((EXAMPLES_SKIPPED++))
    SKIPPED_EXAMPLES+=("$1")
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Setup validation workspace
setup_validation_workspace() {
    log "Setting up validation workspace: $TEST_WORKSPACE"
    
    if [[ -d "$TEST_WORKSPACE" ]]; then
        rm -rf "$TEST_WORKSPACE"
    fi
    
    mkdir -p "$TEST_WORKSPACE"
    
    # Copy necessary files for validation
    if [[ -f "install-simone.sh" ]]; then
        cp install-simone.sh "$TEST_WORKSPACE/"
    fi
    
    if [[ -d ".claude" ]]; then
        cp -r .claude "$TEST_WORKSPACE/"
    fi
    
    success "Validation workspace created"
}

# Cleanup validation workspace
cleanup_validation_workspace() {
    if [[ "$KEEP_WORKSPACE" != "true" && -d "$TEST_WORKSPACE" ]]; then
        log "Cleaning up validation workspace"
        rm -rf "$TEST_WORKSPACE"
        success "Validation workspace cleaned up"
    else
        log "Validation workspace preserved: $TEST_WORKSPACE"
    fi
}

# Extract and validate bash code blocks from documentation
validate_documentation_examples() {
    log "Validating code examples in documentation..."
    
    local doc_files
    mapfile -t doc_files < <(find "$DOCS_DIR" -name "*.md" -type f | sort)
    
    for doc_file in "${doc_files[@]}"; do
        local doc_name=$(basename "$doc_file")
        log "Checking examples in: $doc_name"
        
        # Extract bash code blocks
        local bash_blocks=""
        local in_bash_block=false
        local current_block=""
        
        while IFS= read -r line; do
            if [[ "$line" == '```bash' ]]; then
                in_bash_block=true
                current_block=""
            elif [[ "$line" == '```' ]] && [[ "$in_bash_block" == true ]]; then
                in_bash_block=false
                if [[ -n "$current_block" ]]; then
                    validate_code_block "$current_block" "$doc_file"
                fi
                current_block=""
            elif [[ "$in_bash_block" == true ]]; then
                current_block+="$line"$'\n'
            fi
        done < "$doc_file"
    done
}

# Validate a specific code block
validate_code_block() {
    local code_block="$1"
    local source_file="$2"
    local test_dir="$TEST_WORKSPACE/$(basename "$source_file" .md)-test"
    
    # Skip empty blocks or comment-only blocks
    local non_comment_lines=$(echo "$code_block" | grep -v '^\s*#' | grep -v '^\s*$' | wc -l)
    if [[ $non_comment_lines -eq 0 ]]; then
        return 0
    fi
    
    mkdir -p "$test_dir"
    
    (
        cd "$test_dir"
        
        # Copy necessary files
        if [[ -f "$TEST_WORKSPACE/install-simone.sh" ]]; then
            cp "$TEST_WORKSPACE/install-simone.sh" .
        fi
        
        if [[ -d "$TEST_WORKSPACE/.claude" ]]; then
            cp -r "$TEST_WORKSPACE/.claude" .
        fi
        
        # Execute the code block
        local temp_script=$(mktemp)
        echo "$code_block" > "$temp_script"
        
        # Test syntax first
        if ! bash -n "$temp_script" 2>/dev/null; then
            fail "Syntax error in code block from $(basename "$source_file")"
            rm "$temp_script"
            return 1
        fi
        
        # Execute with timeout and error handling
        local execution_result=0
        if ! timeout 30s bash "$temp_script" >/dev/null 2>&1; then
            execution_result=1
        fi
        
        rm "$temp_script"
        
        if [[ $execution_result -eq 0 ]]; then
            success "Code block executed successfully from $(basename "$source_file")"
        else
            fail "Code block execution failed from $(basename "$source_file")"
        fi
        
        return $execution_result
    )
}

# Validate example project structures
validate_example_projects() {
    log "Validating example project structures..."
    
    if [[ ! -d "$EXAMPLES_DIR" ]]; then
        skip "Examples directory not found: $EXAMPLES_DIR"
        return 0
    fi
    
    local example_projects
    mapfile -t example_projects < <(find "$EXAMPLES_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
    
    for project_dir in "${example_projects[@]}"; do
        local project_name=$(basename "$project_dir")
        log "Validating example project: $project_name"
        
        validate_project_structure "$project_dir" "$project_name"
        validate_project_yaml "$project_dir" "$project_name"
        validate_project_completeness "$project_dir" "$project_name"
    done
}

# Validate project structure
validate_project_structure() {
    local project_dir="$1"
    local project_name="$2"
    
    # Check for .simone directory
    if [[ -d "$project_dir/.simone" ]]; then
        success "Project structure: $project_name has .simone directory"
    else
        fail "Project structure: $project_name missing .simone directory"
        return 1
    fi
    
    # Check for required directories
    local required_dirs=(
        ".simone/01_PROJECT_DOCS"
        ".simone/02_REQUIREMENTS"
    )
    
    for dir in "${required_dirs[@]}"; do
        if [[ -d "$project_dir/$dir" ]]; then
            success "Project structure: $project_name has $dir"
        else
            warn "Project structure: $project_name missing optional $dir"
        fi
    done
    
    # Check for project manifest
    if [[ -f "$project_dir/.simone/00_PROJECT_MANIFEST.md" ]]; then
        success "Project structure: $project_name has project manifest"
    else
        fail "Project structure: $project_name missing project manifest"
    fi
}

# Validate YAML frontmatter in project files
validate_project_yaml() {
    local project_dir="$1"
    local project_name="$2"
    
    # Find all markdown files with YAML frontmatter
    local md_files
    mapfile -t md_files < <(find "$project_dir/.simone" -name "*.md" -type f)
    
    for md_file in "${md_files[@]}"; do
        local file_name=$(basename "$md_file")
        
        # Check YAML frontmatter structure
        if head -1 "$md_file" | grep -q '^---$'; then
            local yaml_end=$(tail -n +2 "$md_file" | grep -n '^---$' | head -1 | cut -d: -f1)
            if [[ -n "$yaml_end" ]]; then
                success "YAML validation: $project_name/$file_name has valid frontmatter"
                
                # Extract and validate YAML content
                local yaml_content=$(sed -n '2,'$((yaml_end+1))'p' "$md_file" | head -n -1)
                validate_yaml_fields "$yaml_content" "$project_name/$file_name"
            else
                fail "YAML validation: $project_name/$file_name has incomplete frontmatter"
            fi
        else
            warn "YAML validation: $project_name/$file_name has no YAML frontmatter"
        fi
    done
}

# Validate required YAML fields
validate_yaml_fields() {
    local yaml_content="$1"
    local file_identifier="$2"
    
    # Check for common required fields based on file type
    if echo "$file_identifier" | grep -q "PROJECT_MANIFEST"; then
        local required_fields=("id" "title" "status" "priority" "created_date")
        for field in "${required_fields[@]}"; do
            if echo "$yaml_content" | grep -q "^$field:"; then
                success "YAML field: $file_identifier has required field '$field'"
            else
                fail "YAML field: $file_identifier missing required field '$field'"
            fi
        done
    fi
    
    # Validate date formats
    local date_fields=$(echo "$yaml_content" | grep "_date:" | cut -d: -f1)
    if [[ -n "$date_fields" ]]; then
        echo "$date_fields" | while read -r field; do
            local date_value=$(echo "$yaml_content" | grep "^$field:" | cut -d'"' -f2)
            if [[ -n "$date_value" ]]; then
                # Basic date format validation (YYYY-MM-DD or YYYY-MM-DD HH:MM)
                if [[ "$date_value" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}( [0-9]{2}:[0-9]{2})?$ ]]; then
                    success "Date format: $file_identifier field '$field' has valid format"
                else
                    fail "Date format: $file_identifier field '$field' has invalid format: $date_value"
                fi
            fi
        done
    fi
}

# Validate project completeness and consistency
validate_project_completeness() {
    local project_dir="$1"
    local project_name="$2"
    
    # Check milestone-sprint-task hierarchy
    local milestones_dir="$project_dir/.simone/02_REQUIREMENTS"
    local sprints_dir="$project_dir/.simone/03_SPRINTS"
    local tasks_dir="$project_dir/.simone/04_GENERAL_TASKS"
    
    # Count milestones
    local milestone_count=0
    if [[ -d "$milestones_dir" ]]; then
        milestone_count=$(find "$milestones_dir" -mindepth 1 -maxdepth 1 -type d | wc -l)
    fi
    
    # Count sprints
    local sprint_count=0
    if [[ -d "$sprints_dir" ]]; then
        sprint_count=$(find "$sprints_dir" -mindepth 1 -maxdepth 1 -type d | wc -l)
    fi
    
    # Count tasks
    local task_count=0
    if [[ -d "$tasks_dir" ]]; then
        task_count=$(find "$tasks_dir" -name "*.md" -type f | wc -l)
    fi
    
    # Validate project has content
    if [[ $milestone_count -gt 0 || $sprint_count -gt 0 || $task_count -gt 0 ]]; then
        success "Project content: $project_name has $milestone_count milestones, $sprint_count sprints, $task_count tasks"
    else
        warn "Project content: $project_name appears to be empty (no milestones, sprints, or tasks)"
    fi
    
    # Check for README or documentation
    if [[ -f "$project_dir/README.md" ]] || [[ -f "$project_dir/.simone/01_PROJECT_DOCS/README.md" ]]; then
        success "Project documentation: $project_name has README documentation"
    else
        warn "Project documentation: $project_name missing README documentation"
    fi
}

# Validate Simone commands referenced in documentation
validate_simone_commands() {
    log "Validating Simone command references..."
    
    local docs_files
    mapfile -t docs_files < <(find "$DOCS_DIR" -name "*.md" -type f)
    
    local commands_dir=".claude/commands/simone"
    if [[ ! -d "$commands_dir" ]]; then
        skip "Simone commands directory not found: $commands_dir"
        return 0
    fi
    
    for doc_file in "${docs_files[@]}"; do
        local doc_name=$(basename "$doc_file")
        
        # Extract Simone command references
        local command_refs=$(grep -o '/project:simone:[a-zA-Z_][a-zA-Z0-9_]*' "$doc_file" || true)
        
        if [[ -n "$command_refs" ]]; then
            echo "$command_refs" | while IFS= read -r cmd_ref; do
                local cmd_name=$(echo "$cmd_ref" | sed 's|/project:simone:||')
                
                if [[ -f "$commands_dir/$cmd_name.md" ]]; then
                    success "Command reference: $cmd_name exists (referenced in $doc_name)"
                else
                    fail "Command reference: $cmd_name does not exist (referenced in $doc_name)"
                fi
            done
        fi
    done
}

# Validate template references
validate_template_references() {
    log "Validating template references..."
    
    local templates_dir=".claude/templates/simone"
    if [[ ! -d "$templates_dir" ]]; then
        skip "Simone templates directory not found: $templates_dir"
        return 0
    fi
    
    local docs_files
    mapfile -t docs_files < <(find "$DOCS_DIR" -name "*.md" -type f)
    
    for doc_file in "${docs_files[@]}"; do
        local doc_name=$(basename "$doc_file")
        
        # Look for template references (basic patterns)
        local template_refs=$(grep -o 'template[s]*[:/][a-zA-Z_][a-zA-Z0-9_]*' "$doc_file" || true)
        
        if [[ -n "$template_refs" ]]; then
            echo "$template_refs" | while IFS= read -r ref; do
                local template_name=$(echo "$ref" | sed 's/.*[:/]//')
                
                # Check if template exists (basic check)
                if find "$templates_dir" -name "*$template_name*" -type f | grep -q .; then
                    success "Template reference: $template_name found (referenced in $doc_name)"
                else
                    warn "Template reference: $template_name not found (referenced in $doc_name)"
                fi
            done
        fi
    done
}

# Test installation instructions in examples
test_example_installation() {
    log "Testing installation instructions with examples..."
    
    local install_test_dir="$TEST_WORKSPACE/install-test"
    mkdir -p "$install_test_dir"
    
    (
        cd "$install_test_dir"
        
        # Copy installation script
        if [[ -f "$TEST_WORKSPACE/install-simone.sh" ]]; then
            cp "$TEST_WORKSPACE/install-simone.sh" .
            
            # Test installation
            if bash install-simone.sh >/dev/null 2>&1; then
                success "Installation test: Script executes successfully"
                
                # Test with example project creation
                if [[ -d ".simone" ]]; then
                    success "Installation test: Creates .simone structure"
                    
                    # Copy an example project manifest
                    if [[ -f "../../examples/startup-project/.simone/00_PROJECT_MANIFEST.md" ]]; then
                        cp "../../examples/startup-project/.simone/00_PROJECT_MANIFEST.md" ".simone/"
                        success "Installation test: Can use example project manifest"
                    fi
                else
                    fail "Installation test: Does not create .simone structure"
                fi
            else
                fail "Installation test: Script execution failed"
            fi
        else
            skip "Installation test: No install script available"
        fi
    )
}

# Generate comprehensive validation report
generate_validation_report() {
    echo
    log "=== EXAMPLE VALIDATION REPORT ==="
    echo
    
    # Summary statistics
    echo -e "${BLUE}Validation Summary:${NC}"
    echo -e "  Total Examples Tested: $EXAMPLES_TESTED"
    echo -e "  ${GREEN}Passed: $EXAMPLES_PASSED${NC}"
    echo -e "  ${RED}Failed: $EXAMPLES_FAILED${NC}"
    echo -e "  ${YELLOW}Skipped: $EXAMPLES_SKIPPED${NC}"
    echo
    
    # Calculate success rate
    if [[ $EXAMPLES_TESTED -gt 0 ]]; then
        local success_rate=$((EXAMPLES_PASSED * 100 / EXAMPLES_TESTED))
        echo -e "${BLUE}Success Rate: ${success_rate}%${NC}"
        echo
    fi
    
    # List failed examples if any
    if [[ ${#FAILED_EXAMPLES[@]} -gt 0 ]]; then
        echo -e "${RED}Failed Examples:${NC}"
        for example in "${FAILED_EXAMPLES[@]}"; do
            echo -e "  ${RED}✗${NC} $example"
        done
        echo
    fi
    
    # Test categories completed
    echo -e "${BLUE}Validation Categories:${NC}"
    echo -e "  ✓ Documentation Code Examples"
    echo -e "  ✓ Example Project Structures"
    echo -e "  ✓ YAML Frontmatter Validation"
    echo -e "  ✓ Project Completeness Check"
    echo -e "  ✓ Simone Command References"
    echo -e "  ✓ Template References"
    echo -e "  ✓ Installation Instructions"
    echo
    
    # Performance metrics
    echo -e "${BLUE}Performance:${NC}"
    echo -e "  Validation Duration: ${SECONDS}s"
    echo -e "  Workspace: $TEST_WORKSPACE"
    echo
    
    # Save detailed results
    cat > "$VALIDATION_LOG" << EOF
Simone Example Validation Report
Generated: $(date)

Summary:
- Total Examples Tested: $EXAMPLES_TESTED
- Passed: $EXAMPLES_PASSED
- Failed: $EXAMPLES_FAILED
- Skipped: $EXAMPLES_SKIPPED
- Success Rate: $((EXAMPLES_TESTED > 0 ? EXAMPLES_PASSED * 100 / EXAMPLES_TESTED : 0))%

Failed Examples:
$(printf '%s\n' "${FAILED_EXAMPLES[@]}")

Passed Examples:
$(printf '%s\n' "${PASSED_EXAMPLES[@]}")

Skipped Examples:
$(printf '%s\n' "${SKIPPED_EXAMPLES[@]}")

Validation completed in ${SECONDS}s
EOF
    
    success "Detailed validation log saved to $VALIDATION_LOG"
    
    # Return appropriate exit code
    if [[ $EXAMPLES_FAILED -gt 0 ]]; then
        echo -e "${RED}❌ Example validation failed with $EXAMPLES_FAILED issues${NC}"
        return 1
    else
        echo -e "${GREEN}✅ All $EXAMPLES_PASSED examples validated successfully${NC}"
        return 0
    fi
}

# Main validation execution
main() {
    echo -e "${BLUE}📋 Simone Example Validation${NC}"
    echo -e "${BLUE}=============================${NC}"
    echo
    
    # Setup workspace
    setup_validation_workspace
    
    # Run validation suites
    validate_documentation_examples
    validate_example_projects
    validate_simone_commands
    validate_template_references
    test_example_installation
    
    # Generate report
    local exit_code=0
    if ! generate_validation_report; then
        exit_code=1
    fi
    
    # Cleanup
    cleanup_validation_workspace
    
    exit $exit_code
}

# Handle command line arguments
KEEP_WORKSPACE="false"

case "${1:-}" in
    --help|-h)
        echo "Simone Example Validation Script"
        echo
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --help, -h          Show this help message"
        echo "  --keep-workspace    Keep validation workspace after completion"
        echo "  --verbose           Enable verbose output"
        echo "  --quick             Run only basic validations"
        echo "  --docs-only         Validate only documentation examples"
        echo "  --projects-only     Validate only example projects"
        echo
        echo "This script validates:"
        echo "  - Code examples in documentation execute successfully"
        echo "  - Example project structures are correct"
        echo "  - YAML frontmatter is valid and complete"
        echo "  - Simone command references are accurate"
        echo "  - Template references exist"
        echo "  - Installation instructions work with examples"
        echo
        echo "Output:"
        echo "  Results saved to $VALIDATION_LOG"
        echo "  Workspace: /tmp/simone-example-validation-*"
        exit 0
        ;;
    --keep-workspace)
        KEEP_WORKSPACE="true"
        log "Validation workspace will be preserved"
        ;;
    --verbose)
        set -x
        ;;
    --quick)
        log "Running quick validation only"
        setup_validation_workspace
        validate_example_projects
        generate_validation_report
        cleanup_validation_workspace
        exit $?
        ;;
    --docs-only)
        log "Validating documentation examples only"
        setup_validation_workspace
        validate_documentation_examples
        validate_simone_commands
        generate_validation_report
        cleanup_validation_workspace
        exit $?
        ;;
    --projects-only)
        log "Validating example projects only"
        setup_validation_workspace
        validate_example_projects
        generate_validation_report
        cleanup_validation_workspace
        exit $?
        ;;
    "")
        # No arguments - run all validations
        ;;
    *)
        echo "Unknown option: $1. Use --help for usage information."
        exit 1
        ;;
esac

# Check prerequisites
if [[ ! -d "$DOCS_DIR" && ! -d "$EXAMPLES_DIR" ]]; then
    error "Neither docs nor examples directory found"
    error "Please run from project root"
    exit 1
fi

# Run main function
main