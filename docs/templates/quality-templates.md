# Quality Templates

**Last Updated**: 2025-07-10  
**Version**: 2.1.0  
**Framework**: Simone Framework

## Overview

Quality templates in the Simone Framework ensure consistent, high-quality software delivery through structured approaches to testing, code review, quality assurance, and continuous improvement. These templates embed quality practices throughout the development lifecycle.

## Quality Template Categories

### Code Quality Templates

#### 1. Code Review Template

**Template**: `code-review.yml`  
**Purpose**: Structured code review process

```yaml
metadata:
  template: "code-review"
  version: "2.0"
  
code_review:
  pull_request: "#1234"
  author: "@developer"
  reviewers:
    - "@senior-dev"
    - "@tech-lead"
  
  checklist:
    functionality:
      - item: "Code fulfills the requirements"
        status: "✓"
        notes: "All acceptance criteria met"
        
      - item: "Edge cases handled appropriately"
        status: "✓"
        notes: "Null checks and error handling in place"
        
      - item: "No unintended side effects"
        status: "✓"
        notes: "Isolated changes, no global state mutations"
        
    code_quality:
      - item: "Follows coding standards"
        status: "✓"
        notes: "Linting passes, style guide followed"
        
      - item: "Clear variable and function names"
        status: "⚠"
        notes: "Some functions could be more descriptive"
        
      - item: "No code duplication"
        status: "✓"
        notes: "Common logic extracted to utilities"
        
    performance:
      - item: "No obvious performance issues"
        status: "✓"
        notes: "Efficient algorithms used"
        
      - item: "Database queries optimized"
        status: "⚠"
        notes: "Consider adding index on user_id"
        
      - item: "Caching implemented where appropriate"
        status: "✓"
        notes: "Redis caching for expensive operations"
        
    security:
      - item: "No security vulnerabilities"
        status: "✓"
        notes: "Input validation, SQL injection prevention"
        
      - item: "Sensitive data properly handled"
        status: "✓"
        notes: "PII encrypted, no logging of passwords"
        
      - item: "Authentication/authorization correct"
        status: "✓"
        notes: "Proper permission checks in place"
        
    testing:
      - item: "Adequate test coverage"
        status: "✓"
        notes: "85% coverage, critical paths tested"
        
      - item: "Tests are meaningful"
        status: "✓"
        notes: "Tests verify behavior, not implementation"
        
      - item: "All tests passing"
        status: "✓"
        notes: "CI build green"
        
  feedback:
    critical:
      - line: 45
        file: "src/api/users.js"
        comment: "SQL injection vulnerability - use parameterized queries"
        
    improvements:
      - line: 123
        file: "src/services/auth.js"
        comment: "Consider extracting this to a separate function"
        
    positive:
      - line: 78
        file: "src/utils/validation.js"
        comment: "Great error handling pattern here!"
        
  metrics:
    lines_changed: 450
    files_modified: 12
    review_time: "45 minutes"
    iterations: 2
    
  decision: "approved_with_comments"
  merge_requirements:
    - "Address SQL injection issue"
    - "Add database index"
    - "Update function names as discussed"
```

#### 2. Quality Gate Template

**Template**: `quality-gate.yml`  
**Purpose**: Define and track quality gates

