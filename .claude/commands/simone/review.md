# Unified Review System - Comprehensive Review Management

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement through persona flags.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: System design and architecture review
- `--persona-security`: Security vulnerabilities and OWASP compliance
- `--persona-frontend`: UI/UX and frontend code quality  
- `--persona-backend`: API design and backend performance
- `--persona-analyzer`: Code metrics and quality analysis
- `--persona-mentor`: Educational feedback and best practices
- `--persona-refactorer`: Code optimization opportunities
- `--persona-performance`: Performance bottlenecks and optimization
- `--persona-qa`: Testing coverage and quality assurance

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning with 🤔 Thinking and 🎯 Decision indicators
- `--consensus`: Multi-model consensus for critical review decisions
- `--think-deep`: Extended analysis for complex code changes

**REVIEW TYPE FLAGS:**
- `--type-code`: Code quality, standards, and architecture review (default)
- `--type-quality`: Comprehensive quality assessment across all dimensions
- `--type-testing`: Test coverage, quality, and effectiveness review
- `--type-discussion`: Review discussion facilitation and decision documentation

**SCOPE FLAGS:**
- `--scope-current`: Review current changes only (default)
- `--scope-full`: Full codebase review
- `--scope-files`: Review specific files or directories
- `--scope-pr`: Review specific pull request

**USAGE EXAMPLES:**
- `/project:simone:review --type-code --persona-security --scope-current` (Security-focused code review)
- `/project:simone:review --type-quality --persona-architect --persona-performance --introspect` (Architecture quality review with transparency)
- `/project:simone:review --type-testing --persona-qa --scope-full` (Comprehensive testing review)
- `/project:simone:review --type-discussion --consensus --think-deep` (Facilitated review discussion)

**CREATE A TODO LIST** with exactly these 8 items

1. Parse review arguments and determine review type and scope
2. Load project context and identify review target
3. Execute review based on type with persona-driven analysis
4. Gather comprehensive findings and recommendations
5. Generate review report with quality metrics
6. Document decisions and action items
7. Update project tracking and create follow-up tasks
8. Provide review summary and next steps

## 1 · Parse review arguments and determine review type and scope

**REVIEW TYPE DETECTION:**
```yaml
review_types:
  code: # Code quality, standards, and architecture
    focus: [quality, standards, architecture, security, maintainability]
    personas: [architect, security, analyzer, mentor, refactorer]
    
  quality: # Comprehensive quality assessment
    focus: [code_quality, test_coverage, security, performance, documentation]
    personas: [architect, security, performance, qa, analyzer]
    
  testing: # Test coverage and effectiveness
    focus: [test_coverage, test_quality, automation, edge_cases]
    personas: [qa, analyzer, mentor]
    
  discussion: # Review discussion facilitation
    focus: [decision_making, consensus, documentation, action_items]
    personas: [mentor, architect]
```

**SCOPE DETERMINATION:**
- **current**: Git diff analysis for current changes
- **full**: Complete codebase analysis (use with caution)
- **files**: Specific file or directory paths
- **pr**: Pull request ID or URL

**AUTOMATIC PERSONA ACTIVATION:**
If no persona flags provided, automatically activate relevant personas based on review type and detected code patterns.

## 2 · Load project context and identify review target

**CONTEXT LOADING:**
- Read current project manifest and sprint status
- Identify current milestone and deliverables
- Load relevant requirements and architectural decisions
- Determine quality standards and compliance requirements

**REVIEW TARGET IDENTIFICATION:**
```bash
# Based on scope, identify what to review
case "$SCOPE" in
  current)
    git diff --name-only HEAD~1
    git diff HEAD~1
    ;;
  full)
    find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" | head -50
    ;;
  files)
    echo "$SPECIFIED_FILES"
    ;;
  pr)
    gh pr view "$PR_ID" --json files
    ;;
esac
```

**MCP INTEGRATION:**
- **Sequential Thinking**: Structure the review process systematically
- **Serena**: Enhanced code analysis and quality insights
- **GitHub**: Reference previous reviews and their outcomes

