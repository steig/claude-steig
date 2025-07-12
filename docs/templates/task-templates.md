# Task Templates

**Last Updated**: 2025-07-10  
**Version**: 2.1.0  
**Framework**: Simone Framework

## Overview

Task templates in the Simone Framework provide standardized structures for different types of development work. These templates ensure consistency, completeness, and quality across all team members and projects.

## Available Task Templates

The Simone Framework includes 14 pre-built task templates covering common development scenarios:

### 1. Feature Development

**Template**: `feature.yml`  
**Purpose**: New functionality or capability

```yaml
metadata:
  template: "feature"
  version: "2.0"
  
task:
  title: "Implement user profile management"
  type: "feature"
  priority: "high"
  
  description: |
    As a user, I want to manage my profile information
    so that I can keep my account details up to date.
    
  acceptance_criteria:
    - User can view their current profile
    - User can edit profile fields
    - Changes are validated before saving
    - User receives confirmation of updates
    
  technical_requirements:
    api_endpoints:
      - GET /api/user/profile
      - PUT /api/user/profile
    
    frontend_components:
      - ProfileView
      - ProfileEditForm
      - ValidationMessages
      
    database_changes:
      - Add profile_updated_at timestamp
      
  estimation:
    development: 16
    testing: 8
    documentation: 4
    
  dependencies:
    - Authentication system
    - User database schema
    
  risks:
    - Profile data validation complexity
    - Image upload handling
```

### 2. Bug Fix

**Template**: `bug-fix.yml`  
**Purpose**: Resolve defects or issues

```yaml
metadata:
  template: "bug-fix"
  version: "2.0"
  
task:
  title: "Fix memory leak in data processing"
  type: "bug"
  priority: "critical"
  severity: "high"
  
  bug_report:
    reported_by: "@customer-support"
    reported_date: "2025-01-10"
    affected_users: "~500"
    
  symptoms: |
    - Application memory usage increases over time
    - Server crashes after 24-48 hours
    - Performance degradation before crash
    
  root_cause: |
    Event listeners not being properly removed
    when components are destroyed
    
  reproduction_steps:
    - Start the application
    - Navigate between dashboard and reports repeatedly
    - Monitor memory usage in dev tools
    - Observe increasing memory consumption
    
  fix_approach:
    - Implement proper cleanup in useEffect hooks
    - Add memory leak detection tests
    - Monitor with performance profiler
    
  verification:
    - Memory usage remains stable over time
    - No performance degradation
    - Automated tests pass
    
  affected_files:
    - src/components/Dashboard.jsx
    - src/components/Reports.jsx
    - src/hooks/useDataStream.js
```

### 3. Technical Debt

**Template**: `technical-debt.yml`  
**Purpose**: Code improvements and refactoring

```yaml
metadata:
  template: "technical-debt"
  version: "2.0"
  
task:
  title: "Refactor authentication middleware"
  type: "technical-debt"
  priority: "medium"
  
  debt_description: |
    Current authentication middleware has grown organically
    and contains duplicated logic across multiple files
    
  current_issues:
    - Code duplication in 5 different middleware functions
    - Inconsistent error handling
    - Poor test coverage (< 40%)
    - Performance bottleneck on token validation
    
  refactoring_plan:
    - Consolidate authentication logic into single module
    - Implement consistent error handling
    - Add comprehensive test suite
    - Optimize token validation with caching
    
  success_metrics:
    - Test coverage > 90%
    - Response time < 50ms
    - Zero code duplication
    - All auth flows documented
    
  migration_strategy:
    - Phase 1: Create new consolidated module
    - Phase 2: Add feature flags for gradual rollout
    - Phase 3: Migrate endpoints incrementally
    - Phase 4: Remove old implementation
```

### 4. Performance Optimization

**Template**: `performance.yml`  
**Purpose**: Improve system performance

```yaml
metadata:
  template: "performance"
  version: "2.0"
  
task:
  title: "Optimize database query performance"
  type: "performance"
  priority: "high"
  
  performance_issue:
    metric: "response_time"
    current_value: "2.5s"
    target_value: "< 500ms"
    affected_endpoints:
      - /api/reports/generate
      - /api/analytics/dashboard
      
  analysis:
    - N+1 query problem in report generation
    - Missing database indexes
    - Inefficient JOIN operations
    - No query result caching
    
  optimization_plan:
    - Add composite indexes on frequently queried columns
    - Implement eager loading for related data
    - Add Redis caching layer
    - Optimize SQL queries with EXPLAIN analysis
    
  benchmarks:
    before:
      - Report generation: 2.5s
      - Dashboard load: 1.8s
      
    target:
      - Report generation: < 500ms
      - Dashboard load: < 300ms
      
  validation:
    - Load testing with 1000 concurrent users
    - Monitor query execution plans
    - Track response time metrics
```