```yaml
metadata:
  template: "quality-gate"
  version: "2.0"
  
quality_gate:
  name: "Production Release Gate"
  stage: "pre-production"
  
  automated_checks:
    unit_tests:
      required_pass_rate: 100%
      current_pass_rate: 100%
      status: "passed"
      
    integration_tests:
      required_pass_rate: 95%
      current_pass_rate: 97%
      status: "passed"
      
    code_coverage:
      required_threshold: 80%
      current_coverage: 83%
      status: "passed"
      details:
        - statements: 85%
        - branches: 78%
        - functions: 88%
        - lines: 83%
        
    static_analysis:
      critical_issues_allowed: 0
      current_critical: 0
      high_issues_allowed: 0
      current_high: 0
      medium_issues_allowed: 5
      current_medium: 3
      status: "passed"
      
    security_scan:
      vulnerabilities_allowed: 0
      current_vulnerabilities: 0
      status: "passed"
      scan_tool: "OWASP Dependency Check"
      
    performance_benchmark:
      response_time_threshold: "< 200ms"
      current_p95: "156ms"
      throughput_threshold: "> 1000 rps"
      current_throughput: "1250 rps"
      status: "passed"
      
  manual_checks:
    ui_ux_review:
      reviewer: "@design-lead"
      status: "approved"
      comments: "All designs implemented correctly"
      
    accessibility_audit:
      reviewer: "@accessibility-expert"
      status: "approved"
      compliance: "WCAG 2.1 Level AA"
      
    documentation_review:
      reviewer: "@tech-writer"
      status: "approved"
      completeness: "API docs, user guide updated"
      
    security_review:
      reviewer: "@security-team"
      status: "approved"
      penetration_test: "passed"
      
  stakeholder_approvals:
    product_owner:
      name: "@product-manager"
      status: "approved"
      date: "2025-01-10"
      
    engineering_lead:
      name: "@tech-lead"
      status: "approved"
      date: "2025-01-10"
      
    qa_lead:
      name: "@qa-manager"
      status: "approved"
      date: "2025-01-11"
      
  gate_decision:
    status: "passed"
    ready_for_production: true
    approval_date: "2025-01-11"
    approved_by: "@release-manager"
```

### Testing Templates

#### 3. Test Plan Template

**Template**: `test-plan.yml`  
**Purpose**: Comprehensive test planning

```yaml
metadata:
  template: "test-plan"
  version: "2.0"
  
test_plan:
  project: "User Authentication System"
  version: "2.0"
  test_lead: "@qa-lead"
  
  objectives:
    - Verify all authentication flows work correctly
    - Ensure security requirements are met
    - Validate performance under load
    - Confirm compatibility across platforms
    
  scope:
    in_scope:
      - Login/logout functionality
      - Password reset flow
      - Multi-factor authentication
      - Session management
      - API authentication
      
    out_of_scope:
      - Third-party OAuth providers
      - Biometric authentication
      - Legacy system integration
      
  test_strategy:
    levels:
      unit_testing:
        coverage_target: 90%
        responsibility: "Developers"
        tools: ["Jest", "Mocha"]
        
      integration_testing:
        coverage_target: 80%
        responsibility: "QA Team"
        tools: ["Postman", "REST Client"]
        
      system_testing:
        coverage_target: 100%
        responsibility: "QA Team"
        tools: ["Selenium", "Cypress"]
        
      performance_testing:
        load_target: "5000 concurrent users"
        responsibility: "Performance Team"
        tools: ["JMeter", "Gatling"]
        
      security_testing:
        scope: "OWASP Top 10"
        responsibility: "Security Team"
        tools: ["OWASP ZAP", "Burp Suite"]
        
  test_scenarios:
    functional:
      - id: "TC-001"
        title: "Successful user login"
        priority: "critical"
        steps:
          - Enter valid username
          - Enter valid password
          - Click login button
        expected: "User redirected to dashboard"
        
      - id: "TC-002"
        title: "Invalid credentials"
        priority: "high"
        steps:
          - Enter invalid username/password
          - Click login button
        expected: "Error message displayed"
        
    security:
      - id: "SEC-001"
        title: "SQL injection prevention"
        priority: "critical"
        test_data: ["' OR '1'='1", "admin'--"]
        expected: "Input sanitized, login fails"
        
      - id: "SEC-002"
        title: "Brute force protection"
        priority: "critical"
        scenario: "5 failed login attempts"
        expected: "Account temporarily locked"
        
    performance:
      - id: "PERF-001"
        title: "Login response time"
        priority: "high"
        load: "1000 concurrent users"
        expected: "< 2 second response time"
        
  test_data:
    requirements:
      - Valid user accounts
      - Invalid credentials
      - Expired accounts
      - Locked accounts
      
    generation: "Automated via fixtures"
    cleanup: "After each test run"
    
  schedule:
    start_date: "2025-01-15"
    end_date: "2025-02-15"
    milestones:
      - "Week 1: Unit and integration tests"
      - "Week 2: System testing"
      - "Week 3: Performance testing"
      - "Week 4: Security testing"
      
  resources:
    team:
      - name: "@qa-engineer-1"
        role: "Functional testing"
        allocation: "100%"
        
      - name: "@qa-engineer-2"
        role: "Automation"
        allocation: "100%"
        
    environments:
      - name: "QA Environment"
        purpose: "Functional testing"
        
      - name: "Performance Environment"
        purpose: "Load testing"
        
  risks:
    - description: "Test environment instability"
      mitigation: "Dedicated environment setup"
      
    - description: "Test data dependencies"
      mitigation: "Automated data generation"
```

