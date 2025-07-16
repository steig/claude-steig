# Review Pull Request - Automated Code Review and Validation

Performs comprehensive automated code review with quality checks, security analysis, and compliance validation.

## Create a TODO with EXACTLY these 8 Items

1. Parse PR arguments and fetch PR details
2. Analyze code changes and impact assessment
3. Run automated quality and security checks
4. Validate task/bug completion requirements
5. Perform architectural and design review
6. Generate review feedback and recommendations
7. Update review status and approvals
8. Provide review summary and next steps

## DETAILS on every TODO item

### 1. Parse PR arguments and fetch PR details

**Arguments Format:** `<TASK_ID/BUG_ID/PR_URL/PR_NUMBER>`

**PR Discovery Methods:**
- **Task/Bug ID**: Find associated PR from task metadata
- **PR URL**: Extract PR details from GitHub URL
- **PR Number**: Direct PR number reference
- **Auto-detect**: Use current branch to find PR

**PR Information Extraction:**
- PR title, description, and metadata
- Changed files and diff analysis
- Commit history and authors
- Current review status and approvals
- CI/CD check results
- Related issues and task references

### 2. Analyze code changes and impact assessment

**MCP INTEGRATION:** Use MCP servers for enhanced code review:
- **Sequential Thinking**: Structure review process systematically
- **Serena**: Enhance code analysis and pattern recognition
- **Context7**: Maintain context about codebase patterns
- **GitHub**: Reference similar code reviews and outcomes

**Change Analysis:**
- **File Categories**: Source code, tests, documentation, configuration
- **Change Types**: Additions, modifications, deletions, renames
- **Complexity Assessment**: Cyclomatic complexity, lines changed
- **Risk Assessment**: Critical paths, security-sensitive areas

**Impact Assessment:**
```markdown
## 📊 Change Impact Analysis

### Files Modified: {file_count}
- **Source Code**: {source_files} files
- **Tests**: {test_files} files  
- **Documentation**: {doc_files} files
- **Configuration**: {config_files} files

### Code Metrics
- **Lines Added**: +{lines_added}
- **Lines Removed**: -{lines_removed}
- **Complexity Change**: {complexity_delta}
- **Test Coverage**: {coverage_change}%

### Risk Assessment
- **Security Impact**: {security_risk}
- **Performance Impact**: {performance_risk}
- **Breaking Changes**: {breaking_changes}
- **Backward Compatibility**: {compatibility_status}
```

### 3. Run automated quality and security checks

**Code Quality Checks:**
- **Style Compliance**: Linting and formatting validation
- **Code Standards**: Project-specific coding standards
- **Documentation**: Code comments and API documentation
- **Complexity**: Cyclomatic complexity thresholds
- **Duplication**: Code duplication detection

**Security Analysis:**
- **Vulnerability Scanning**: Known security vulnerabilities
- **Dependency Audit**: Third-party dependency security
- **Secret Detection**: Hardcoded secrets or credentials
- **Authentication/Authorization**: Security control validation
- **Input Validation**: SQL injection, XSS prevention

**Testing Validation:**
- **Test Coverage**: Minimum coverage requirements met
- **Test Quality**: Test assertions and edge case coverage
- **Integration Tests**: Critical path coverage
- **Performance Tests**: Baseline performance maintained

**Automated Tools Integration:**
```bash
# Code Quality
run_linter_checks
run_complexity_analysis
check_documentation_coverage

# Security
run_security_scanner
audit_dependencies
detect_secrets

# Testing
calculate_test_coverage
run_performance_benchmarks
validate_integration_tests
```

### 4. Validate task/bug completion requirements

**Task Completion Validation:**
- **Acceptance Criteria**: All criteria implemented and tested
- **Subtasks**: All implementation subtasks completed
- **Quality Checklist**: All quality requirements met
- **Documentation**: Required documentation updated

**Bug Fix Validation:**
- **Root Cause**: Fix addresses identified root cause
- **Regression Prevention**: Tests prevent similar issues
- **Reproduction Verification**: Original reproduction steps now pass
- **Impact Verification**: Fix resolves reported symptoms

**Requirements Traceability:**
- **Feature Implementation**: All specified features included
- **API Compliance**: API changes match specifications
- **Performance Requirements**: Performance criteria met
- **Security Requirements**: Security controls implemented

### 5. Perform architectural and design review

**Architecture Alignment:**
- **Design Patterns**: Consistent with established patterns
- **Component Interfaces**: Proper abstraction and encapsulation
- **Dependency Management**: Appropriate coupling and cohesion
- **System Integration**: Proper integration with existing systems

**Design Quality Assessment:**
- **SOLID Principles**: Single responsibility, open/closed, etc.
- **Error Handling**: Comprehensive error management
- **Resource Management**: Proper resource lifecycle
- **Scalability**: Design supports growth requirements

**Code Review Criteria:**
```markdown
## 🏗️ Architecture Review

### Design Patterns
- [ ] Follows established project patterns
- [ ] Appropriate abstraction levels
- [ ] Clear separation of concerns
- [ ] Proper dependency injection

### Code Quality
- [ ] Readable and maintainable
- [ ] Appropriate naming conventions
- [ ] Sufficient documentation
- [ ] Error handling implemented

### Performance
- [ ] No obvious performance bottlenecks
- [ ] Appropriate algorithm complexity
- [ ] Resource usage optimized
- [ ] Caching strategy appropriate
```