### 5. Security Enhancement

**Template**: `security.yml`  
**Purpose**: Security improvements and fixes

```yaml
metadata:
  template: "security"
  version: "2.0"
  
task:
  title: "Implement rate limiting for API endpoints"
  type: "security"
  priority: "critical"
  
  security_concern:
    vulnerability_type: "DoS/DDoS"
    owasp_category: "A6:2021 – Vulnerable Components"
    severity: "high"
    
  threat_model:
    - Attackers could overwhelm API with requests
    - No current protection against automated attacks
    - Resource exhaustion possible
    
  implementation:
    approach: "Token bucket algorithm"
    
    rate_limits:
      - Public endpoints: 100 requests/minute
      - Authenticated endpoints: 1000 requests/minute
      - Admin endpoints: 5000 requests/minute
      
    components:
      - Rate limiting middleware
      - Redis for distributed counting
      - Custom headers for limit info
      
  security_testing:
    - Penetration testing with automated tools
    - Load testing to verify limits
    - Ensure legitimate users not affected
    
  compliance:
    - OWASP compliance check
    - Security audit documentation
    - Update security policies
```

### 6. Infrastructure

**Template**: `infrastructure.yml`  
**Purpose**: Infrastructure and DevOps tasks

```yaml
metadata:
  template: "infrastructure"
  version: "2.0"
  
task:
  title: "Implement blue-green deployment"
  type: "infrastructure"
  priority: "high"
  
  infrastructure_goal: |
    Enable zero-downtime deployments with ability
    to quickly rollback if issues detected
    
  current_state:
    - Manual deployments with 5-10 minute downtime
    - No automated rollback capability
    - Risk of extended outages
    
  target_architecture:
    - Two identical production environments (blue/green)
    - Load balancer switching between environments
    - Automated health checks before switch
    - One-click rollback capability
    
  implementation_steps:
    - Set up duplicate production environment
    - Configure load balancer rules
    - Create deployment automation scripts
    - Implement health check endpoints
    - Document deployment procedures
    
  success_criteria:
    - Zero downtime during deployments
    - Rollback time < 30 seconds
    - Automated smoke tests pass
    - No user session disruption
```

### 7. Documentation

**Template**: `documentation.yml`  
**Purpose**: Documentation tasks

```yaml
metadata:
  template: "documentation"
  version: "2.0"
  
task:
  title: "Create API documentation"
  type: "documentation"
  priority: "medium"
  
  documentation_scope:
    - REST API endpoints
    - Authentication methods
    - Request/response formats
    - Error codes and handling
    - Rate limiting information
    
  target_audience:
    - External developers
    - Internal team members
    - QA engineers
    
  deliverables:
    - OpenAPI 3.0 specification
    - Interactive API documentation (Swagger UI)
    - Authentication guide
    - Quick start tutorial
    - Code examples in 3 languages
    
  tools:
    - OpenAPI/Swagger
    - Postman collections
    - Code snippet generator
    
  maintenance_plan:
    - Auto-generate from code comments
    - Version with API changes
    - Regular review cycle
```

### 8. Testing

**Template**: `testing.yml`  
**Purpose**: Test creation and improvements

```yaml
metadata:
  template: "testing"
  version: "2.0"
  
task:
  title: "Implement E2E tests for checkout flow"
  type: "testing"
  priority: "high"
  
  testing_scope:
    flows:
      - Guest checkout
      - Registered user checkout
      - Multiple payment methods
      - Error scenarios
      
  test_scenarios:
    - Happy path: Successful purchase
    - Payment failure handling
    - Network timeout resilience
    - Inventory shortage handling
    - Coupon code validation
    
  technical_approach:
    framework: "Cypress"
    environment: "Staging"
    data_management: "Test fixtures"
    
  coverage_targets:
    - Critical paths: 100%
    - Edge cases: 80%
    - Error scenarios: 90%
    
  integration:
    - Run on every PR
    - Nightly full suite execution
    - Performance benchmarking
```