#### 4. Test Case Template

**Template**: `test-case.yml`  
**Purpose**: Detailed test case documentation

```yaml
metadata:
  template: "test-case"
  version: "2.0"
  
test_case:
  id: "TC-AUTH-001"
  title: "Verify successful login with valid credentials"
  
  test_info:
    category: "Functional"
    component: "Authentication"
    priority: "Critical"
    estimated_time: "5 minutes"
    
  prerequisites:
    - Active user account exists
    - User is not locked
    - System is accessible
    
  test_data:
    username: "testuser@example.com"
    password: "SecurePass123!"
    
  steps:
    - step: 1
      action: "Navigate to login page"
      expected: "Login form is displayed"
      
    - step: 2
      action: "Enter username: {{username}}"
      expected: "Username field populated"
      
    - step: 3
      action: "Enter password: {{password}}"
      expected: "Password field populated (masked)"
      
    - step: 4
      action: "Click 'Login' button"
      expected: "Loading indicator appears"
      
    - step: 5
      action: "Wait for response"
      expected: |
        - User redirected to dashboard
        - Welcome message displayed
        - Session cookie set
        
  validation:
    - User profile loads correctly
    - Navigation menu shows user name
    - Logout option available
    
  negative_scenarios:
    - scenario: "Empty username"
      expected: "Validation error: Username required"
      
    - scenario: "Empty password"
      expected: "Validation error: Password required"
      
    - scenario: "Invalid format email"
      expected: "Validation error: Invalid email format"
      
  automation:
    automated: true
    script: "tests/e2e/auth/login.spec.js"
    last_run: "2025-01-10"
    status: "passed"
    
  notes: |
    - Password policy requires minimum 8 characters
    - Account locks after 5 failed attempts
    - Session timeout is 30 minutes
```

### Quality Metrics Templates

#### 5. Quality Metrics Dashboard Template

**Template**: `quality-metrics.yml`  
**Purpose**: Track quality metrics and trends

