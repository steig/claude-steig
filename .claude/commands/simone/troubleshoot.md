# Troubleshoot - Comprehensive Project Diagnostic and Issue Resolution

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: System architecture diagnostics and design analysis
- `--persona-security`: Security vulnerability assessment and OWASP compliance
- `--persona-analyzer`: Code quality metrics and performance analysis  
- `--persona-qa`: Testing infrastructure and quality assurance diagnostics
- `--persona-devops`: Infrastructure, deployment, and environment diagnostics
- `--persona-performance`: Performance bottlenecks and optimization analysis

**ADVANCED FLAGS:**
- `--introspect`: Show transparent diagnostic reasoning process
- `--consensus`: Multi-model consensus on issue prioritization
- `--think-deep`: Extended troubleshooting analysis with deep investigation
- `--compressed`: Output concise diagnostic summary only

**SCOPE FLAGS:**
- `--scope-full`: Complete project health assessment (default)
- `--scope-performance`: Focus on performance bottlenecks
- `--scope-security`: Security vulnerabilities and compliance
- `--scope-quality`: Code quality and technical debt
- `--scope-infrastructure`: Environment and deployment issues
- `--scope-workflow`: Development process bottlenecks

## Create a TODO with EXACTLY these 12 Items

1. Parse troubleshooting scope and validate diagnostic requirements
2. Execute comprehensive system health checks and safety validation
3. Analyze project structure, organization, and architectural patterns
4. Assess test infrastructure coverage and quality metrics
5. Review technical debt accumulation and code quality issues
6. Examine deployment pipeline and environment configuration
7. Identify workflow bottlenecks and process inefficiencies
8. Analyze performance metrics and optimization opportunities
9. Conduct security assessment and vulnerability scanning
10. Generate prioritized issue recommendations with severity levels
11. Create actionable remediation plan with milestone integration
12. Generate comprehensive diagnostic report and suggest next actions

## DETAILS on every TODO item

### 1. Parse troubleshooting scope and validate diagnostic requirements

**MCP INTEGRATION:** Use Sequential Thinking for systematic diagnostic approach

Check: <$ARGUMENTS>

**Default Scope**: If no scope specified, execute full diagnostic assessment

**Validation Steps:**
- VERIFY project is properly initialized with Simone Framework
- VALIDATE .simone directory structure exists and is accessible
- CHECK for required configuration files and templates
- ENSURE MCP servers are available for enhanced analysis

### 2. Execute comprehensive system health checks and safety validation

**CRITICAL:** System health is foundation for all diagnostics

**MCP INTEGRATION:** Sequential Thinking + Work History for baseline establishment

**Health Check Sequence:**
- USE patterns from `safety_check.md` for system validation
- ANALYZE current project status using `status.md` command patterns
- CALCULATE health scores (1-10 scale) for each system component
- IDENTIFY any blocking issues requiring immediate attention
- ESTABLISH baseline metrics for comparative analysis

**System Components to Validate:**
- Git repository status and branch health
- Build system functionality and dependencies
- Test infrastructure availability
- Development environment configuration
- CI/CD pipeline status

### 3. Analyze project structure, organization, and architectural patterns

**MCP INTEGRATION:** Context7 for understanding project evolution patterns

**Architectural Analysis:**
- EXAMINE directory structure and file organization patterns
- ASSESS adherence to established architectural principles
- IDENTIFY structural inconsistencies or anti-patterns
- EVALUATE modular design and separation of concerns
- ANALYZE dependency relationships and coupling levels

**Documentation Assessment:**
- REVIEW README files and project documentation quality
- CHECK for architectural decision records (ADRs)
- VALIDATE configuration file organization and clarity

### 4. Assess test infrastructure coverage and quality metrics

**MCP INTEGRATION:** Sequential Thinking for systematic test analysis

**Test Infrastructure Evaluation:**
- EXECUTE test coverage analysis using project-specific tools
- ASSESS test pyramid balance (unit, integration, e2e)
- IDENTIFY gaps in test coverage for critical functionality
- EVALUATE test reliability and flakiness patterns
- REVIEW test execution speed and performance

**Quality Metrics:**
- CALCULATE code coverage percentages by module
- ANALYZE test-to-code ratio and quality indicators
- IDENTIFY untested critical paths and edge cases

### 5. Review technical debt accumulation and code quality issues

**MCP INTEGRATION:** Work History for tracking debt patterns over time

**Technical Debt Analysis:**
- SCAN for code smells and anti-patterns
- IDENTIFY duplicated code and refactoring opportunities
- ASSESS commenting and documentation quality
- EVALUATE naming conventions and code clarity
- ANALYZE complexity metrics and maintainability scores

**Debt Categorization:**
- CLASSIFY debt by severity: Critical, High, Medium, Low
- ESTIMATE effort required for remediation
- PRIORITIZE based on business impact and risk

### 6. Examine deployment pipeline and environment configuration

**MCP INTEGRATION:** Sequential Thinking for infrastructure analysis

