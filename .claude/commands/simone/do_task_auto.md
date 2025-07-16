# Automated Simone Task Execution with Full Validation Pipeline

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement through persona flags.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: System design and architecture expertise
- `--persona-security`: Security analysis and OWASP compliance  
- `--persona-frontend`: Frontend development and UX optimization
- `--persona-backend`: Backend systems and API development
- `--persona-analyzer`: Code analysis and metrics evaluation
- `--persona-mentor`: Guidance and best practices coaching
- `--persona-refactorer`: Code optimization and maintainability
- `--persona-performance`: Performance optimization and scalability
- `--persona-qa`: Quality assurance and testing strategies

**ADVANCED FLAGS:**
- `--introspect`: Show transparent AI reasoning with 🤔 Thinking and 🎯 Decision indicators
- `--uc`: Use UltraCompressed mode for 70% token reduction (auto-triggers for large projects)
- `--consensus`: Multi-model consensus gathering for critical decisions
- `--think-deep`: Extended reasoning for complex problems
- `--bypass-approval`: Skip human approval gates for routine tasks (use with caution)
- `--quality-strict`: Enforce strictest quality standards (recommended for production)

**USAGE EXAMPLES:**
- `/project:simone:do_task_auto T001 --persona-security --quality-strict` (Security-focused automated execution)
- `/project:simone:do_task_auto T001 --persona-architect --persona-performance --bypass-approval` (High-trust automation)
- `/project:simone:do_task_auto T001 --consensus --think-deep` (Comprehensive automated analysis)

**AUTOMATION SCOPE:** This command executes tasks with minimal human intervention until PR review. Only critical security, architectural, or business logic issues will pause for human input.

**IMPORTANT:** Follow from Top to Bottom - don't skip anything!

**CREATE A TODO LIST** with exactly these 12 items

1. Analyse scope and validate automation readiness
2. Identify and validate task file
3. Execute comprehensive task analysis with persona activation
4. Validate dependencies and architectural compliance
5. Create task branch with automated validation
6. Set status to in_progress with automation tracking
7. Execute automated implementation with continuous validation
8. Perform automated technical debt assessment and resolution
9. Execute comprehensive automated code review
10. Auto-resolve routine issues and re-validate
11. Automated commit with comprehensive validation
12. Prepare for automated PR creation with full context

## 1 · Analyse scope and validate automation readiness

<$ARGUMENTS> ⇒ Task ID, Sprint ID, or empty (select next open task in current sprint).

**AUTOMATION READINESS ASSESSMENT:**

### Pre-Flight Validation Checklist
- [ ] **Repository State**: Clean working directory, no uncommitted changes
- [ ] **Dependency Status**: All dependencies up-to-date and secure
- [ ] **CI/CD Pipeline**: All checks passing on main branch
- [ ] **Test Suite Health**: Full test suite passing with adequate coverage
- [ ] **Security Baseline**: No existing high/critical vulnerabilities
- [ ] **Performance Baseline**: Current performance metrics within acceptable ranges

**AUTOMATION CONFIDENCE SCORING:**
Calculate automation confidence based on:
1. **Task Complexity** (1-10): Simple config changes (1) to complex architectural changes (10)
2. **Risk Level** (1-10): Documentation updates (1) to security-critical changes (10)
3. **Test Coverage** (1-10): No tests (1) to comprehensive test coverage (10)
4. **Domain Familiarity** (1-10): New technology (1) to well-established patterns (10)

**Automation Confidence Score = (Test Coverage + Domain Familiarity) - (Task Complexity + Risk Level)**

- **Score ≥ 10**: Full automation with `--bypass-approval`
- **Score 5-9**: Standard automation with quality gates
- **Score 0-4**: Cautious automation with human checkpoints
- **Score < 0**: Manual execution recommended

## 2 · Identify and validate task file

**ENHANCED TASK DISCOVERY:**

Search `.simone/03_SPRINTS/` and `.simone/04_GENERAL_TASKS/` with validation:

1. **Task File Validation:**
   - [ ] Task exists and is readable
   - [ ] Status is "open" or "ready"
   - [ ] Dependencies are resolved
   - [ ] Acceptance criteria are well-defined
   - [ ] Implementation scope is clear

2. **Dependency Chain Analysis:**
   - Use MCP Sequential Thinking to map all dependencies
   - Validate all prerequisite tasks are completed
   - Check for circular dependencies
   - Verify external dependencies are available

If validation fails, pause automation and request human intervention.

## 3 · Execute comprehensive task analysis with persona activation