## 3 · Execute review based on type with persona-driven analysis

### 3.1 · Code Review (`--type-code`)

**PERSONA-DRIVEN CODE ANALYSIS:**

**🏗️ Architecture Persona (if activated):**
- **System Design**: Validate design patterns, SOLID principles, dependency management
- **Scalability**: Assess performance under load, resource usage, bottleneck potential
- **Integration**: Check service boundaries, API contracts, data flow consistency
- **Technical Debt**: Identify architectural anti-patterns, coupling issues

**🔒 Security Persona (if activated):**
- **OWASP Top 10**: Check for injection, broken auth, sensitive data exposure
- **Input Validation**: Verify sanitization, validation, escape mechanisms
- **Access Control**: Review authorization logic, privilege escalation risks
- **Cryptography**: Validate encryption usage, key management, secure protocols

**📊 Analyzer Persona (if activated):**
- **Code Metrics**: Complexity analysis, maintainability index, technical debt identification
- **Quality Gates**: Test coverage, linting compliance, code duplication detection
- **Performance Metrics**: Memory usage, execution time, resource consumption
- **Maintainability**: Code readability, documentation quality, refactoring needs

**STANDARD CODE REVIEW CRITERIA:**
- **Data models / schemas** — fields, types, constraints, relationships
- **APIs / interfaces** — endpoints, params, return shapes, status codes, errors
- **Config / environment** — keys, defaults, required/optional
- **Behaviour** — business rules, side-effects, error handling
- **Quality** — naming, formatting, tests, linter status

### 3.2 · Quality Review (`--type-quality`)

**COMPREHENSIVE QUALITY ASSESSMENT:**

**Quality Dimensions:**
```yaml
quality_assessment:
  code_quality:
    - maintainability_index
    - cyclomatic_complexity
    - code_duplication_percentage
    - naming_conventions_compliance
    
  test_quality:
    - test_coverage_percentage
    - test_quality_score
    - edge_case_coverage
    - integration_test_coverage
    
  security_quality:
    - vulnerability_count
    - security_score
    - dependency_audit_results
    - secrets_detection_status
    
  performance_quality:
    - performance_benchmark_results
    - memory_usage_analysis
    - query_optimization_status
    - bundle_size_analysis
    
  documentation_quality:
    - documentation_completeness
    - api_documentation_currency
    - code_comment_adequacy
    - architectural_decision_records
```

### 3.3 · Testing Review (`--type-testing`)

**✅ QA Persona Testing Focus:**
- **Test Coverage**: Unit, integration, end-to-end test completeness
- **Quality Assurance**: Bug prevention, edge case handling, error scenarios
- **Validation**: Input validation, output verification, boundary testing
- **Regression Prevention**: Breaking change analysis, backward compatibility

**TESTING REVIEW AREAS:**
```yaml
testing_analysis:
  coverage_analysis:
    - unit_test_coverage
    - integration_test_coverage
    - e2e_test_coverage
    - branch_coverage
    - function_coverage
    
  test_quality:
    - test_maintainability
    - test_readability
    - assertion_quality
    - test_data_management
    
  automation_effectiveness:
    - ci_cd_integration
    - automated_regression_testing
    - performance_testing_automation
    - security_testing_integration
    
  gap_analysis:
    - missing_test_scenarios
    - edge_case_coverage_gaps
    - integration_testing_gaps
    - performance_testing_gaps
```

### 3.4 · Discussion Review (`--type-discussion`)

**🎓 Mentor Persona Discussion Facilitation:**
- **Best Practices**: Industry standards, coding conventions, design patterns
- **Educational Value**: Code clarity, documentation, learning opportunities
- **Knowledge Transfer**: Maintainability for team members, onboarding considerations
- **Growth Opportunities**: Skill development recommendations, improvement suggestions