```yaml
metadata:
  template: "quality-metrics"
  version: "2.0"
  
quality_metrics:
  period: "2025-01"
  team: "Platform Team"
  
  code_quality:
    coverage:
      overall: 82%
      trend: "+3%"
      target: 80%
      breakdown:
        unit_tests: 88%
        integration_tests: 75%
        e2e_tests: 65%
        
    static_analysis:
      issues:
        critical: 0
        high: 2
        medium: 15
        low: 47
      technical_debt: "42 days"
      code_smells: 89
      
    complexity:
      cyclomatic_complexity:
        average: 4.2
        threshold: 10
        violations: 3
        
      cognitive_complexity:
        average: 6.1
        threshold: 15
        violations: 1
        
  defect_metrics:
    discovered:
      development: 45
      qa: 23
      production: 3
      
    severity_distribution:
      critical: 2
      high: 15
      medium: 38
      low: 16
      
    resolution_time:
      critical: "4 hours"
      high: "2 days"
      medium: "5 days"
      low: "2 weeks"
      
    escape_rate: 3.9%  # Defects found in production
    
  testing_metrics:
    test_execution:
      total_tests: 2456
      passed: 2398
      failed: 12
      skipped: 46
      pass_rate: 97.6%
      
    automation:
      automated_tests: 1847
      manual_tests: 609
      automation_rate: 75.2%
      
    coverage_by_type:
      api_tests: 92%
      ui_tests: 78%
      integration_tests: 85%
      
  performance_metrics:
    response_times:
      p50: "45ms"
      p95: "156ms"
      p99: "289ms"
      
    throughput:
      average: "1250 rps"
      peak: "2100 rps"
      
    error_rates:
      4xx_errors: 0.8%
      5xx_errors: 0.1%
      
  continuous_improvement:
    process_adherence:
      code_review_compliance: 98%
      test_before_merge: 95%
      documentation_updates: 87%
      
    cycle_time:
      feature_development: "8 days"
      bug_fix: "2 days"
      hotfix: "4 hours"
      
    deployment_frequency: "3 per day"
    lead_time: "2 days"
    mttr: "35 minutes"
    change_failure_rate: 2.1%
```

#### 6. Defect Report Template

**Template**: `defect-report.yml`  
**Purpose**: Comprehensive defect tracking

```yaml
metadata:
  template: "defect-report"
  version: "2.0"
  
defect:
  id: "BUG-2025-0142"
  title: "User session expires prematurely"
  reporter: "@qa-tester"
  reported_date: "2025-01-10T14:30:00Z"
  
  classification:
    severity: "High"
    priority: "P1"
    type: "Functional"
    component: "Authentication"
    
  description: |
    User sessions are expiring after 10 minutes of activity,
    despite the configured timeout being 30 minutes.
    
  environment:
    browser: "Chrome 120.0"
    os: "Windows 11"
    server: "Production"
    version: "2.1.0"
    
  reproduction_steps:
    - step: "Login to application"
      result: "Successfully logged in"
      
    - step: "Navigate through application normally"
      result: "All functions work"
      
    - step: "Continue using app for 10+ minutes"
      result: "Session expires, redirected to login"
      
  expected_behavior: |
    Session should remain active for 30 minutes
    of continuous activity
    
  actual_behavior: |
    Session expires after 10 minutes regardless
    of user activity
    
  impact:
    users_affected: "~2000 daily"
    business_impact: "High - user frustration"
    workaround: "Re-login required"
    
  root_cause_analysis:
    investigation:
      - "Checked session configuration"
      - "Reviewed authentication middleware"
      - "Analyzed session storage"
      
    finding: |
      Session refresh logic not triggering on
      API calls, only on page navigation
      
    root_cause: |
      Missing session touch in API middleware
      
  resolution:
    fix_description: |
      Add session refresh to API middleware
      to update last activity timestamp
      
    code_changes:
      - file: "src/middleware/auth.js"
        lines: "45-52"
        pr: "#1234"
        
    testing:
      - "Unit tests added"
      - "Integration test for session refresh"
      - "Manual verification completed"
      
    deployment:
      target: "2025-01-11"
      rollback_plan: "Revert middleware change"
      
  verification:
    test_scenarios:
      - "API-only activity maintains session"
      - "Mixed navigation maintains session"
      - "Idle timeout still enforced"
      
    verified_by: "@qa-lead"
    verification_date: "2025-01-11"
    
  lessons_learned:
    - "Need better session testing coverage"
    - "API middleware needs same features as web"
    - "Consider session monitoring dashboard"
```

### Process Quality Templates

#### 7. Post-Mortem Template

**Template**: `post-mortem.yml`  
**Purpose**: Learn from incidents and failures

