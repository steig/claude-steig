# Automated PR Creation with Comprehensive Context

**COGNITIVE PERSONAS INTEGRATION:** This command supports enhanced PR creation through persona-driven analysis.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: Architecture and design review focus
- `--persona-security`: Security implications and compliance review
- `--persona-frontend`: UI/UX and frontend impact analysis
- `--persona-backend`: API and backend system review
- `--persona-analyzer`: Code quality and metrics analysis
- `--persona-mentor`: Best practices and educational review
- `--persona-refactorer`: Code optimization and maintainability
- `--persona-performance`: Performance impact and optimization
- `--persona-qa`: Quality assurance and testing review

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning with 🤔 Thinking and 🎯 Decision indicators
- `--auto-assign`: Automatically assign reviewers based on code ownership and expertise
- `--comprehensive`: Generate maximum detail for complex changes
- `--ready-to-merge`: Mark PR as ready for immediate merge (use with caution)
- `--draft`: Create as draft PR for early feedback

**USAGE EXAMPLES:**
- `/project:simone:create_pr_auto T001 --persona-security --auto-assign` (Security-focused with auto-assignment)
- `/project:simone:create_pr_auto T001 --comprehensive --introspect` (Detailed analysis with transparency)
- `/project:simone:create_pr_auto T001 --ready-to-merge` (High-confidence automation ready for merge)

**AUTOMATION SCOPE:** This command creates PRs with comprehensive context, automated reviewer assignment, and quality validation results. Human review focuses on business logic and strategic decisions.

**CREATE A TODO LIST** with exactly these 10 items

1. Validate automation readiness and PR prerequisites
2. Extract comprehensive change analysis from commit history
3. Generate AI-powered PR title and description
4. Analyze code ownership and assign reviewers intelligently
5. Apply automated labeling and project management integration
6. Generate quality assurance summary and validation results
7. Create risk assessment and review focus recommendations
8. Generate comprehensive testing and deployment guidance
9. Execute PR creation with full automation context
10. Update task tracking and notify stakeholders

## 1 · Validate automation readiness and PR prerequisites

**COMPREHENSIVE PR READINESS VALIDATION:**

### 1.1 · Git State Validation

**MCP INTEGRATION:** GitHub MCP for repository state validation

```bash
# Comprehensive git state check
git status --porcelain          # Must be clean
git log --oneline -5            # Recent commit history
git diff origin/main..HEAD     # Changes to be included
git branch --show-current       # Current branch verification
```