**AUTOMATED PERSONA ACTIVATION:**

1. **Scan task description** for automatic persona activation:
   ```yaml
   persona_keywords:
     security: [auth, encryption, validation, privacy, OWASP, vulnerability, security]
     architect: [design, scalability, pattern, integration, structure, system]
     frontend: [UI, UX, component, interface, accessibility, user, responsive]
     backend: [API, database, server, microservice, performance, optimization]
     qa: [test, quality, validation, verification, coverage, automation]
     performance: [speed, latency, throughput, optimization, bottleneck, cache]
     analyzer: [metrics, analysis, complexity, debt, refactor, quality]
   ```

2. **Multi-Domain Analysis Approach:**
   - **Primary Persona**: Based on strongest keyword match
   - **Supporting Personas**: Based on secondary matches
   - **Cross-Domain Validation**: Ensure personas don't conflict

3. **MCP Integration Enhancement:**
   - **Sequential Thinking**: Structure multi-persona analysis
   - **Serena**: Enhanced code understanding and context
   - **Context7**: Maintain cross-session knowledge
   - **GitHub**: Learn from similar task patterns

**CRITICAL AUTOMATED VALIDATION:**

Execute parallel validation agents:
1. **Sprint Alignment Validator**: Confirm task belongs to current sprint
2. **Dependency Resolver**: Check and resolve all dependencies automatically
3. **Requirements Mapper**: Map task to specific requirements documentation
4. **Risk Assessor**: Evaluate automation risk factors

**AUTOMATION DECISION POINT:**
- **High Confidence + Low Risk**: Proceed with full automation
- **Medium Confidence**: Enable additional validation checkpoints
- **Low Confidence**: Request human validation before proceeding

## 4 · Validate dependencies and architectural compliance

**COMPREHENSIVE DEPENDENCY VALIDATION:**

### 4.1 · Technical Dependencies
```bash
# Automated dependency check
npm audit --audit-level moderate
npm outdated --depth=0
docker system df  # If using containers
```

**Dependency Health Scoring:**
- **Green**: All dependencies current, no security issues
- **Yellow**: Minor updates available, low-severity security issues
- **Red**: Major updates needed, high-severity security issues

### 4.2 · Architectural Compliance Check

**Automated Architecture Validation:**
1. **Design Pattern Compliance**: Verify adherence to established patterns
2. **Dependency Direction**: Ensure proper layer dependencies
3. **Interface Contracts**: Validate API compatibility
4. **Database Schema**: Check for breaking schema changes
5. **Security Boundaries**: Verify security model compliance

**MCP-Enhanced Analysis:**
- **Serena**: Deep code analysis for architectural violations
- **Sequential Thinking**: Systematic compliance checking
- **Context7**: Cross-reference with architectural decisions

### 4.3 · Performance Impact Assessment

**Automated Performance Baseline:**
```javascript
// Performance impact prediction
const performanceRisks = {
  databaseQueries: assessQueryComplexity(),
  apiEndpoints: assessEndpointChanges(), 
  memoryUsage: assessMemoryImpact(),
  networkCalls: assessNetworkChanges()
};

const riskScore = calculatePerformanceRisk(performanceRisks);
```

**Risk Thresholds:**
- **Low Risk (1-3)**: Minor optimizations, config changes
- **Medium Risk (4-6)**: New features, moderate complexity
- **High Risk (7-10)**: Major refactoring, performance-critical changes

## 5 · Create task branch with automated validation

**ENHANCED BRANCH MANAGEMENT:**

### 5.1 · Pre-Branch Validation
```bash
# Automated git state validation
git status --porcelain  # Must be empty
git fetch origin        # Get latest changes
git diff origin/main    # Check for divergence
```

### 5.2 · Intelligent Branch Naming
```bash
# Enhanced branch naming with automation metadata
TASK_ID="T001"
SPRINT_ID="S02"
AUTOMATION_LEVEL="auto"
TIMESTAMP=$(date +%Y%m%d-%H%M)

BRANCH_NAME="task/${TASK_ID}-${SPRINT_ID}-${AUTOMATION_LEVEL}-${TIMESTAMP}"
```

### 5.3 · Automated Branch Creation with Validation
```bash
# Create branch with enhanced validation
git checkout main
git pull origin main
git checkout -b "${BRANCH_NAME}"

# Validate branch creation
if [ $? -eq 0 ]; then
  echo "✅ Branch created successfully: ${BRANCH_NAME}"
  git push -u origin "${BRANCH_NAME}"
else
  echo "❌ Branch creation failed - requesting human intervention"
  exit 1
fi
```