**DISCUSSION FACILITATION:**
- Structured discussion around review findings
- Decision documentation with rationale
- Action item generation with ownership
- Consensus building around recommendations
- Knowledge sharing and best practices documentation

## 4 · Gather comprehensive findings and recommendations

**FINDINGS AGGREGATION:**
```yaml
review_findings:
  critical_issues:
    - issue: "Security vulnerability in authentication"
      severity: "critical"
      persona: "security"
      recommendation: "Implement proper input validation"
      
  high_priority_improvements:
    - issue: "High cyclomatic complexity in user service"
      severity: "high" 
      persona: "analyzer"
      recommendation: "Refactor into smaller functions"
      
  medium_priority_suggestions:
    - issue: "Missing error handling in payment processor"
      severity: "medium"
      persona: "architect"
      recommendation: "Add comprehensive error handling"
      
  best_practice_recommendations:
    - recommendation: "Consider implementing repository pattern"
      persona: "mentor"
      benefit: "Improved testability and maintainability"
```

**AUTOMATED ISSUE CATEGORIZATION:**
- **Blockers**: Critical issues that prevent deployment
- **High Priority**: Issues that significantly impact quality or security
- **Medium Priority**: Improvements that enhance maintainability
- **Low Priority**: Style and convention improvements
- **Best Practices**: Educational recommendations for improvement

## 5 · Generate review report with quality metrics

**COMPREHENSIVE REVIEW REPORT:**
```markdown
# Review Report - {REVIEW_TYPE} Review

**Review Date**: {CURRENT_DATE}
**Review Type**: {REVIEW_TYPE}
**Review Scope**: {REVIEW_SCOPE}
**Reviewer**: Claude with {ACTIVE_PERSONAS} personas
**Overall Status**: PASS/CONDITIONAL_PASS/FAIL

## Executive Summary
{AI_GENERATED_SUMMARY}

## Quality Metrics
- **Code Quality Score**: {SCORE}/10
- **Security Score**: {SCORE}/10
- **Performance Score**: {SCORE}/10
- **Test Coverage**: {PERCENTAGE}%
- **Documentation Score**: {SCORE}/10

## Findings by Severity

### 🔴 Critical Issues ({COUNT})
{CRITICAL_ISSUES_LIST}

### 🟡 High Priority ({COUNT})
{HIGH_PRIORITY_LIST}

### 🟢 Medium Priority ({COUNT})
{MEDIUM_PRIORITY_LIST}

### 💡 Recommendations ({COUNT})
{RECOMMENDATIONS_LIST}

## Persona-Specific Analysis
{DETAILED_PERSONA_FINDINGS}

## Action Items
{GENERATED_ACTION_ITEMS}

## Next Steps
{RECOMMENDED_NEXT_STEPS}
```

**METRICS CALCULATION:**
- Overall quality score based on weighted criteria
- Trend analysis compared to previous reviews
- Compliance scoring against project standards
- Risk assessment for identified issues

## 6 · Document decisions and action items

**DECISION DOCUMENTATION:**
- Record all review decisions with rationale
- Document any deviations from standards with justification
- Capture consensus on controversial items
- Log any decisions requiring stakeholder approval

**ACTION ITEM GENERATION:**
```yaml
action_items:
  - item: "Fix critical security vulnerability in authentication"
    assignee: "security_team"
    priority: "critical"
    due_date: "2025-01-16"
    tracking_id: "ACTION_001"
    
  - item: "Refactor complex user service methods"
    assignee: "development_team" 
    priority: "high"
    due_date: "2025-01-20"
    tracking_id: "ACTION_002"
```

**INTEGRATION WITH TASK MANAGEMENT:**
- Create tasks for significant action items
- Link review findings to existing tasks or bugs
- Update technical debt registry with identified debt
- Schedule follow-up reviews if needed

## 7 · Update project tracking and create follow-up tasks

**PROJECT UPDATES:**
- Update project manifest with review status
- Log review completion in project history
- Update sprint or milestone progress if applicable
- Record quality metrics for trend analysis