### 6. Generate review feedback and recommendations

**Automated Feedback Generation:**
Create structured feedback based on analysis results:

```markdown
## 🔍 Automated Code Review Results

### ✅ Strengths
{List positive aspects found in the code}

### ⚠️ Issues Found
{Categorized list of issues with severity levels}

### 🔧 Recommendations
{Specific improvement suggestions with examples}

### 📋 Action Items
{Required changes before approval}
```

**Issue Categorization:**
- **Critical**: Must fix before merge (security, breaking changes)
- **High**: Should fix before merge (architecture, performance)
- **Medium**: Consider fixing (code quality, maintainability)
- **Low**: Optional improvements (style, optimization)

**Recommendation Types:**
- **Security**: Security improvements and fixes
- **Performance**: Optimization opportunities
- **Maintainability**: Code structure improvements
- **Testing**: Additional test coverage needed
- **Documentation**: Documentation improvements

### 7. Update review status and approvals

**Review Status Management:**
- **Automated Approval**: If all checks pass and no issues found
- **Request Changes**: If critical or high issues found
- **Approve with Comments**: If only minor issues found
- **Manual Review Required**: If complex changes need human review

**GitHub Integration:**
```bash
# Add review comment
gh pr review {pr_number} --comment "$(cat <<'EOF'
## 🤖 Automated Code Review

{review_summary}

{detailed_feedback}

**Next Steps**: {action_items}
EOF
)"

# Approve or request changes
gh pr review {pr_number} --approve  # or --request-changes
```

**Review Tracking:**
- Update task/bug with review status
- Log review results in task Output Log
- Update project quality metrics
- Track review cycle time

### 8. Provide review summary and next steps

**Review Summary:**
```markdown
## 📋 Code Review Summary

### 🎯 Overall Assessment: {PASS/FAIL/NEEDS_WORK}

### 📊 Quality Metrics
- **Code Quality Score**: {quality_score}/100
- **Security Score**: {security_score}/100
- **Test Coverage**: {coverage_percentage}%
- **Documentation Score**: {doc_score}/100

### 🔍 Review Results
- **Issues Found**: {total_issues} ({critical}/{high}/{medium}/{low})
- **Recommendations**: {recommendation_count}
- **Required Actions**: {required_action_count}

### ⏭️ Next Steps

#### If PASS:
- [ ] Ready for merge
- [ ] Consider `/project:simone:merge {TASK_ID}`
- [ ] Plan deployment

#### If NEEDS_WORK:
- [ ] Address {critical_count} critical issues
- [ ] Address {high_count} high priority issues
- [ ] Consider {medium_count} medium priority improvements
- [ ] Request re-review after changes

#### If FAIL:
- [ ] Address all critical issues immediately
- [ ] Significant rework required
- [ ] Consider pair programming session
- [ ] Re-review required after major changes

### 🔗 Resources
- **Review Guidelines**: [Project Review Standards]({review_guidelines_url})
- **Coding Standards**: [Project Coding Standards]({coding_standards_url})
- **Security Guidelines**: [Security Best Practices]({security_guidelines_url})
```

## Review Types and Strategies

### Automated Review (Default)
- Comprehensive static analysis
- Security and vulnerability scanning
- Code quality and style checking
- Test coverage validation
- Documentation completeness

### Human-Assisted Review
- Automated analysis + human oversight
- Complex architectural decisions
- Business logic validation
- UX/UI design review
- Stakeholder approval required

### Express Review (Hotfixes)
- Security and critical issue focus
- Minimal change validation
- Fast-track for emergency fixes
- Reduced documentation requirements
- Immediate deployment readiness

### Comprehensive Review (Major Features)
- Full architectural review
- Performance impact analysis
- Security threat modeling
- Integration testing validation
- Cross-team coordination

## Quality Gates and Thresholds

### Code Quality Thresholds
- **Minimum Test Coverage**: 80%
- **Maximum Complexity**: 10 per function
- **Documentation Coverage**: 90% for public APIs
- **Linting Compliance**: 100%

### Security Thresholds
- **Critical Vulnerabilities**: 0 allowed
- **High Vulnerabilities**: 0 allowed
- **Medium Vulnerabilities**: Requires justification
- **Dependency Audit**: All high/critical issues resolved

### Performance Thresholds
- **Response Time**: No degradation >10%
- **Memory Usage**: No increase >5%
- **Database Queries**: N+1 detection
- **Bundle Size**: No increase >5%

## Integration Features

### CI/CD Integration
- Trigger automated reviews on PR creation
- Block merges until review passes
- Generate quality reports
- Update deployment readiness status

### Project Management Integration
- Update task/bug status based on review
- Track review metrics in project health
- Generate team performance insights
- Identify training opportunities

### Notification Integration
- Slack/Teams notifications for review results
- Email summaries for stakeholders
- Dashboard updates for managers
- Developer feedback loops

This automated review system ensures consistent, thorough code quality while integrating seamlessly with the Simone task management workflow and supporting efficient development practices.