### 5.4 · Automated Metadata Updates
```yaml
# Auto-update task YAML frontmatter
automation_metadata:
  git_branch: "${BRANCH_NAME}"
  automation_level: "full"
  automation_confidence: "${CONFIDENCE_SCORE}"
  created_by: "claude_auto"
  validation_passed: true
  risk_assessment: "${RISK_LEVEL}"
```

## 6 · Set status to in_progress with automation tracking

**ENHANCED STATUS MANAGEMENT:**

### 6.1 · Comprehensive Metadata Update
```yaml
# Enhanced YAML frontmatter updates
status: "in_progress"
updated_date: "${CURRENT_TIMESTAMP}"
assignee: "Claude-Auto"
automation_session:
  session_id: "${UNIQUE_SESSION_ID}"
  started_at: "${CURRENT_TIMESTAMP}"
  automation_level: "full"
  personas_active: ["${ACTIVE_PERSONAS}"]
  confidence_score: "${CONFIDENCE_SCORE}"
  estimated_duration: "${AUTO_ESTIMATED_DURATION}"
tracking:
  actual_effort: "0"
  automation_checkpoints: []
  validation_results: []
  quality_gates_passed: []
```

### 6.2 · Multi-Location Status Updates
1. **Task File**: Update YAML frontmatter and status header
2. **Project Manifest**: Update task progress and sprint status
3. **Automation Log**: Create detailed automation tracking entry
4. **MCP GitHub**: Log automation session start

### 6.3 · Automated Progress Tracking Setup
```yaml
# Initialize automated progress tracking
progress_tracking:
  subtasks_total: "${SUBTASK_COUNT}"
  subtasks_completed: 0
  completion_percentage: 0
  current_phase: "implementation"
  automated_checkpoints:
    - name: "Initial setup"
      status: "completed"
      timestamp: "${CURRENT_TIMESTAMP}"
```

## 7 · Execute automated implementation with continuous validation

**COMPREHENSIVE AUTOMATED IMPLEMENTATION:**

### 7.1 · Persona-Driven Implementation Strategy

**Multi-Persona Coordination:**
```yaml
implementation_strategy:
  primary_persona: "${PRIMARY_PERSONA}"
  supporting_personas: ["${SUPPORTING_PERSONAS}"]
  coordination_approach: "sequential_validation"
  quality_gates: "continuous"
```

**🏗️ Architecture Persona Implementation:**
- **System Design Validation**: Check design patterns before implementation
- **Scalability Assessment**: Evaluate performance impact at each step
- **Integration Validation**: Verify service boundaries and contracts
- **Technical Debt Prevention**: Identify and prevent architectural debt

**🔒 Security Persona Implementation:**
- **Threat Modeling**: Automated threat assessment for each change
- **OWASP Compliance**: Real-time security validation
- **Input Validation**: Automated sanitization and validation implementation
- **Access Control**: Verify authentication and authorization patterns

**🎨 Frontend Persona Implementation:**
- **Accessibility Validation**: Automated WCAG compliance checking
- **Performance Monitoring**: Bundle size and load time tracking
- **Component Standards**: Enforce component design patterns
- **User Experience**: Validate UX consistency and usability

**⚙️ Backend Persona Implementation:**
- **API Design**: Validate RESTful principles and error handling
- **Database Optimization**: Automated query performance analysis
- **Scalability Testing**: Load testing for new endpoints
- **Error Handling**: Comprehensive error scenario coverage

### 7.2 · Continuous Implementation Validation

**Real-Time Quality Monitoring:**
```javascript
// Automated quality gates during implementation
const qualityGates = {
  codeQuality: {
    linting: () => runLinter(),
    complexity: () => checkComplexity(),
    duplicates: () => detectDuplication()
  },
  security: {
    vulnerabilities: () => runSecurityScan(),
    dependencies: () => auditDependencies(),
    secrets: () => scanForSecrets()
  },
  performance: {
    benchmarks: () => runPerformanceTests(),
    memory: () => checkMemoryUsage(),
    queries: () => analyzeQueries()
  },
  testing: {
    coverage: () => checkTestCoverage(),
    quality: () => validateTestQuality(),
    integration: () => runIntegrationTests()
  }
};
```

### 7.3 · Automated Implementation Loop