**TASK CREATION:**
For significant issues found, automatically create tasks:
```bash
# Create tasks for critical and high-priority findings
for finding in critical_high_findings; do
  create_task_from_finding "$finding"
done
```

**TECHNICAL DEBT LOGGING:**
Use existing technical debt system to track identified debt:
```bash
/project:simone:log_technical_debt "Complex authentication logic needs refactoring" --persona-analyzer
```

## 8 · Provide review summary and next steps

**REVIEW SUMMARY:**
```markdown
✅ **Review Complete**: {REVIEW_TYPE} review of {REVIEW_SCOPE}

📊 **Quality Assessment**:
- Overall Score: {OVERALL_SCORE}/10
- Critical Issues: {CRITICAL_COUNT}
- Action Items Created: {ACTION_ITEMS_COUNT}

🎯 **Key Findings**:
- {TOP_FINDING_1}
- {TOP_FINDING_2}
- {TOP_FINDING_3}

⏭️ **Next Steps**:
1. Address critical issues immediately
2. Schedule follow-up review in {TIMEFRAME}
3. Track action items to completion
4. Update quality metrics dashboard

🔍 **Review Focus Recommendations**:
{FUTURE_REVIEW_FOCUS_AREAS}
```

**FOLLOW-UP SCHEDULING:**
- Schedule next review based on findings severity
- Set up monitoring for critical issues
- Plan incremental reviews for large improvements
- Coordinate with sprint planning for action items

---

## Review Type Specific Workflows

### Code Review Workflow
1. **Parse** → `--type-code` with security/architecture personas
2. **Load** → Current git changes and architectural context
3. **Execute** → Multi-persona code analysis with OWASP validation
4. **Gather** → Findings categorized by severity and persona
5. **Generate** → Code quality report with metrics
6. **Document** → Decisions and technical debt items
7. **Update** → Project tracking and create refactoring tasks
8. **Provide** → Summary with specific code improvement recommendations

### Quality Review Workflow  
1. **Parse** → `--type-quality` with comprehensive persona set
2. **Load** → Full project context and quality standards
3. **Execute** → Multi-dimensional quality assessment
4. **Gather** → Quality metrics across all dimensions
5. **Generate** → Comprehensive quality dashboard
6. **Document** → Quality trends and improvement opportunities
7. **Update** → Quality metrics tracking and milestone impact
8. **Provide** → Quality roadmap and improvement priorities

### Testing Review Workflow
1. **Parse** → `--type-testing` with QA persona focus
2. **Load** → Test suite and coverage requirements
3. **Execute** → Testing effectiveness and coverage analysis
4. **Gather** → Test gaps and quality issues
5. **Generate** → Testing strategy recommendations
6. **Document** → Testing improvements and automation opportunities
7. **Update** → Testing roadmap and coverage goals
8. **Provide** → Testing action plan and automation recommendations

### Discussion Review Workflow
1. **Parse** → `--type-discussion` with mentor persona
2. **Load** → Review context and stakeholder requirements
3. **Execute** → Facilitated discussion and consensus building
4. **Gather** → Decisions, agreements, and action items
5. **Generate** → Discussion summary and decision documentation
6. **Document** → Architectural decisions and best practices
7. **Update** → Team knowledge base and process improvements
8. **Provide** → Decision summary and implementation guidance

---

## Integration with Automated Workflows

This unified review system integrates seamlessly with:
- **`do_task_auto`**: Automated task execution includes comprehensive review
- **`create_pr_auto`**: PR creation includes automated review results
- **Quality Gate Validator**: Provides input for validation pipeline
- **Technical Debt System**: Automatic debt logging for identified issues

**Benefits of Unified Review System:**
- **Consistency**: Single interface for all review types
- **Efficiency**: Reduced context switching between review tools
- **Comprehensiveness**: Multi-persona analysis for thorough reviews
- **Integration**: Seamless workflow with task and project management
- **Scalability**: Extensible system for new review types and personas