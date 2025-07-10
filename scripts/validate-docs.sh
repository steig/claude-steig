#!/bin/bash

# Simone Framework Documentation Validation Script
# Validates documentation structure, links, and metadata consistency

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOCS_DIR="docs"
SIMONE_DIR=".simone"
SCRIPTS_DIR="scripts"

# Counters
ERRORS=0
WARNINGS=0
CHECKS=0

# Utility functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((CHECKS++))
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    ((WARNINGS++))
    ((CHECKS++))
}

error() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((ERRORS++))
    ((CHECKS++))
}

# Check if running from project root
check_project_root() {
    if [[ ! -f "README.md" || ! -d "$DOCS_DIR" ]]; then
        error "Please run this script from the project root directory"
        exit 1
    fi
    success "Running from correct project root"
}

# Validate documentation structure
validate_docs_structure() {
    log "Validating documentation structure..."
    
    # Check main documentation directories
    local required_dirs=(
        "docs/getting-started"
        "docs/core-components" 
        "docs/workflows"
        "docs/best-practices"
        "docs/advanced"
        "docs/administration"
    )
    
    for dir in "${required_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            success "Directory exists: $dir"
        else
            error "Missing required directory: $dir"
        fi
    done
    
    # Check key documentation files
    local required_files=(
        "docs/README.md"
        "docs/getting-started/installation.md"
        "docs/getting-started/quick-start.md"
        "docs/core-components/command-reference.md"
        "docs/core-components/template-system.md"
        "README.md"
        "CHANGELOG.md"
    )
    
    for file in "${required_files[@]}"; do
        if [[ -f "$file" ]]; then
            success "File exists: $file"
        else
            error "Missing required file: $file"
        fi
    done
}

# Check for broken internal links
validate_internal_links() {
    log "Validating internal documentation links..."
    
    # Find all markdown files
    local md_files
    mapfile -t md_files < <(find docs -name "*.md" 2>/dev/null)
    
    for file in "${md_files[@]}"; do
        # Check for markdown links
        while IFS= read -r line; do
            # Extract relative links
            if echo "$line" | grep -q '\](\..*\.md'; then
                local link
                link=$(echo "$line" | grep -o '\](\..*\.md' | sed 's/](//')
                local full_path
                full_path=$(dirname "$file")/"$link"
                
                if [[ -f "$full_path" ]]; then
                    success "Valid link: $file -> $link"
                else
                    error "Broken link: $file -> $link (target not found)"
                fi
            fi
        done < "$file"
    done
}

# Validate Simone structure if present
validate_simone_structure() {
    if [[ ! -d "$SIMONE_DIR" ]]; then
        warn "No .simone directory found (this is optional for documentation validation)"
        return
    fi
    
    log "Validating Simone framework structure..."
    
    # Check main Simone directories
    local simone_dirs=(
        ".simone/01_PROJECT_DOCS"
        ".simone/02_REQUIREMENTS"
        ".simone/03_SPRINTS"
        ".simone/04_GENERAL_TASKS"
        ".simone/05_ARCHITECTURAL_DECISIONS"
        ".simone/10_STATE_OF_PROJECT"
        ".simone/99_TEMPLATES"
    )
    
    for dir in "${simone_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            success "Simone directory exists: $dir"
        else
            warn "Missing Simone directory: $dir"
        fi
    done
    
    # Check for project manifest
    if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
        success "Project manifest exists"
    else
        warn "Missing project manifest: .simone/00_PROJECT_MANIFEST.md"
    fi
}

# Validate YAML frontmatter in documentation
validate_yaml_frontmatter() {
    log "Validating YAML frontmatter in documentation..."
    
    local md_files
    mapfile -t md_files < <(find docs -name "*.md" 2>/dev/null)
    
    for file in "${md_files[@]}"; do
        # Check if file has YAML frontmatter
        if head -1 "$file" | grep -q '^---$'; then
            # Find the closing --- line
            local yaml_end
            yaml_end=$(tail -n +2 "$file" | grep -n '^---$' | head -1 | cut -d: -f1)
            
            if [[ -n "$yaml_end" ]]; then
                success "Valid YAML frontmatter: $file"
            else
                warn "Incomplete YAML frontmatter: $file"
            fi
        else
            # Some docs files don't require YAML frontmatter
            if [[ "$file" == *"/README.md" ]]; then
                success "README file (YAML optional): $file"
            else
                warn "No YAML frontmatter: $file"
            fi
        fi
    done
}

# Check for TODO and FIXME comments
check_todos_and_fixmes() {
    log "Checking for TODO and FIXME comments..."
    
    local md_files
    mapfile -t md_files < <(find docs -name "*.md" 2>/dev/null)
    
    local todo_count=0
    local fixme_count=0
    
    for file in "${md_files[@]}"; do
        # Count TODOs
        local file_todos
        file_todos=$(grep -c "TODO\|todo" "$file" 2>/dev/null || true)
        if [[ "$file_todos" -gt 0 ]]; then
            warn "Found $file_todos TODO(s) in: $file"
            ((todo_count += file_todos))
        fi
        
        # Count FIXMEs
        local file_fixmes
        file_fixmes=$(grep -c "FIXME\|fixme" "$file" 2>/dev/null || true)
        if [[ "$file_fixmes" -gt 0 ]]; then
            warn "Found $file_fixmes FIXME(s) in: $file"
            ((fixme_count += file_fixmes))
        fi
    done
    
    if [[ "$todo_count" -eq 0 && "$fixme_count" -eq 0 ]]; then
        success "No TODO or FIXME comments found"
    else
        warn "Found $todo_count TODOs and $fixme_count FIXMEs across documentation"
    fi
}