**Implementation Workflow:**
```markdown
For each subtask:
1. **Pre-Implementation Validation**
   - [ ] Requirements clear and testable
   - [ ] Dependencies resolved
   - [ ] Design approach validated
   
2. **Implementation with Continuous Monitoring**
   - [ ] Write/modify code following persona guidelines
   - [ ] Run automated tests continuously
   - [ ] Monitor performance impact in real-time
   - [ ] Validate security implications immediately
   
3. **Post-Implementation Validation**
   - [ ] All tests passing
   - [ ] Code quality gates passed
   - [ ] Security scan clean
   - [ ] Performance within acceptable bounds
   - [ ] Documentation updated automatically

4. **Automated Metadata Updates**
   - [ ] Mark subtask complete with timestamp
   - [ ] Update effort tracking
   - [ ] Log implementation decisions
   - [ ] Update progress percentage
   - [ ] Record quality metrics
```

### 7.4 · MCP-Enhanced Implementation

**Advanced MCP Integration:**
- **Sequential Thinking**: Structure complex implementation steps
- **Serena**: Enhanced code analysis and suggestions during development
- **GitHub**: Learn from previous implementations and avoid past issues
- **Context7**: Maintain implementation context across sessions

### 7.5 · Automated Issue Resolution

**Self-Healing Implementation:**
```yaml
automated_resolution:
  linting_issues:
    action: "auto_fix"
    tools: ["eslint --fix", "prettier --write"]
    confidence: "high"
  
  test_failures:
    action: "analyze_and_fix"
    max_attempts: 3
    escalation: "human_review"
  
  security_issues:
    action: "immediate_halt"
    notification: "security_team"
    escalation: "mandatory_human_review"
  
  performance_regressions:
    action: "analyze_and_optimize"
    threshold: "10%_degradation"
    rollback: "automatic_if_critical"
```

## 8 · Perform automated technical debt assessment and resolution

**COMPREHENSIVE DEBT AUTOMATION:**

### 8.1 · Automated Debt Discovery

**Enhanced Debt Detection:**
```yaml
debt_detection_algorithms:
  code_quality:
    - duplicate_code_analysis
    - complexity_threshold_detection
    - naming_convention_violations
    - missing_error_handling
    - anti_pattern_recognition
  
  architecture:
    - design_pattern_violations
    - tight_coupling_detection
    - missing_abstraction_identification
    - scalability_concern_analysis
  
  security:
    - vulnerability_pattern_scanning
    - authentication_gap_analysis
    - authorization_flaw_detection
    - data_exposure_assessment
  
  performance:
    - algorithm_efficiency_analysis
    - database_optimization_opportunities
    - resource_leak_detection
    - caching_opportunity_identification
  
  documentation:
    - missing_documentation_detection
    - outdated_documentation_identification
    - code_comment_analysis
```

### 8.2 · Automated Debt Categorization and Scoring

**AI-Powered Debt Assessment:**
```javascript
// Automated debt severity calculation
function calculateDebtSeverity(debtItem) {
  const factors = {
    businessImpact: assessBusinessImpact(debtItem),
    technicalRisk: assessTechnicalRisk(debtItem),
    maintenanceCost: assessMaintenanceCost(debtItem),
    implementationEffort: assessImplementationEffort(debtItem)
  };
  
  const riskScore = (factors.businessImpact * factors.technicalRisk) / 
                   (factors.maintenanceCost * factors.implementationEffort);
  
  return {
    severity: categorizeSeverity(riskScore),
    priority: calculatePriority(factors),
    estimatedEffort: factors.implementationEffort,
    recommendedTimeline: calculateTimeline(factors)
  };
}
```

### 8.3 · Automated Debt Resolution

**Smart Debt Resolution:**
```yaml
automated_debt_resolution:
  auto_fixable:
    - code_formatting_issues
    - simple_naming_violations
    - missing_type_annotations
    - basic_security_patterns
    - simple_performance_optimizations
  
  semi_automated:
    - complex_refactoring_opportunities
    - architecture_improvement_suggestions
    - advanced_security_implementations
    - performance_optimization_strategies
  
  human_required:
    - business_logic_decisions
    - major_architectural_changes
    - breaking_api_modifications
    - complex_security_implementations
```

### 8.4 · Debt Tracking Integration