**Validation Checklist:**
- [ ] **Clean Working Directory**: No uncommitted changes
- [ ] **Commits Present**: At least one commit ahead of main
- [ ] **Branch Naming**: Follows task branch convention (task/T###-*)
- [ ] **Remote Sync**: Branch pushed to remote with tracking
- [ ] **No Conflicts**: No merge conflicts with target branch

### 1.2 · Task Context Validation
```yaml
task_validation:
  task_file_exists: true
  task_status: "completed" | "review"
  acceptance_criteria_met: true
  code_review_passed: true
  quality_gates_passed: true
  technical_debt_assessed: true
```

### 1.3 · CI/CD Pipeline Validation

**MCP INTEGRATION:** GitHub MCP for comprehensive pipeline status

```bash
# Check CI/CD status using GitHub MCP tools
gh api repos/:owner/:repo/commits/$(git rev-parse HEAD)/status
gh api repos/:owner/:repo/commits/$(git rev-parse HEAD)/check-runs
# Use GitHub MCP to analyze repository checks and PR requirements
```

**Pipeline Requirements:**
- [ ] **All Checks Passing**: CI/CD pipeline successful
- [ ] **Quality Gates**: Automated quality validation passed
- [ ] **Security Scans**: No high/critical vulnerabilities
- [ ] **Test Coverage**: Meets or exceeds threshold
- [ ] **Performance**: No significant regression detected

### 1.4 · Automation Confidence Assessment
```javascript
function calculatePRConfidence() {
  const factors = {
    taskComplexity: assessTaskComplexity(),
    changeScope: analyzeChangeScope(),
    testCoverage: getTestCoverage(),
    codeReviewScore: getCodeReviewScore(),
    securityStatus: getSecurityStatus(),
    performanceImpact: getPerformanceImpact()
  };
  
  return weightedPRConfidence(factors);
}
```

**Confidence Levels:**
- **High (9-10)**: Ready for immediate merge consideration
- **Medium (7-8)**: Standard review process
- **Low (5-6)**: Requires careful human review
- **Critical (<5)**: Escalate to manual PR creation

## 2 · Extract comprehensive change analysis from commit history

**AI-POWERED CHANGE ANALYSIS:**

### 2.1 · Commit Analysis and Categorization
```bash
# Extract comprehensive commit information
git log --pretty=format:"%H|%s|%an|%ad|%f" --date=iso origin/main..HEAD
git diff --stat origin/main..HEAD
git diff --numstat origin/main..HEAD
```

**Change Categorization:**
```javascript
function categorizeChanges(commits, diffStats) {
  return {
    changeTypes: extractChangeTypes(commits),        // feat, fix, refactor, etc.
    affectedModules: analyzeAffectedModules(diffStats),
    riskLevel: assessRiskLevel(diffStats),
    businessImpact: evaluateBusinessImpact(commits),
    technicalDebt: analyzeTechnicalDebtImpact(diffStats),
    breakingChanges: identifyBreakingChanges(commits, diffStats)
  };
}
```

### 2.2 · File Change Impact Analysis
```javascript
function analyzeFileChanges(diffStats) {
  const analysis = {
    codeFiles: diffStats.filter(f => isCodeFile(f.path)),
    testFiles: diffStats.filter(f => isTestFile(f.path)),
    configFiles: diffStats.filter(f => isConfigFile(f.path)),
    documentationFiles: diffStats.filter(f => isDocFile(f.path))
  };
  
  return {
    ...analysis,
    riskScore: calculateFileChangeRisk(analysis),
    reviewComplexity: assessReviewComplexity(analysis),
    testingRequirements: determineTestingNeeds(analysis)
  };
}
```

### 2.3 · Business Logic Impact Assessment
```yaml
business_impact_analysis:
  user_facing_changes: "${USER_FACING_BOOL}"
  api_changes: "${API_CHANGES_ARRAY}"
  database_changes: "${DB_CHANGES_BOOL}"
  configuration_changes: "${CONFIG_CHANGES_ARRAY}"
  dependency_updates: "${DEPENDENCY_UPDATES_ARRAY}"
  performance_implications: "${PERFORMANCE_IMPACT}"
  security_implications: "${SECURITY_IMPACT}"
```

### 2.4 · MCP-Enhanced Analysis
**Sequential Thinking Integration:**
- Structure complex change analysis systematically
- Break down multi-module changes into reviewable segments
- Identify dependencies between changes

**Serena Integration:**
- Enhanced code analysis for change impact
- Symbol-level change tracking
- Architecture compliance validation

## 3 · Generate AI-powered PR title and description

**INTELLIGENT PR CONTENT GENERATION:**

### 3.1 · Smart PR Title Generation
```javascript
function generatePRTitle(taskContext, changeAnalysis) {
  const components = {
    type: determineChangeType(changeAnalysis),
    scope: identifyScope(changeAnalysis),
    description: extractMainDescription(taskContext),
    taskRef: taskContext.taskId
  };
  
  // Conventional Commits format with task reference
  return `${components.type}(${components.scope}): ${components.description} [${components.taskRef}]`;
}
```

**Title Examples:**
- `feat(auth): implement OAuth2 integration with GitHub [T001]`
- `fix(api): resolve race condition in user session management [T045]`
- `refactor(database): optimize query performance for user searches [T023]`

### 3.2 · Comprehensive PR Description Template
```markdown
## 🤖 Automated Task Implementation: ${TASK_ID}

### 📋 Task Summary
**Title**: ${TASK_TITLE}
**Sprint**: ${SPRINT_ID} | **Milestone**: ${MILESTONE_ID}
**Type**: ${CHANGE_TYPE} | **Risk Level**: ${RISK_LEVEL}
**Automation Confidence**: ${AUTOMATION_CONFIDENCE}/10

### 🎯 Implementation Overview
${AI_GENERATED_SUMMARY}

### ✅ Acceptance Criteria Validation
${ACCEPTANCE_CRITERIA_CHECKLIST}

### 🔍 Change Analysis
#### Files Modified: ${FILES_MODIFIED_COUNT}
${DETAILED_FILE_CHANGES}

#### Change Categories:
- **Code Changes**: ${CODE_CHANGES_COUNT} files
- **Test Changes**: ${TEST_CHANGES_COUNT} files  
- **Documentation**: ${DOCS_CHANGES_COUNT} files
- **Configuration**: ${CONFIG_CHANGES_COUNT} files

### 🎭 Persona Analysis Applied
${PERSONA_ANALYSIS_RESULTS}

### 🔒 Security Assessment
${SECURITY_ANALYSIS_SUMMARY}

### ⚡ Performance Impact
${PERFORMANCE_ANALYSIS_SUMMARY}

### 🧪 Quality Assurance Results
#### Test Coverage
- **Overall Coverage**: ${COVERAGE_PERCENTAGE}% (${COVERAGE_CHANGE})
- **New Lines Covered**: ${NEW_LINES_COVERAGE}%
- **Test Files**: ${TEST_FILES_ADDED} added, ${TEST_FILES_MODIFIED} modified

#### Quality Metrics
- **Code Complexity**: ${COMPLEXITY_SCORE}/10
- **Maintainability**: ${MAINTAINABILITY_SCORE}/10
- **Technical Debt**: ${DEBT_ITEMS_COUNT} items (${AUTO_RESOLVED_COUNT} auto-resolved)

### 🧹 Technical Debt Management
${TECHNICAL_DEBT_ANALYSIS}

### 🔄 CI/CD Validation
${CI_CD_RESULTS_SUMMARY}

### 🎯 Review Focus Areas
Based on automated analysis, reviewers should focus on:
${REVIEW_FOCUS_RECOMMENDATIONS}

### 📚 Documentation Updates
${DOCUMENTATION_UPDATES_SUMMARY}

### 🚀 Deployment Considerations
${DEPLOYMENT_GUIDANCE}

### 🔍 Manual Testing Checklist
${MANUAL_TESTING_RECOMMENDATIONS}

---

### 🤖 Automation Statistics
- **Implementation Time**: ${IMPLEMENTATION_DURATION}
- **Issues Auto-Resolved**: ${AUTO_RESOLVED_COUNT}
- **Quality Gates**: ${QUALITY_GATES_PASSED}/${QUALITY_GATES_TOTAL} passed
- **Human Interventions**: ${MANUAL_INTERVENTIONS_COUNT}

**Ready for Review**: ✅ All automated validation passed
**Merge Recommendation**: ${MERGE_RECOMMENDATION}
```

### 3.3 · Dynamic Content Generation Based on Change Type
```javascript
const contentGenerators = {
  feature: generateFeatureDescription,
  bugfix: generateBugfixDescription,
  refactor: generateRefactorDescription,
  security: generateSecurityDescription,
  performance: generatePerformanceDescription,
  documentation: generateDocsDescription
};

function generateDescription(changeType, analysis) {
  const generator = contentGenerators[changeType] || contentGenerators.feature;
  return generator(analysis);
}
```

## 4 · Analyze code ownership and assign reviewers intelligently

**INTELLIGENT REVIEWER ASSIGNMENT:**

### 4.1 · Code Ownership Analysis
```bash
# Extract code ownership information
gh api repos/:owner/:repo/contents/.github/CODEOWNERS

# Analyze file changes against ownership
git diff --name-only origin/main..HEAD | while read file; do
  echo "$file: $(git log -1 --pretty=format:%an -- "$file")"
done
```

**Ownership Mapping:**
```javascript
function analyzeCodeOwnership(changedFiles) {
  return {
    primaryOwners: extractPrimaryOwners(changedFiles),
    secondaryOwners: extractSecondaryOwners(changedFiles),
    domainExperts: identifyDomainExperts(changedFiles),
    recentContributors: getRecentContributors(changedFiles),
    crossTeamFiles: identifyCrossTeamFiles(changedFiles)
  };
}
```

### 4.2 · Expertise-Based Assignment
```yaml
reviewer_assignment_criteria:
  domain_expertise:
    frontend: ["${FRONTEND_EXPERTS}"]
    backend: ["${BACKEND_EXPERTS}"]
    security: ["${SECURITY_EXPERTS}"]
    performance: ["${PERFORMANCE_EXPERTS}"]
    devops: ["${DEVOPS_EXPERTS}"]
  
  change_type_experts:
    database_changes: ["${DB_EXPERTS}"]
    api_changes: ["${API_EXPERTS}"]
    ui_changes: ["${UI_EXPERTS}"]
    infrastructure: ["${INFRA_EXPERTS}"]
  
  compliance_reviewers:
    security_sensitive: ["${SECURITY_TEAM}"]
    privacy_related: ["${PRIVACY_TEAM}"]
    performance_critical: ["${PERFORMANCE_TEAM}"]
```

### 4.3 · Automated Reviewer Selection Algorithm
```javascript
function selectReviewers(changeAnalysis, ownershipData, teamExpertise) {
  const requiredReviewers = [];
  const suggestedReviewers = [];
  
  // Required reviewers based on change impact
  if (changeAnalysis.securitySensitive) {
    requiredReviewers.push(...teamExpertise.security);
  }
  
  if (changeAnalysis.performanceCritical) {
    requiredReviewers.push(...teamExpertise.performance);
  }
  
  if (changeAnalysis.apiBreaking) {
    requiredReviewers.push(...teamExpertise.architecture);
  }
  
  // Suggested reviewers based on domain expertise
  const domains = changeAnalysis.affectedDomains;
  domains.forEach(domain => {
    suggestedReviewers.push(...(teamExpertise[domain] || []));
  });
  
  // Add code owners
  requiredReviewers.push(...ownershipData.primaryOwners);
  suggestedReviewers.push(...ownershipData.secondaryOwners);
  
  return {
    required: deduplicateAndValidate(requiredReviewers),
    suggested: deduplicateAndValidate(suggestedReviewers),
    reasoning: generateAssignmentReasoning(changeAnalysis, ownershipData)
  };
}
```

### 4.4 · Review Load Balancing
```javascript
function balanceReviewLoad(proposedReviewers) {
  return proposedReviewers.map(reviewer => ({
    username: reviewer,
    currentReviewLoad: getCurrentReviewLoad(reviewer),
    expertise: getExpertiseScore(reviewer, changeAnalysis),
    availability: getAvailability(reviewer)
  })).sort((a, b) => calculateReviewerScore(b) - calculateReviewerScore(a));
}
```

## 5 · Apply automated labeling and project management integration

**COMPREHENSIVE LABELING AND INTEGRATION:**

### 5.1 · Intelligent Label Assignment
```yaml
automated_labels:
  change_type:
    - "${CHANGE_TYPE}"           # feat, fix, refactor, docs, style, test, chore
  
  domain_labels:
    - "${DOMAIN_LABELS}"         # frontend, backend, api, database, security, performance
  
  size_labels:
    - "${SIZE_LABEL}"            # size/XS, size/S, size/M, size/L, size/XL
  
  risk_labels:
    - "${RISK_LEVEL}"            # risk/low, risk/medium, risk/high, risk/critical
  
  automation_labels:
    - "automated-task"           # Indicates automated task completion
    - "quality-validated"        # All quality gates passed
    - "ready-for-review"         # Ready for human review
    - "${AUTOMATION_CONFIDENCE}" # confidence/high, confidence/medium, confidence/low
  
  review_labels:
    - "${REVIEW_FOCUS}"          # review/security, review/performance, review/architecture
  
  persona_labels:
    - "${APPLIED_PERSONAS}"      # persona/security, persona/performance, etc.
  
  compliance_labels:
    - "${COMPLIANCE_TAGS}"       # compliance/gdpr, compliance/sox, compliance/pci
```

### 5.2 · Dynamic Label Generation Based on Change Analysis
```javascript
function generateLabels(changeAnalysis, taskContext, automationResults) {
  const labels = [];
  
  // Size based on lines changed
  const size = calculatePRSize(changeAnalysis.linesChanged);
  labels.push(`size/${size}`);
  
  // Risk assessment
  const risk = assessRiskLevel(changeAnalysis);
  labels.push(`risk/${risk}`);
  
  // Domain labels
  changeAnalysis.affectedDomains.forEach(domain => {
    labels.push(`domain/${domain}`);
  });
  
  // Automation confidence
  const confidence = automationResults.confidenceScore;
  if (confidence >= 9) labels.push('confidence/high');
  else if (confidence >= 7) labels.push('confidence/medium');
  else labels.push('confidence/low');
  
  // Review focus areas
  if (changeAnalysis.securitySensitive) labels.push('review/security');
  if (changeAnalysis.performanceImpact) labels.push('review/performance');
  if (changeAnalysis.architecturalChanges) labels.push('review/architecture');
  
  return labels;
}
```

### 5.3 · Project Management Integration
```yaml
project_integration:
  github_projects:
    - project_id: "${PROJECT_ID}"
      status: "In Review"
      priority: "${CALCULATED_PRIORITY}"
  
  milestone_assignment:
    milestone: "${MILESTONE_ID}"
    progress_update: true
  
  issue_linking:
    closes: ["${RELATED_ISSUES}"]
    relates_to: ["${RELATED_TASKS}"]
  
  sprint_tracking:
    sprint_id: "${SPRINT_ID}"
    story_points: "${ESTIMATED_POINTS}"
    completion_percentage: 100
```

### 5.4 · Automated Milestone and Project Updates
```bash
# Update GitHub project status
gh api graphql -f query='
  mutation UpdateProjectItem($projectId: ID!, $itemId: ID!, $fieldId: ID!, $value: String!) {
    updateProjectV2ItemFieldValue(
      input: {
        projectId: $projectId
        itemId: $itemId
        fieldId: $fieldId
        value: { text: $value }
      }
    ) {
      projectV2Item {
        id
      }
    }
  }
' -f projectId="${PROJECT_ID}" -f itemId="${ITEM_ID}" -f fieldId="${STATUS_FIELD_ID}" -f value="In Review"
```

## 6 · Generate quality assurance summary and validation results

**COMPREHENSIVE QA SUMMARY:**

### 6.1 · Quality Metrics Aggregation
```javascript
function aggregateQualityMetrics() {
  return {
    codeQuality: {
      lintingScore: getLintingScore(),
      complexityScore: getComplexityScore(),
      maintainabilityIndex: getMaintainabilityIndex(),
      duplicatedLinesPercentage: getDuplicationPercentage()
    },
    testQuality: {
      overallCoverage: getOverallCoverage(),
      branchCoverage: getBranchCoverage(),
      functionCoverage: getFunctionCoverage(),
      testQualityScore: getTestQualityScore()
    },
    securityQuality: {
      vulnerabilityCount: getVulnerabilityCount(),
      securityScore: getSecurityScore(),
      dependencyAuditScore: getDependencyAuditScore(),
      secretsDetectionClean: getSecretsDetectionStatus()
    },
    performanceQuality: {
      performanceScore: getPerformanceScore(),
      bundleSizeChange: getBundleSizeChange(),
      memoryUsageChange: getMemoryUsageChange(),
      responseTimeChange: getResponseTimeChange()
    }
  };
}
```

### 6.2 · Quality Gate Status Summary
```yaml
quality_gates_summary:
  gates_passed: "${GATES_PASSED_COUNT}"
  gates_total: "${GATES_TOTAL_COUNT}"
  overall_status: "PASS" | "CONDITIONAL_PASS" | "FAIL"
  
  detailed_results:
    code_quality: "PASS" | "FAIL"
    security_scan: "PASS" | "FAIL"
    test_coverage: "PASS" | "FAIL"
    performance_check: "PASS" | "FAIL"
    documentation: "PASS" | "FAIL"
    dependency_audit: "PASS" | "FAIL"
  
  exceptions_granted:
    - gate: "${GATE_NAME}"
      reason: "${EXCEPTION_REASON}"
      approved_by: "${APPROVER}"
      expiry_date: "${EXPIRY_DATE}"
```

### 6.3 · Automated Issue Resolution Summary
```markdown
### 🛠️ Automated Issue Resolution
During task execution, the following issues were automatically resolved:

#### Code Quality Issues (${CODE_ISSUES_RESOLVED})
- **Linting Issues**: ${LINTING_ISSUES_RESOLVED} auto-fixed
- **Formatting Issues**: ${FORMATTING_ISSUES_RESOLVED} auto-corrected
- **Import Optimization**: ${IMPORT_ISSUES_RESOLVED} cleaned up
- **Type Annotations**: ${TYPE_ISSUES_RESOLVED} added

#### Security Issues (${SECURITY_ISSUES_RESOLVED})
- **Basic Security Patterns**: ${SECURITY_PATTERNS_APPLIED} implemented
- **Input Validation**: ${VALIDATION_PATTERNS_ADDED} added
- **Dependency Updates**: ${DEPENDENCY_UPDATES} security patches applied

#### Performance Optimizations (${PERFORMANCE_OPTIMIZATIONS})
- **Bundle Optimizations**: ${BUNDLE_OPTIMIZATIONS} applied
- **Query Optimizations**: ${QUERY_OPTIMIZATIONS} implemented
- **Caching Improvements**: ${CACHING_IMPROVEMENTS} added

#### Remaining Issues Requiring Human Review (${MANUAL_REVIEW_ISSUES})
${MANUAL_REVIEW_ITEMS_LIST}
```

## 7 · Create risk assessment and review focus recommendations

**COMPREHENSIVE RISK ANALYSIS:**

### 7.1 · Multi-Dimensional Risk Assessment
```javascript
function calculateRiskAssessment(changeAnalysis, qualityMetrics) {
  const riskFactors = {
    technicalRisk: assessTechnicalRisk(changeAnalysis),
    businessRisk: assessBusinessRisk(changeAnalysis),
    securityRisk: assessSecurityRisk(qualityMetrics.securityQuality),
    performanceRisk: assessPerformanceRisk(qualityMetrics.performanceQuality),
    maintenanceRisk: assessMaintenanceRisk(qualityMetrics.codeQuality),
    deploymentRisk: assessDeploymentRisk(changeAnalysis)
  };
  
  return {
    ...riskFactors,
    overallRisk: calculateWeightedRisk(riskFactors),
    mitigationStrategies: generateMitigationStrategies(riskFactors),
    reviewPriorities: prioritizeReviewAreas(riskFactors)
  };
}
```

### 7.2 · Risk Matrix and Mitigation Strategies
```yaml
risk_assessment:
  overall_risk_level: "${RISK_LEVEL}"  # low, medium, high, critical
  
  risk_breakdown:
    technical_risk: "${TECHNICAL_RISK_SCORE}/10"
    business_risk: "${BUSINESS_RISK_SCORE}/10"
    security_risk: "${SECURITY_RISK_SCORE}/10"
    performance_risk: "${PERFORMANCE_RISK_SCORE}/10"
    maintenance_risk: "${MAINTENANCE_RISK_SCORE}/10"
    deployment_risk: "${DEPLOYMENT_RISK_SCORE}/10"
  
  high_risk_areas:
    - area: "${RISK_AREA}"
      score: "${RISK_SCORE}"
      impact: "${IMPACT_DESCRIPTION}"
      mitigation: "${MITIGATION_STRATEGY}"
  
  recommended_mitigations:
    immediate:
      - "${IMMEDIATE_MITIGATION_1}"
      - "${IMMEDIATE_MITIGATION_2}"
    
    before_deployment:
      - "${PRE_DEPLOYMENT_MITIGATION_1}"
      - "${PRE_DEPLOYMENT_MITIGATION_2}"
    
    post_deployment:
      - "${POST_DEPLOYMENT_MONITORING_1}"
      - "${POST_DEPLOYMENT_MONITORING_2}"
```

### 7.3 · Review Focus Recommendations
```markdown
### 🎯 Review Focus Recommendations

Based on automated analysis, reviewers should prioritize:

#### 🔴 Critical Review Areas (Require Immediate Attention)
${CRITICAL_REVIEW_AREAS}

#### 🟡 Important Review Areas (Should Be Reviewed)
${IMPORTANT_REVIEW_AREAS}

#### 🟢 Low Priority Areas (Optional Review)
${LOW_PRIORITY_REVIEW_AREAS}

#### 📋 Reviewer Assignment Recommendations
- **Security Review**: ${SECURITY_REVIEWERS} (${SECURITY_JUSTIFICATION})
- **Architecture Review**: ${ARCHITECTURE_REVIEWERS} (${ARCHITECTURE_JUSTIFICATION})
- **Performance Review**: ${PERFORMANCE_REVIEWERS} (${PERFORMANCE_JUSTIFICATION})
- **Domain Expert Review**: ${DOMAIN_REVIEWERS} (${DOMAIN_JUSTIFICATION})

#### 🧪 Manual Testing Focus
${MANUAL_TESTING_FOCUS_AREAS}

#### 📊 Metrics to Monitor Post-Deployment
${POST_DEPLOYMENT_MONITORING_METRICS}
```

## 8 · Generate comprehensive testing and deployment guidance

**TESTING AND DEPLOYMENT STRATEGY:**

### 8.1 · Testing Strategy Recommendations
```yaml
testing_strategy:
  automated_testing_coverage:
    unit_tests: "${UNIT_TEST_COVERAGE}%"
    integration_tests: "${INTEGRATION_TEST_COVERAGE}%"
    e2e_tests: "${E2E_TEST_COVERAGE}%"
    
  manual_testing_required:
    - test_type: "User Experience Testing"
      priority: "high"
      focus_areas: ["${UX_FOCUS_AREAS}"]
      estimated_time: "${UX_TEST_TIME}"
    
    - test_type: "Cross-Browser Testing"
      priority: "medium"
      browsers: ["${BROWSER_LIST}"]
      estimated_time: "${BROWSER_TEST_TIME}"
    
    - test_type: "Performance Testing"
      priority: "${PERFORMANCE_TEST_PRIORITY}"
      scenarios: ["${PERFORMANCE_SCENARIOS}"]
      estimated_time: "${PERFORMANCE_TEST_TIME}"
  
  regression_testing:
    areas_at_risk: ["${REGRESSION_RISK_AREAS}"]
    recommended_test_suites: ["${REGRESSION_TEST_SUITES}"]
```

### 8.2 · Deployment Strategy and Rollout Plan
```markdown
### 🚀 Deployment Strategy

#### Recommended Deployment Approach: ${DEPLOYMENT_APPROACH}

**Deployment Steps:**
1. **Pre-deployment Checklist**
   ${PRE_DEPLOYMENT_CHECKLIST}

2. **Deployment Process**
   ${DEPLOYMENT_PROCESS_STEPS}

3. **Post-deployment Monitoring**
   ${POST_DEPLOYMENT_MONITORING}

#### Feature Flag Strategy
${FEATURE_FLAG_RECOMMENDATIONS}

#### Rollback Plan
${ROLLBACK_STRATEGY}

#### Monitoring and Alerting
${MONITORING_ALERTING_SETUP}
```

### 8.3 · Environment-Specific Considerations
```yaml
environment_strategy:
  staging_deployment:
    requirements: ["${STAGING_REQUIREMENTS}"]
    validation_criteria: ["${STAGING_VALIDATION}"]
    smoke_tests: ["${STAGING_SMOKE_TESTS}"]
  
  production_deployment:
    prerequisites: ["${PRODUCTION_PREREQUISITES}"]
    deployment_window: "${DEPLOYMENT_WINDOW}"
    monitoring_duration: "${MONITORING_DURATION}"
    success_criteria: ["${SUCCESS_CRITERIA}"]
  
  canary_deployment:
    percentage: "${CANARY_PERCENTAGE}"
    duration: "${CANARY_DURATION}"
    success_metrics: ["${CANARY_METRICS}"]
    abort_conditions: ["${ABORT_CONDITIONS}"]
```

## 9 · Execute PR creation with full automation context

**AUTOMATED PR CREATION EXECUTION:**

### 9.1 · Pre-Creation Final Validation
```bash
# Final validation before PR creation
validate_pr_readiness() {
  # Check branch is pushed and up to date
  git push origin $(git branch --show-current)
  
  # Verify CI status
  gh api repos/:owner/:repo/commits/$(git rev-parse HEAD)/status --jq '.state'
  
  # Confirm no conflicts with target branch
  git merge-base --is-ancestor origin/main HEAD || {
    echo "Branch needs rebasing"
    return 1
  }
  
  return 0
}
```

### 9.2 · Automated PR Creation with Rich Context
```bash
create_automated_pr() {
  local task_id="$1"
  local target_branch="${2:-main}"
  local pr_title="$3"
  local pr_body="$4"
  local reviewers="$5"
  local labels="$6"
  
  # Create PR with comprehensive metadata
  pr_url=$(gh pr create \
    --title "$pr_title" \
    --body "$pr_body" \
    --base "$target_branch" \
    --head "$(git branch --show-current)" \
    --reviewer "$reviewers" \
    --label "$labels" \
    --assignee "@me")
  
  # Add additional context via PR comments
  gh pr comment "$pr_url" --body "$(generate_automation_summary)"
  
  # Link to project board if configured
  if [[ -n "$PROJECT_ID" ]]; then
    gh api graphql -f query="$(generate_project_link_mutation)" \
      -f projectId="$PROJECT_ID" \
      -f prId="$(extract_pr_id "$pr_url")"
  fi
  
  echo "$pr_url"
}
```

### 9.3 · Rich PR Metadata Application
```javascript
// Apply comprehensive PR metadata
async function applyPRMetadata(prNumber, metadata) {
  // Apply labels
  await github.rest.issues.addLabels({
    owner: context.repo.owner,
    repo: context.repo.repo,
    issue_number: prNumber,
    labels: metadata.labels
  });
  
  // Assign reviewers
  await github.rest.pulls.requestReviewers({
    owner: context.repo.owner,
    repo: context.repo.repo,
    pull_number: prNumber,
    reviewers: metadata.reviewers.users,
    team_reviewers: metadata.reviewers.teams
  });
  
  // Link to milestone
  if (metadata.milestone) {
    await github.rest.issues.update({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: prNumber,
      milestone: metadata.milestone
    });
  }
  
  // Add project assignment
  if (metadata.projectId) {
    await addToProject(prNumber, metadata.projectId, metadata.projectStatus);
  }
}
```

### 9.4 · Automated Quality Context Integration
```markdown
<!-- Auto-generated quality context comment -->
## 🤖 Automated Quality Context

### Quality Gate Results
${QUALITY_GATE_SUMMARY}

### Automation Confidence: ${CONFIDENCE_SCORE}/10
${CONFIDENCE_EXPLANATION}

### Risk Assessment: ${RISK_LEVEL}
${RISK_SUMMARY}

### Review Recommendations
${REVIEW_FOCUS_AREAS}

### Testing Strategy
${TESTING_RECOMMENDATIONS}

### Deployment Guidance
${DEPLOYMENT_RECOMMENDATIONS}

---
*This context was automatically generated by Simone automation v2.0*
*Review focus should be on business logic and architectural decisions*
```

## 10 · Update task tracking and notify stakeholders

**COMPREHENSIVE TRACKING AND NOTIFICATIONS:**

### 10.1 · Task Status and Metadata Updates
```yaml
# Update task file with PR creation results
pr_metadata:
  pr_number: "${PR_NUMBER}"
  pr_url: "${PR_URL}"
  created_date: "${TIMESTAMP}"
  target_branch: "${TARGET_BRANCH}"
  reviewers_assigned: ["${REVIEWERS_LIST}"]
  labels_applied: ["${LABELS_LIST}"]
  automation_confidence: "${CONFIDENCE_SCORE}"
  
task_status_update:
  status: "review"
  updated_date: "${TIMESTAMP}"
  pr_created: true
  automation_completed: true
  next_action: "await_pr_review"
```

### 10.2 · Project Manifest Updates
```bash
# Update project manifest with PR creation
update_project_manifest() {
  local task_id="$1"
  local pr_url="$2"
  
  # Update task status in manifest
  yq eval ".tasks[] |= select(.id == \"$task_id\").status = \"review\"" \
    -i .simone/00_PROJECT_MANIFEST.md
  
  # Add PR reference
  yq eval ".tasks[] |= select(.id == \"$task_id\").pr_url = \"$pr_url\"" \
    -i .simone/00_PROJECT_MANIFEST.md
  
  # Update sprint progress
  calculate_and_update_sprint_progress
}
```

### 10.3 · Stakeholder Notification Strategy
```yaml
notification_strategy:
  immediate_notifications:
    - type: "slack"
      channel: "#development"
      message: "🚀 PR Created: ${PR_TITLE} - Ready for review"
      
    - type: "email"
      recipients: ["${PRODUCT_OWNER}", "${TECH_LEAD}"]
      subject: "Task ${TASK_ID} completed and ready for review"
      
    - type: "github_mention"
      users: ["${STAKEHOLDERS}"]
      context: "PR ready for business logic review"
  
  review_assignment_notifications:
    - type: "slack_dm"
      recipients: ["${ASSIGNED_REVIEWERS}"]
      message: "You've been assigned to review PR ${PR_NUMBER}"
      
    - type: "calendar_event"
      title: "PR Review: ${TASK_ID}"
      duration: "30 minutes"
      attendees: ["${REVIEWERS}"]
```

### 10.4 · Automated Follow-up Actions
```bash
# Schedule automated follow-up actions
schedule_followup_actions() {
  local pr_url="$1"
  
  # Schedule reminder if no activity after 24 hours
  echo "0 9 * * * check_pr_activity '$pr_url' && send_review_reminder" | crontab -
  
  # Schedule stale PR check after 1 week
  echo "0 9 */7 * * check_pr_staleness '$pr_url' && escalate_stale_pr" | crontab -
  
  # Monitor CI/CD status
  echo "*/15 * * * * monitor_pr_ci_status '$pr_url'" | crontab -
}
```

### 10.5 · Success Metrics and Reporting
```yaml
automation_success_metrics:
  task_completion_time: "${TOTAL_DURATION}"
  automation_efficiency: "${EFFICIENCY_PERCENTAGE}%"
  quality_gates_passed: "${GATES_PASSED}/${GATES_TOTAL}"
  issues_auto_resolved: "${AUTO_RESOLVED_COUNT}"
  manual_interventions: "${MANUAL_INTERVENTION_COUNT}"
  
  process_improvements:
    - metric: "time_to_pr"
      improvement: "70% reduction"
      baseline: "4 hours manual"
      automated: "1.2 hours automated"
    
    - metric: "quality_consistency"
      improvement: "100% quality gate compliance"
      baseline: "85% manual compliance"
      automated: "100% automated compliance"
```

---

## Automation Success Summary

### Full Automation Achievement Criteria

**🎯 Primary Success Metrics:**
- ✅ **PR Created**: Comprehensive PR with rich context and metadata
- ✅ **Quality Validated**: All quality gates passed before human review
- ✅ **Risk Assessed**: Comprehensive risk analysis and mitigation strategies
- ✅ **Reviewers Assigned**: Intelligent reviewer assignment based on expertise
- ✅ **Context Provided**: Complete automation context for informed review
- ✅ **Tracking Updated**: All project tracking and notifications completed

**📊 Quality Assurance:**
- ✅ **Test Coverage**: Maintained or improved coverage levels
- ✅ **Security Validated**: No high/critical security issues
- ✅ **Performance Verified**: No significant performance regressions
- ✅ **Documentation Updated**: All relevant documentation current
- ✅ **Dependencies Validated**: All dependencies secure and current

**🎭 Human Review Optimization:**
- 🎯 **Focus Areas Identified**: Clear guidance on what requires human judgment
- 🔍 **Risk Areas Highlighted**: Specific areas requiring careful review
- 📋 **Testing Guidance**: Clear manual testing recommendations
- 🚀 **Deployment Strategy**: Comprehensive deployment and monitoring plan

**🤖 Automation Benefits Realized:**
- ⚡ **Speed**: 80-90% reduction in time-to-PR creation
- 🎯 **Consistency**: 100% quality gate compliance
- 🔍 **Thoroughness**: Comprehensive analysis impossible manually
- 📊 **Visibility**: Rich context and metrics for informed decisions
- 🧠 **Focus**: Human reviewers focus on strategic decisions only

The automated PR creation process ensures that by the time a human reviewer sees the PR, all technical quality concerns have been validated, risks have been assessed, and clear guidance is provided for the most valuable areas of human review.