### 9. Research/Spike

**Template**: `research.yml`  
**Purpose**: Technical investigation tasks

```yaml
metadata:
  template: "research"
  version: "2.0"
  
task:
  title: "Evaluate GraphQL adoption"
  type: "research"
  priority: "medium"
  timebox: "2 days"
  
  research_questions:
    - Is GraphQL suitable for our use case?
    - What is the migration effort from REST?
    - Performance implications?
    - Team learning curve?
    
  evaluation_criteria:
    - Performance benchmarks
    - Development complexity
    - Tooling ecosystem
    - Community support
    - Long-term maintainability
    
  proof_of_concept:
    - Implement sample GraphQL endpoint
    - Compare with equivalent REST endpoint
    - Measure performance differences
    - Assess developer experience
    
  deliverables:
    - Technical evaluation document
    - POC implementation
    - Recommendation with rationale
    - Migration plan if approved
```

### 10. Design/UX

**Template**: `design.yml`  
**Purpose**: Design and user experience tasks

```yaml
metadata:
  template: "design"
  version: "2.0"
  
task:
  title: "Redesign onboarding flow"
  type: "design"
  priority: "high"
  
  design_goal: |
    Reduce onboarding drop-off rate from 60% to < 20%
    
  user_research:
    - Current pain points identified
    - User interviews completed: 15
    - Analytics data reviewed
    
  design_deliverables:
    - User journey map
    - Wireframes for 5 screens
    - High-fidelity mockups
    - Interactive prototype
    - Usability test results
    
  success_metrics:
    - Completion rate > 80%
    - Time to complete < 5 minutes
    - User satisfaction > 4.5/5
    
  implementation_notes:
    - Progressive disclosure approach
    - Mobile-first design
    - Accessibility WCAG 2.1 AA compliant
```

### 11. Data Migration

**Template**: `data-migration.yml`  
**Purpose**: Data migration and transformation

```yaml
metadata:
  template: "data-migration"
  version: "2.0"
  
task:
  title: "Migrate user data to new schema"
  type: "data-migration"
  priority: "critical"
  
  migration_scope:
    source: "PostgreSQL 12 - legacy schema"
    target: "PostgreSQL 15 - new schema"
    data_volume: "5M user records"
    
  schema_changes:
    - Normalize address data
    - Split name into first/last
    - Add UUID primary keys
    - Convert timestamps to UTC
    
  migration_strategy:
    - Phase 1: Dual-write to both schemas
    - Phase 2: Backfill historical data
    - Phase 3: Validate data integrity
    - Phase 4: Switch reads to new schema
    - Phase 5: Deprecate old schema
    
  validation:
    - Row count verification
    - Data integrity checks
    - Performance benchmarks
    - Rollback procedures
    
  risk_mitigation:
    - Full backup before migration
    - Incremental migration approach
    - Real-time monitoring
    - Automated rollback triggers
```

### 12. Integration

**Template**: `integration.yml`  
**Purpose**: Third-party integrations

```yaml
metadata:
  template: "integration"
  version: "2.0"
  
task:
  title: "Integrate Stripe payment processing"
  type: "integration"
  priority: "high"
  
  integration_details:
    service: "Stripe"
    api_version: "2023-10-16"
    features:
      - Payment processing
      - Subscription management
      - Webhook handling
      
  technical_requirements:
    - PCI compliance
    - Webhook signature verification
    - Idempotency key handling
    - Error recovery mechanisms
    
  implementation_checklist:
    - [ ] API credentials management
    - [ ] Payment flow implementation
    - [ ] Webhook endpoint setup
    - [ ] Error handling
    - [ ] Testing with test keys
    - [ ] Security review
    - [ ] Documentation
    
  testing_approach:
    - Unit tests with mocked responses
    - Integration tests with test API
    - End-to-end payment flow tests
    - Webhook delivery testing
```

### 13. Compliance

**Template**: `compliance.yml`  
**Purpose**: Regulatory compliance tasks