**Enhanced Debt Management:**
```yaml
# Automated debt item creation
debt_item_template:
  id: "TD_${AUTO_GENERATED_ID}"
  created_date: "${TIMESTAMP}"
  discovered_by: "claude_auto"
  source_task: "${TASK_ID}"
  category: "${DEBT_CATEGORY}"
  severity: "${CALCULATED_SEVERITY}"
  estimated_effort: "${EFFORT_HOURS}"
  business_impact: "${IMPACT_SCORE}"
  technical_risk: "${RISK_SCORE}"
  auto_resolution_attempted: "${BOOLEAN}"
  resolution_success: "${BOOLEAN}"
  escalation_required: "${BOOLEAN}"
```

## 9 · Execute comprehensive automated code review

**MULTI-LAYERED AUTOMATED REVIEW:**

### 9.1 · Automated Review Orchestration

**Parallel Review Execution:**
```yaml
automated_review_pipeline:
  static_analysis:
    - code_quality_analysis
    - security_vulnerability_scanning
    - performance_impact_assessment
    - architecture_compliance_check
  
  dynamic_analysis:
    - automated_test_execution
    - integration_test_validation
    - performance_benchmark_comparison
    - security_penetration_testing
  
  documentation_review:
    - api_documentation_validation
    - code_comment_analysis
    - readme_update_verification
    - changelog_generation
```

### 9.2 · Persona-Driven Automated Review

**Enhanced Persona Integration:**
```yaml
persona_review_automation:
  security_persona:
    tools: ["semgrep", "snyk", "bandit", "safety"]
    thresholds:
      critical_vulnerabilities: 0
      high_vulnerabilities: 0
      medium_vulnerabilities: 2
    auto_remediation: true
  
  performance_persona:
    tools: ["lighthouse", "webpack-bundle-analyzer", "clinic.js"]
    thresholds:
      bundle_size_increase: "5%"
      performance_regression: "10%"
      memory_usage_increase: "15%"
    auto_optimization: true
  
  architecture_persona:
    tools: ["dependency-cruiser", "madge", "complexity-report"]
    thresholds:
      circular_dependencies: 0
      coupling_score: 7
      complexity_score: 10
    auto_refactoring: "safe_only"
```

### 9.3 · Automated Issue Resolution

**Self-Healing Review Process:**
```javascript
// Automated review issue resolution
async function resolveReviewIssues(reviewResults) {
  const resolutionStrategies = {
    linting: autoFixLinting,
    formatting: autoFixFormatting,
    simpleRefactoring: autoRefactor,
    testCoverage: generateMissingTests,
    documentation: generateDocumentation,
    performance: autoOptimize
  };
  
  for (const issue of reviewResults.issues) {
    if (issue.autoFixable && issue.confidence > 0.8) {
      await resolutionStrategies[issue.type](issue);
      await revalidateChanges(issue.affectedFiles);
    } else {
      await escalateToHuman(issue);
    }
  }
}
```

### 9.4 · Review Results Integration

**Comprehensive Review Documentation:**
```yaml
automated_review_results:
  overall_status: "PASS/FAIL/CONDITIONAL"
  automation_confidence: "${CONFIDENCE_SCORE}"
  issues_found: "${ISSUE_COUNT}"
  issues_auto_resolved: "${RESOLVED_COUNT}"
  issues_requiring_human_review: "${ESCALATION_COUNT}"
  
  quality_metrics:
    code_quality_score: "${SCORE}"
    security_score: "${SCORE}"
    performance_score: "${SCORE}"
    test_coverage: "${PERCENTAGE}"
    documentation_score: "${SCORE}"
  
  persona_assessments:
    security_assessment: "${DETAILED_RESULTS}"
    architecture_assessment: "${DETAILED_RESULTS}"
    performance_assessment: "${DETAILED_RESULTS}"
    qa_assessment: "${DETAILED_RESULTS}"
```

## 10 · Auto-resolve routine issues and re-validate

**INTELLIGENT ISSUE RESOLUTION:**

### 10.1 · Resolution Confidence Scoring

**Smart Resolution Decision Making:**
```javascript
function calculateResolutionConfidence(issue) {
  const factors = {
    issueType: getIssueTypeConfidence(issue.type),
    codebasePattern: analyzeCodebasePatterns(issue),
    previousResolutions: queryHistoricalResolutions(issue),
    testCoverage: getTestCoverage(issue.affectedFiles),
    impactScope: assessImpactScope(issue)
  };
  
  return weightedConfidenceScore(factors);
}
```

**Confidence Thresholds:**
- **High Confidence (>0.9)**: Auto-resolve without validation
- **Medium Confidence (0.7-0.9)**: Auto-resolve with immediate re-validation
- **Low Confidence (<0.7)**: Flag for human review

### 10.2 · Automated Resolution Strategies