**Deployment Assessment:**
- REVIEW CI/CD pipeline configuration and efficiency
- ANALYZE deployment frequency and success rates
- IDENTIFY bottlenecks in build and deployment processes
- ASSESS environment consistency and configuration management
- EVALUATE rollback procedures and disaster recovery readiness

**Environment Validation:**
- CHECK development, staging, and production environment parity
- REVIEW environment variable management and security
- ASSESS monitoring and alerting configuration

### 7. Identify workflow bottlenecks and process inefficiencies

**MCP INTEGRATION:** Work History for pattern analysis + Sequential Thinking

**Workflow Analysis:**
- EXAMINE development team velocity and throughput metrics
- IDENTIFY blockers in code review and approval processes
- ASSESS branch management and merge conflict patterns
- EVALUATE issue tracking and project management effectiveness
- ANALYZE communication and collaboration bottlenecks

**Process Optimization:**
- IDENTIFY automation opportunities
- RECOMMEND workflow improvements
- SUGGEST tooling enhancements

### 8. Analyze performance metrics and optimization opportunities

**MCP INTEGRATION:** Sequential Thinking for systematic performance analysis

**Performance Assessment:**
- EXECUTE performance profiling using available tools
- ANALYZE application response times and throughput
- IDENTIFY memory usage patterns and potential leaks
- ASSESS database query performance and optimization needs
- EVALUATE frontend loading times and user experience metrics

**Optimization Identification:**
- PRIORITIZE performance improvements by impact
- RECOMMEND specific optimization strategies
- ESTIMATE performance gains from suggested improvements

### 9. Conduct security assessment and vulnerability scanning

**MCP INTEGRATION:** Sequential Thinking + Context7 for comprehensive security analysis

**Security Evaluation:**
- SCAN for known vulnerabilities in dependencies
- ASSESS authentication and authorization implementations
- REVIEW data handling and privacy compliance
- IDENTIFY potential security anti-patterns
- EVALUATE input validation and sanitization practices

**Compliance Check:**
- ASSESS OWASP Top 10 compliance
- REVIEW security best practices adherence
- IDENTIFY security training needs

### 10. Generate prioritized issue recommendations with severity levels

**MCP INTEGRATION:** Sequential Thinking for systematic prioritization

**Issue Classification System:**
- **CRITICAL**: Blocking issues requiring immediate attention
- **HIGH**: Significant impact on functionality or security
- **MEDIUM**: Important improvements with moderate impact
- **LOW**: Nice-to-have enhancements and optimizations

**Prioritization Criteria:**
- Business impact and user experience
- Security implications and risk levels
- Development velocity impact
- Technical debt burden
- Resource requirements for resolution

### 11. Create actionable remediation plan with milestone integration

**CRITICAL:** Use established milestone and task templates

**MCP INTEGRATION:** Sequential Thinking for structured planning + Work History for timeline estimation

**Remediation Planning:**
- GROUP related issues into logical milestone chunks
- ESTIMATE effort and timeline for each remediation task
- IDENTIFY dependencies between improvement tasks
- SUGGEST incremental improvement approach

**Template Integration:**
- USE `milestone_meta_template.md` for major improvement initiatives
- APPLY `task_template.md` for specific remediation tasks
- LEVERAGE `bug_report_template.md` for critical issues
- UTILIZE `technical_debt_template.md` for debt tracking

**Milestone Structure:**
```
MILESTONE: [Diagnostic Category] Improvement Initiative
PRIORITY: [Critical/High/Medium/Low]
ESTIMATED_EFFORT: [Hours/Days/Weeks]
DEPENDENCIES: [List of prerequisite tasks]
SUCCESS_CRITERIA: [Measurable outcomes]
```

### 12. Generate comprehensive diagnostic report and suggest next actions

**MCP INTEGRATION:** Serena for enhanced reporting + Sequential Thinking for action planning

**Report Structure:**
```
# PROJECT DIAGNOSTIC REPORT
Generated: [Timestamp]
Scope: [Diagnostic scope executed]
Overall Health Score: [1-10]

## EXECUTIVE SUMMARY
- Critical Issues: [Count and brief description]
- High Priority Items: [Count and summary]
- Overall Assessment: [Health status narrative]

## DETAILED FINDINGS
[Organized by diagnostic category]

## PRIORITIZED ACTION PLAN
[Ordered list of recommended actions]

## PROPOSED MILESTONES
[Suggested milestone structure for remediation]

## NEXT IMMEDIATE STEPS
[Top 3-5 actions to take immediately]
```

**Output Location:**
- SAVE main report to `.simone/10_STATE_OF_PROJECT/diagnostic_report_[timestamp].md`
- CREATE individual issue tickets in `.simone/02_MILESTONES/` if milestones are recommended
- UPDATE `.simone/04_TASKS/` with immediate action items

**Suggested Follow-up Commands:**
- `create_milestone` for major improvement initiatives
- `create_general_task` for immediate remediation items
- `log_technical_debt` for debt tracking and management
- `safety_check` for ongoing monitoring

**Integration Points:**
- LINK findings to existing project review processes
- COORDINATE with established quality assurance workflows
- ALIGN with current sprint planning and milestone tracking