```yaml
metadata:
  template: "compliance"
  version: "2.0"
  
task:
  title: "Implement GDPR data deletion"
  type: "compliance"
  priority: "critical"
  regulation: "GDPR"
  
  compliance_requirement: |
    Users must be able to request deletion of their
    personal data within 30 days (Right to Erasure)
    
  implementation_scope:
    - User self-service deletion UI
    - Admin dashboard for requests
    - Automated data purging
    - Audit trail maintenance
    
  data_locations:
    - Primary database
    - Backup systems
    - Analytics platforms
    - Third-party services
    - Log files
    
  technical_approach:
    - Soft delete with 30-day retention
    - Hard delete after retention period
    - Cascade deletion to related data
    - Preserve legally required data
    
  validation:
    - Data deletion verification
    - Compliance audit trail
    - Legal team review
    - Documentation update
```

### 14. Incident Response

**Template**: `incident.yml`  
**Purpose**: Production incident tasks

```yaml
metadata:
  template: "incident"
  version: "2.0"
  
task:
  title: "Database connection pool exhaustion"
  type: "incident"
  priority: "critical"
  severity: "P1"
  
  incident_details:
    detected: "2025-01-10 14:30 UTC"
    impact: "30% of users experiencing errors"
    duration: "45 minutes"
    
  symptoms:
    - Connection timeout errors
    - Increased response times
    - 500 errors on API calls
    
  immediate_actions:
    - Increased connection pool size
    - Restarted affected services
    - Scaled up database resources
    
  root_cause_analysis:
    problem: "Connection leak in new feature"
    cause: "Connections not properly closed in error cases"
    
  remediation:
    short_term:
      - Fix connection leak
      - Add connection pool monitoring
      
    long_term:
      - Implement connection pooling best practices
      - Add automated testing for connection leaks
      - Create runbook for similar incidents
      
  follow_up:
    - Post-mortem document
    - Update monitoring alerts
    - Team training on connection management
```

## Using Task Templates

### Creating a Task from Template

```bash
# Create a new feature task
claude-code "/project:simone:create_task --template=feature --title='Add user notifications'"

# Create a bug fix task
claude-code "/project:simone:create_task --template=bug-fix --priority=critical"

# Create a research task
claude-code "/project:simone:create_task --template=research --timebox='3 days'"
```

### Customizing Templates

1. **Copy existing template**:
   ```bash
   cp .claude/templates/simone/tasks/feature.yml \
      .simone/templates/tasks/custom-feature.yml
   ```

2. **Modify for your needs**:
   ```yaml
   # Add custom fields
   custom_fields:
     business_value: "high"
     stakeholder: "@product-owner"
     market_impact: "description"
   ```

3. **Use custom template**:
   ```bash
   claude-code "/project:simone:create_task --template=custom-feature"
   ```

## Template Best Practices

### 1. Complete All Sections

Don't leave template sections empty. If not applicable, explicitly state "N/A" with reasoning.

### 2. Be Specific

- Use concrete examples
- Include measurable success criteria
- Define clear acceptance criteria

### 3. Link Dependencies

Always identify and link:
- Blocking dependencies
- Related tasks
- Required resources

### 4. Estimate Realistically

Include time for:
- Development
- Testing
- Code review
- Documentation
- Deployment

### 5. Consider Edge Cases

For each task type, consider:
- Error scenarios
- Performance implications
- Security concerns
- User experience impact

## Template Validation

The Simone Framework validates templates for:

- Required fields presence
- Data type correctness
- Reference validity
- Estimation reasonableness

Run validation:
```bash
claude-code "/project:simone:validate_task --file=TASK-001.yml"
```

## Integration with Workflow

### Sprint Planning

Templates integrate with sprint planning:
```yaml
sprint_planning:
  task_selection:
    - Review template completeness
    - Verify estimations
    - Check dependencies
    - Assign to team members
```

### Progress Tracking

Track task progress:
```yaml
progress_tracking:
  states:
    - not_started
    - in_progress
    - blocked
    - in_review
    - completed
    
  updates:
    - Daily status updates
    - Blocker identification
    - Time tracking
```

### Quality Gates

Templates enforce quality:
```yaml
quality_gates:
  before_start:
    - Dependencies resolved
    - Acceptance criteria clear
    - Resources available
    
  before_complete:
    - All criteria met
    - Tests passing
    - Documentation updated
    - Code reviewed
```

## Conclusion

Task templates in the Simone Framework provide structure and consistency while remaining flexible enough to accommodate various project needs. By using these templates, teams ensure that all necessary information is captured, work is properly estimated, and quality standards are maintained throughout the development process.