**Resolution Pattern Library:**
```yaml
resolution_patterns:
  formatting_issues:
    confidence: 0.95
    tools: ["prettier", "eslint --fix"]
    validation: "syntax_check"
    rollback: "automatic"
  
  missing_imports:
    confidence: 0.9
    tools: ["auto-import", "organize-imports"]
    validation: "compilation_test"
    rollback: "automatic"
  
  simple_type_errors:
    confidence: 0.85
    tools: ["typescript_auto_fix"]
    validation: "type_check"
    rollback: "automatic"
  
  basic_security_patterns:
    confidence: 0.8
    tools: ["security_auto_fix"]
    validation: "security_test"
    rollback: "automatic"
  
  performance_optimizations:
    confidence: 0.75
    tools: ["performance_optimizer"]
    validation: "benchmark_test"
    rollback: "performance_regression"
```

### 10.3 · Iterative Resolution and Validation

**Resolution Validation Loop:**
```markdown
For each auto-resolvable issue:
1. **Apply Resolution**
   - Execute appropriate resolution strategy
   - Log resolution attempt with details
   - Capture before/after state

2. **Immediate Validation**
   - Run relevant tests
   - Check code compilation
   - Verify functionality
   - Validate performance impact

3. **Resolution Assessment**
   - Compare expected vs actual results
   - Update confidence models
   - Log success/failure metrics

4. **Rollback Decision**
   - If validation fails: automatic rollback
   - If partial success: flag for human review
   - If full success: proceed to next issue

5. **Learning Integration**
   - Update resolution patterns
   - Improve confidence models
   - Store successful strategies
```

### 10.4 · Post-Resolution Validation

**Comprehensive Re-validation:**
```bash
# Automated post-resolution validation suite
npm run lint                    # Code quality
npm run typecheck              # Type safety
npm test -- --coverage        # Test suite
npm run security:scan         # Security validation
npm run performance:test      # Performance benchmarks
npm run integration:test      # Integration validation
```

## 11 · Automated commit with comprehensive validation

**ENHANCED COMMIT AUTOMATION:**

### 11.1 · Pre-Commit Comprehensive Validation

**Multi-Layer Validation Pipeline:**
```yaml
pre_commit_validation:
  code_quality:
    - linting_check: "zero_errors"
    - formatting_check: "auto_fix_applied"
    - complexity_check: "within_thresholds"
    - duplication_check: "acceptable_levels"
  
  security:
    - vulnerability_scan: "no_new_issues"
    - secret_detection: "no_secrets_found"
    - dependency_audit: "no_high_severity"
    - access_control_check: "patterns_verified"
  
  performance:
    - benchmark_validation: "no_regression"
    - memory_usage_check: "within_limits"
    - bundle_size_check: "acceptable_increase"
    - query_performance: "optimized"
  
  testing:
    - unit_tests: "all_passing"
    - integration_tests: "all_passing"
    - coverage_threshold: "maintained_or_improved"
    - test_quality: "adequate"
  
  documentation:
    - api_docs_updated: "if_applicable"
    - readme_updated: "if_applicable"
    - changelog_updated: "automatic"
    - code_comments: "adequate"
```

### 11.2 · Intelligent Commit Message Generation

**AI-Powered Commit Messages:**
```javascript
function generateCommitMessage(changes) {
  const analysis = {
    changeType: analyzeChangeType(changes),
    scope: determineScope(changes),
    impact: assessImpact(changes),
    taskReference: extractTaskReference(),
    breakingChanges: identifyBreakingChanges(changes)
  };
  
  return formatConventionalCommit({
    type: analysis.changeType,
    scope: analysis.scope,
    description: generateDescription(analysis),
    body: generateBody(analysis),
    footer: generateFooter(analysis)
  });
}
```

**Commit Message Template:**
```
<type>(<scope>): <description>

<body>

AUTOMATED: Task ${TASK_ID} - ${TASK_TITLE}
Quality Gates: ✅ All passed
Security Scan: ✅ Clean
Performance: ✅ No regression
Test Coverage: ${COVERAGE_PERCENTAGE}%

Auto-resolved issues: ${RESOLVED_ISSUES_COUNT}
Technical debt: ${DEBT_ITEMS_LOGGED}

🤖 Generated with Claude Code Automation v2.0

Co-Authored-By: Claude <noreply@anthropic.com>
```

### 11.3 · Automated Commit Execution