# Validate command reference completeness
validate_command_reference() {
    if [[ ! -f "docs/core-components/command-reference.md" ]]; then
        error "Command reference documentation missing"
        return
    fi
    
    log "Validating command reference completeness..."
    
    # Check if .claude/commands directory exists
    if [[ -d ".claude/commands/simone" ]]; then
        local command_files
        mapfile -t command_files < <(find .claude/commands/simone -name "*.md" 2>/dev/null)
        
        local documented_commands=0
        local total_commands=${#command_files[@]}
        
        for cmd_file in "${command_files[@]}"; do
            local cmd_name
            cmd_name=$(basename "$cmd_file" .md)
            
            # Check if command is documented in command reference
            if grep -q "$cmd_name" docs/core-components/command-reference.md; then
                ((documented_commands++))
            else
                warn "Command not documented in reference: $cmd_name"
            fi
        done
        
        if [[ "$documented_commands" -eq "$total_commands" ]]; then
            success "All $total_commands commands are documented"
        else
            warn "$documented_commands/$total_commands commands documented in reference"
        fi
    else
        warn "No Simone commands directory found"
    fi
}

# Check file permissions
check_file_permissions() {
    log "Checking file permissions..."
    
    # Check if any files are executable that shouldn't be
    local md_files
    mapfile -t md_files < <(find docs -name "*.md" -executable 2>/dev/null)
    
    if [[ ${#md_files[@]} -gt 0 ]]; then
        warn "Found executable markdown files (should be 644):"
        for file in "${md_files[@]}"; do
            warn "  $file"
        done
    else
        success "No incorrectly executable markdown files found"
    fi
    
    # Check for scripts that should be executable
    if [[ -d "$SCRIPTS_DIR" ]]; then
        local script_files
        mapfile -t script_files < <(find "$SCRIPTS_DIR" -name "*.sh" 2>/dev/null)
        
        for script in "${script_files[@]}"; do
            if [[ -x "$script" ]]; then
                success "Script is executable: $script"
            else
                warn "Script should be executable: $script"
            fi
        done
    fi
}

# Generate validation report
generate_report() {
    echo
    log "=== VALIDATION REPORT ==="
    echo
    
    if [[ "$ERRORS" -eq 0 && "$WARNINGS" -eq 0 ]]; then
        echo -e "${GREEN}✅ ALL CHECKS PASSED${NC}"
        echo -e "${GREEN}   Total checks: $CHECKS${NC}"
    elif [[ "$ERRORS" -eq 0 ]]; then
        echo -e "${YELLOW}⚠️  PASSED WITH WARNINGS${NC}"
        echo -e "${GREEN}   Successful checks: $((CHECKS - WARNINGS))${NC}"
        echo -e "${YELLOW}   Warnings: $WARNINGS${NC}"
    else
        echo -e "${RED}❌ VALIDATION FAILED${NC}"
        echo -e "${GREEN}   Successful checks: $((CHECKS - WARNINGS - ERRORS))${NC}"
        echo -e "${YELLOW}   Warnings: $WARNINGS${NC}"
        echo -e "${RED}   Errors: $ERRORS${NC}"
    fi
    
    echo
    
    # Return appropriate exit code
    if [[ "$ERRORS" -gt 0 ]]; then
        exit 1
    else
        exit 0
    fi
}

# Main execution
main() {
    echo -e "${BLUE}🔍 Simone Framework Documentation Validator${NC}"
    echo -e "${BLUE}=============================================${NC}"
    echo
    
    check_project_root
    validate_docs_structure
    validate_internal_links
    validate_simone_structure
    validate_yaml_frontmatter
    check_todos_and_fixmes
    validate_command_reference
    check_file_permissions
    
    generate_report
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Simone Framework Documentation Validator"
        echo
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --quiet, -q    Suppress info messages (errors and warnings only)"
        echo "  --strict       Treat warnings as errors"
        echo
        echo "Exit codes:"
        echo "  0 = All checks passed (or passed with warnings in non-strict mode)"
        echo "  1 = Validation errors found"
        echo
        echo "Examples:"
        echo "  $0                    # Run all validation checks"
        echo "  $0 --quiet           # Run quietly, show only errors/warnings"
        echo "  $0 --strict          # Fail on any warnings"
        exit 0
        ;;
    --quiet|-q)
        # Suppress log messages in quiet mode
        log() { :; }
        success() { ((CHECKS++)); }
        ;;
    --strict)
        # In strict mode, warnings become errors
        warn() {
            echo -e "${RED}[FAIL]${NC} $1"
            ((ERRORS++))
            ((CHECKS++))
        }
        ;;
    --version)
        echo "Simone Documentation Validator v1.0.0"
        exit 0
        ;;
    "")
        # No arguments - run normally
        ;;
    *)
        echo "Unknown option: $1. Use --help for usage information."
        exit 1
        ;;
esac

# Run main function
main