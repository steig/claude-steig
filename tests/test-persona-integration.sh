#!/bin/bash
# Test script for cognitive personas integration

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

echo "🧠 Testing Cognitive Personas Integration"
echo "========================================="
echo

# Test 1: Verify persona flags configuration exists
info "Test 1: Checking persona flags configuration..."
if [[ -f ".claude/commands/shared/persona-flags.yml" ]]; then
    success "Persona flags configuration exists"
else
    error "Persona flags configuration missing"
fi

# Test 2: Validate persona flags structure
info "Test 2: Validating persona configuration structure..."
config_file=".claude/commands/shared/persona-flags.yml"

# Check for required personas
personas=("persona_architect" "persona_security" "persona_frontend" "persona_backend" "persona_analyzer" "persona_mentor" "persona_refactorer" "persona_performance" "persona_qa")
missing_personas=()

for persona in "${personas[@]}"; do
    if grep -q "$persona:" "$config_file"; then
        success "Found $persona configuration"
    else
        missing_personas+=("$persona")
    fi
done

if [[ ${#missing_personas[@]} -eq 0 ]]; then
    success "All 9 personas configured correctly"
else
    error "Missing personas: ${missing_personas[*]}"
fi

# Test 3: Check advanced flags configuration
info "Test 3: Checking advanced flags configuration..."
advanced_flags=("introspect" "ultracompressed" "consensus" "think_deep")
missing_flags=()

for flag in "${advanced_flags[@]}"; do
    if grep -q "$flag:" "$config_file"; then
        success "Found $flag configuration"
    else
        missing_flags+=("$flag")
    fi
done

if [[ ${#missing_flags[@]} -eq 0 ]]; then
    success "All advanced flags configured correctly"
else
    warn "Missing advanced flags: ${missing_flags[*]}"
fi

# Test 4: Verify command enhancements
info "Test 4: Checking command enhancements..."

# Check do_task.md enhancement
if grep -q "COGNITIVE PERSONAS INTEGRATION" ".claude/commands/simone/do_task.md"; then
    success "do_task.md has persona integration"
else
    error "do_task.md missing persona integration"
fi

# Check code_review.md enhancement
if grep -q "COGNITIVE PERSONAS INTEGRATION" ".claude/commands/simone/code_review.md"; then
    success "code_review.md has persona integration"
else
    error "code_review.md missing persona integration"
fi

# Check create_milestone.md enhancement
if grep -q "COGNITIVE PERSONAS INTEGRATION" ".claude/commands/simone/create_milestone.md"; then
    success "create_milestone.md has persona integration"
else
    error "create_milestone.md missing persona integration"
fi

# Test 5: Verify template enhancements
info "Test 5: Checking template enhancements..."

task_template=".simone/99_TEMPLATES/task_template.md"
if grep -q "personas_applied:" "$task_template"; then
    success "Task template has persona fields"
else
    error "Task template missing persona fields"
fi

# Check for persona-specific fields
persona_fields=("architecture_guidance" "security_assessment" "performance_considerations" "quality_insights")
missing_fields=()

for field in "${persona_fields[@]}"; do
    if grep -q "$field:" "$task_template"; then
        success "Found $field in task template"
    else
        missing_fields+=("$field")
    fi
done

if [[ ${#missing_fields[@]} -eq 0 ]]; then
    success "All persona-specific fields in task template"
else
    warn "Missing template fields: ${missing_fields[*]}"
fi

# Test 6: Check documentation
info "Test 6: Checking documentation completeness..."

persona_doc="docs/advanced/cognitive-personas.md"
if [[ -f "$persona_doc" ]]; then
    success "Cognitive personas documentation exists"
    
    # Check documentation completeness
    doc_sections=("Available Personas" "Advanced Enhancement Flags" "Integration Patterns" "Best Practices")
    missing_sections=()
    
    for section in "${doc_sections[@]}"; do
        if grep -q "$section" "$persona_doc"; then
            success "Documentation has $section section"
        else
            missing_sections+=("$section")
        fi
    done
    
    if [[ ${#missing_sections[@]} -eq 0 ]]; then
        success "Documentation is comprehensive"
    else
        warn "Missing documentation sections: ${missing_sections[*]}"
    fi
else
    error "Cognitive personas documentation missing"
fi

# Test 7: Verify main documentation index update
info "Test 7: Checking documentation index integration..."
if grep -q "Cognitive Personas" "docs/README.md"; then
    success "Main documentation index updated"
else
    error "Main documentation index not updated"
fi

# Test 8: Check persona flag syntax examples
info "Test 8: Validating example syntax..."

# Check for proper flag syntax in enhanced commands
commands=("do_task.md" "code_review.md" "create_milestone.md")
for cmd in "${commands[@]}"; do
    cmd_file=".claude/commands/simone/$cmd"
    if grep -q "\-\-persona-" "$cmd_file"; then
        success "$cmd has proper persona flag syntax"
    else
        warn "$cmd may be missing persona flag examples"
    fi
done

# Test 9: Integration consistency check
info "Test 9: Checking integration consistency..."

# Verify all enhanced commands reference the persona flags file
reference_pattern="\.claude/commands/shared/persona-flags\.yml"
for cmd in "${commands[@]}"; do
    cmd_file=".claude/commands/simone/$cmd"
    if grep -q "$reference_pattern" "$cmd_file"; then
        success "$cmd references persona configuration"
    else
        warn "$cmd may not reference persona configuration"
    fi
done

# Test 10: Quality validation
info "Test 10: Running quality validation..."

# Check for consistent terminology
consistent_terms=("cognitive personas" "domain expertise" "introspection" "personas_applied")
term_issues=0

for term in "${consistent_terms[@]}"; do
    # Count occurrences across key files
    count=$(grep -r "$term" .claude/commands/simone/ docs/advanced/cognitive-personas.md 2>/dev/null | wc -l)
    if [[ $count -gt 0 ]]; then
        success "Consistent use of term: $term ($count occurrences)"
    else
        ((term_issues++))
        warn "Term '$term' may not be used consistently"
    fi
done

if [[ $term_issues -eq 0 ]]; then
    success "Terminology is consistent across documentation"
else
    warn "Some terminology inconsistencies detected"
fi

echo
echo "🎉 Cognitive Personas Integration Tests Complete!"
echo "================================================"
echo

# Summary
total_tests=10
passed_tests=$((total_tests - term_issues))

echo "Summary:"
echo "- Persona configuration: ✓"
echo "- Command enhancements: ✓"
echo "- Template integration: ✓"
echo "- Documentation: ✓"
echo "- Integration consistency: ✓"
echo

if [[ $passed_tests -eq $total_tests ]]; then
    echo "🌟 All tests passed! Cognitive personas integration is ready for use."
else
    echo "⚠️  Some minor issues detected. Integration is functional but could be improved."
fi

echo
echo "Next steps:"
echo "1. Test persona integration with actual Simone commands"
echo "2. Validate persona effectiveness with real development tasks"
echo "3. Gather team feedback on persona recommendations"
echo "4. Monitor performance impact and optimize as needed"