**Secure Commit Process:**
```bash
# Automated commit with validation
git add .
git status --porcelain

# Final validation before commit
if validate_all_checks_passed; then
  git commit -m "$(generate_commit_message)"
  
  # Verify commit success
  if [ $? -eq 0 ]; then
    COMMIT_SHA=$(git rev-parse HEAD)
    update_task_metadata_with_commit "${COMMIT_SHA}"
    log_automation_success "commit" "${COMMIT_SHA}"
  else
    log_automation_failure "commit" "git_commit_failed"
    escalate_to_human "commit_failure"
  fi
else
  log_automation_failure "pre_commit_validation" "checks_failed"
  escalate_to_human "validation_failure"
fi
```

### 11.4 · Post-Commit Validation and Metadata Update

**Comprehensive Post-Commit Updates:**
```yaml
# Task metadata updates
commit_metadata:
  commit_sha: "${COMMIT_SHA}"
  commit_timestamp: "${TIMESTAMP}"
  automation_level: "full"
  validation_results:
    pre_commit_checks: "all_passed"
    post_commit_verification: "successful"
  quality_metrics:
    test_coverage: "${COVERAGE}"
    security_score: "${SECURITY_SCORE}"
    performance_score: "${PERFORMANCE_SCORE}"
    code_quality_score: "${QUALITY_SCORE}"
  automation_statistics:
    issues_auto_resolved: "${RESOLVED_COUNT}"
    total_automation_time: "${DURATION}"
    manual_interventions: "${INTERVENTION_COUNT}"
```

## 12 · Prepare for automated PR creation with full context

**COMPREHENSIVE PR PREPARATION:**

### 12.1 · Automated PR Context Generation

**AI-Generated PR Description:**
```markdown
## 🤖 Automated Task Completion: ${TASK_ID}

### 📋 Task Summary
**Title**: ${TASK_TITLE}
**Sprint**: ${SPRINT_ID}
**Estimated Effort**: ${ESTIMATED_EFFORT}h
**Actual Effort**: ${ACTUAL_EFFORT}h
**Efficiency**: ${EFFICIENCY_PERCENTAGE}%

### 🎯 Implementation Summary
${AUTO_GENERATED_IMPLEMENTATION_SUMMARY}

### ✅ Acceptance Criteria Validation
${ACCEPTANCE_CRITERIA_CHECKLIST}

### 🔍 Quality Assurance Results

#### Code Quality Metrics
- **Test Coverage**: ${COVERAGE_PERCENTAGE}% (${COVERAGE_CHANGE})
- **Code Complexity**: ${COMPLEXITY_SCORE}/10 (Target: <10)
- **Technical Debt**: ${DEBT_ITEMS_COUNT} items (${DEBT_AUTO_RESOLVED} auto-resolved)
- **Linting Issues**: 0 (${LINTING_ISSUES_RESOLVED} auto-resolved)

#### Security Assessment
- **Vulnerability Scan**: ✅ Clean (${SECURITY_SCORE})
- **Dependency Audit**: ✅ No high-severity issues
- **Secret Detection**: ✅ No secrets found
- **OWASP Compliance**: ✅ All checks passed

#### Performance Validation
- **Performance Score**: ${PERFORMANCE_SCORE}/100
- **Bundle Size**: ${BUNDLE_SIZE} (${BUNDLE_CHANGE})
- **API Response Time**: ${API_RESPONSE_TIME}ms (${RESPONSE_TIME_CHANGE})
- **Memory Usage**: ${MEMORY_USAGE} (${MEMORY_CHANGE})

#### Automated Testing Results
- **Unit Tests**: ${UNIT_TESTS_PASSED}/${UNIT_TESTS_TOTAL} ✅
- **Integration Tests**: ${INTEGRATION_TESTS_PASSED}/${INTEGRATION_TESTS_TOTAL} ✅
- **E2E Tests**: ${E2E_TESTS_PASSED}/${E2E_TESTS_TOTAL} ✅

### 🧹 Technical Debt Management
${TECHNICAL_DEBT_SUMMARY}

### 🤖 Automation Statistics
- **Automation Confidence**: ${AUTOMATION_CONFIDENCE_SCORE}/10
- **Issues Auto-Resolved**: ${AUTO_RESOLVED_ISSUES}
- **Manual Interventions**: ${MANUAL_INTERVENTIONS}
- **Total Automation Time**: ${AUTOMATION_DURATION}

### 🔄 Changes Made
${DETAILED_CHANGE_SUMMARY}

### 📚 Documentation Updates
${DOCUMENTATION_UPDATES}

### 🎭 Persona Analysis Applied
${PERSONA_ANALYSIS_SUMMARY}

### ⚠️ Risk Assessment
${RISK_ASSESSMENT_SUMMARY}

### 🔍 Review Focus Areas
${REVIEW_FOCUS_RECOMMENDATIONS}

---
**Automation Level**: Full
**Ready for Human Review**: ✅
**Merge Recommendation**: ${MERGE_RECOMMENDATION}
```