```yaml
metadata:
  template: "post-mortem"
  version: "2.0"
  
post_mortem:
  incident_id: "INC-2025-001"
  title: "Payment Processing Outage"
  severity: "SEV-1"
  
  incident_summary:
    date: "2025-01-08"
    duration: "47 minutes"
    impact: |
      - Payment processing unavailable
      - ~$125,000 in delayed transactions
      - 1,200 affected customers
      
  timeline:
    - time: "14:23"
      event: "First payment failure alerts"
      actor: "Monitoring system"
      
    - time: "14:25"
      event: "On-call engineer paged"
      actor: "PagerDuty"
      
    - time: "14:28"
      event: "Engineer begins investigation"
      actor: "@on-call-engineer"
      
    - time: "14:35"
      event: "Root cause identified"
      actor: "@on-call-engineer"
      
    - time: "14:42"
      event: "Fix deployed to production"
      actor: "@platform-team"
      
    - time: "14:47"
      event: "Service fully restored"
      actor: "System"
      
    - time: "15:10"
      event: "All-clear sent to customers"
      actor: "@customer-success"
      
  root_cause:
    technical: |
      Database connection pool exhausted due to
      connection leak in new payment retry logic
      
    contributing_factors:
      - Insufficient connection pool monitoring
      - Missing integration tests for retry logic
      - Load testing didn't cover retry scenarios
      
  resolution:
    immediate:
      - Increased connection pool size
      - Restarted payment service
      
    permanent:
      - Fixed connection leak in retry logic
      - Added connection pool monitoring
      - Implemented circuit breaker pattern
      
  impact_analysis:
    customer_impact:
      - 1,200 customers affected
      - 3,450 failed transactions
      - 47 customer complaints
      
    business_impact:
      - $125,000 delayed revenue
      - $5,000 in service credits issued
      - Trust impact on key accounts
      
    technical_impact:
      - 47 minutes downtime
      - SLA breach (99.9% availability)
      - Increased support ticket volume
      
  action_items:
    - action: "Implement connection pool monitoring"
      owner: "@platform-team"
      due_date: "2025-01-15"
      status: "in-progress"
      
    - action: "Add retry logic integration tests"
      owner: "@qa-team"
      due_date: "2025-01-20"
      status: "planned"
      
    - action: "Update load testing scenarios"
      owner: "@performance-team"
      due_date: "2025-01-25"
      status: "planned"
      
    - action: "Create runbook for connection issues"
      owner: "@sre-team"
      due_date: "2025-01-18"
      status: "planned"
      
  what_went_well:
    - Quick detection via monitoring
    - Fast root cause identification
    - Effective team communication
    - Clear customer communication
    
  what_went_wrong:
    - Connection leak not caught in testing
    - Insufficient monitoring coverage
    - No automatic remediation
    - Runbook didn't cover this scenario
    
  lessons_learned:
    - Always monitor resource pools
    - Test retry logic under load
    - Implement circuit breakers for dependencies
    - Regular connection leak audits needed
```

#### 8. Quality Improvement Plan Template

**Template**: `improvement-plan.yml`  
**Purpose**: Systematic quality improvement