### 12.2 · Automated Reviewer Assignment

**Intelligent Reviewer Selection:**
```javascript
function assignReviewers(changes, taskContext) {
  const requiredReviewers = {
    security: changes.securitySensitive ? getSecurityExperts() : [],
    architecture: changes.architecturalChanges ? getArchitects() : [],
    domain: getDomainExperts(taskContext.domain),
    qa: changes.testingChanges ? getQAExperts() : []
  };
  
  return {
    required: combineRequired(requiredReviewers),
    suggested: getSuggestedReviewers(changes),
    codeOwners: getCodeOwners(changes.files)
  };
}
```

### 12.3 · Automated Label and Metadata Assignment

**Smart Labeling System:**
```yaml
automated_labels:
  change_type:
    - "${CHANGE_TYPE}"  # feat, fix, refactor, docs, test
  domain:
    - "${DOMAIN_LABELS}"  # backend, frontend, security, performance
  automation:
    - "automated-task"
    - "ready-for-review"
    - "quality-validated"
  risk_level:
    - "${RISK_LEVEL}"  # low-risk, medium-risk, high-risk
  personas_applied:
    - "${PERSONA_LABELS}"  # security-reviewed, performance-optimized
```

### 12.4 · Pre-PR Final Validation

**Final Automated Checks:**
```yaml
pre_pr_validation:
  branch_status:
    - commits_ahead_of_main: "${COMMITS_AHEAD}"
    - conflicts_with_main: false
    - ci_status: "passing"
  
  quality_gates:
    - all_tests_passing: true
    - coverage_maintained: true
    - security_clean: true
    - performance_acceptable: true
    - documentation_updated: true
  
  automation_completeness:
    - task_fully_implemented: true
    - acceptance_criteria_met: true
    - technical_debt_assessed: true
    - code_review_passed: true
```

### 12.5 · Human Handoff Preparation

**Seamless Human Transition:**
```markdown
## 🚀 Ready for Human Review

### Key Decisions Made
${KEY_AUTOMATION_DECISIONS}

### Areas Requiring Human Judgment
${HUMAN_JUDGMENT_AREAS}

### Next Steps
1. **PR Review**: Focus on business logic and architectural decisions
2. **Manual Testing**: Verify user experience and edge cases
3. **Stakeholder Approval**: Confirm business requirements met
4. **Merge Decision**: Evaluate timing and deployment considerations

### Automation Confidence
This task was completed with ${AUTOMATION_CONFIDENCE_SCORE}/10 confidence.
All technical quality gates have been validated automatically.
Human review should focus on business logic and strategic decisions.
```

---

## Automation Success Criteria

### Full Automation Success (Score ≥ 9/10)
- ✅ All acceptance criteria automatically validated
- ✅ Zero critical or high-severity issues
- ✅ All tests passing with maintained/improved coverage
- ✅ Security scan clean
- ✅ Performance within acceptable bounds
- ✅ Documentation automatically updated
- ✅ Technical debt properly assessed and managed
- ✅ Code review passed with minimal human intervention required

### Partial Automation Success (Score 6-8/10)
- ✅ Most acceptance criteria met with minor human validation needed
- ⚠️ Low-severity issues identified and flagged for review
- ✅ Core functionality tested and validated
- ✅ Security and performance within acceptable ranges
- ⚠️ Documentation may need minor human review
- ✅ Technical debt properly tracked

### Automation Handoff Required (Score <6/10)
- ⚠️ Complex issues requiring human judgment identified
- ⚠️ Business logic decisions needed
- ⚠️ Architectural changes requiring stakeholder input
- 🔄 Escalate to manual `/project:simone:do_task` workflow

---

**Benefits of Automated Task Execution:**
- 🚀 **Speed**: 70-90% reduction in task completion time
- 🎯 **Consistency**: Standardized quality and validation processes
- 🔍 **Thoroughness**: Comprehensive validation impossible to miss manually
- 📊 **Metrics**: Detailed automation and quality metrics
- 🤖 **Learning**: Continuous improvement through automation feedback
- 🧠 **Focus**: Human reviewers can focus on strategic decisions rather than routine validation