```yaml
metadata:
  template: "improvement-plan"
  version: "2.0"
  
improvement_plan:
  title: "Q1 2025 Quality Improvement Initiative"
  sponsor: "@vp-engineering"
  duration: "3 months"
  
  current_state_analysis:
    metrics:
      defect_escape_rate: 5.2%
      test_coverage: 72%
      code_review_time: "4 hours average"
      deployment_failures: 8.5%
      
    pain_points:
      - Long code review cycles
      - Inadequate test coverage
      - Manual testing bottlenecks
      - Inconsistent coding standards
      
    root_causes:
      - Lack of automated checks
      - Missing test infrastructure
      - No coding standards enforcement
      - Limited QA resources
      
  improvement_goals:
    - goal: "Reduce defect escape rate"
      target: "< 2%"
      metric: "Production defects / Total defects"
      
    - goal: "Increase test coverage"
      target: "> 85%"
      metric: "Code coverage percentage"
      
    - goal: "Faster code reviews"
      target: "< 2 hours"
      metric: "Average review completion time"
      
    - goal: "Reduce deployment failures"
      target: "< 3%"
      metric: "Failed deployments / Total deployments"
      
  initiatives:
    automated_quality_gates:
      description: "Implement automated quality checks"
      activities:
        - Setup SonarQube for code analysis
        - Configure pre-commit hooks
        - Implement automated security scanning
        - Add performance regression tests
      owner: "@platform-team"
      timeline: "4 weeks"
      
    test_automation_expansion:
      description: "Increase test automation coverage"
      activities:
        - Identify critical untested paths
        - Develop E2E test framework
        - Create test data management system
        - Train team on test automation
      owner: "@qa-team"
      timeline: "8 weeks"
      
    code_review_optimization:
      description: "Streamline code review process"
      activities:
        - Define review checklist
        - Implement PR templates
        - Setup automated PR checks
        - Create review guidelines
      owner: "@tech-leads"
      timeline: "2 weeks"
      
    continuous_learning:
      description: "Improve team capabilities"
      activities:
        - Weekly tech talks
        - Testing best practices training
        - Code review workshops
        - Quality metrics education
      owner: "@engineering-manager"
      timeline: "Ongoing"
      
  success_metrics:
    weekly:
      - Code coverage trend
      - Review cycle time
      - Defects found in QA vs Production
      
    monthly:
      - Defect escape rate
      - Deployment success rate
      - Team satisfaction scores
      
  investment:
    tools:
      - SonarQube license: "$5,000/year"
      - Test automation tools: "$10,000/year"
      
    training:
      - External training: "$15,000"
      - Internal workshops: "40 hours"
      
    time:
      - Setup and configuration: "120 hours"
      - Process documentation: "40 hours"
      
  risks:
    - description: "Team resistance to change"
      mitigation: "Gradual rollout, clear benefits communication"
      
    - description: "Initial productivity drop"
      mitigation: "Phased implementation, adequate training"
      
  review_schedule:
    - "Week 2: Initial setup review"
    - "Week 4: Progress checkpoint"
    - "Week 8: Mid-point assessment"
    - "Week 12: Final evaluation"
```

## Using Quality Templates

### Quick Commands

```bash
# Perform code review
claude-code "/project:simone:code_review --pr=1234"

# Create test plan
claude-code "/project:simone:create_test_plan --component=auth"

# Generate quality report
claude-code "/project:simone:quality_report --period=monthly"

# Initiate post-mortem
claude-code "/project:simone:post_mortem --incident=INC-001"
```

### Integration with CI/CD

```yaml
# .github/workflows/quality-gates.yml
quality_checks:
  - uses: simone/quality-gate-action@v2
    with:
      template: "quality-gate.yml"
      fail_on: "any_critical"
```

## Best Practices

### 1. Continuous Quality

- Embed quality checks throughout development
- Automate repetitive quality tasks
- Track quality metrics continuously

### 2. Data-Driven Decisions

- Base improvements on metrics
- Set measurable quality goals
- Regular trend analysis

### 3. Team Engagement

- Involve entire team in quality
- Celebrate quality achievements
- Learn from failures together

### 4. Process Evolution

- Regularly review and update templates
- Adapt to team and project needs
- Share learnings across teams

### 5. Balance

- Don't sacrifice speed for perfection
- Focus on high-impact quality measures
- Pragmatic approach to quality

## Conclusion

Quality templates in the Simone Framework provide comprehensive structures for maintaining and improving software quality. By using these templates consistently, teams can build quality into their development process, catch issues early, and continuously improve their practices. The key is to adapt these templates to your specific needs while maintaining their core quality principles.