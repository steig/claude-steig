# Command Reference

Complete reference for all Simone Framework commands available in Claude Code.

## Overview

The Simone Framework provides a comprehensive suite of specialized commands for project management, development workflow, quality assurance, and safety management. Each command is designed to work seamlessly with the `.simone/` directory structure and project documentation.

**Framework Evolution**: As of v3.0.0, the framework has been streamlined with:
- **Unified command interfaces** reducing cognitive overhead
- **Integrated automation workflows** minimizing manual steps
- **Consolidated templates** eliminating duplication
- **Built-in quality validation** replacing standalone scripts
- **🔒 Quality Enforcement System**: Garbage-in, garbage-out prevention with intelligent input validation
- **Progressive quality gates**: Escalating restrictions based on input quality history
- **Real-time quality scoring**: 10-point system with actionable feedback

**🎭 Enhanced with Cognitive Personas**: Many commands support domain-specific expertise through cognitive personas, inspired by [SuperClaude](https://github.com/NomenAK/SuperClaude)'s pioneering work in specialized AI assistance patterns.

## Streamlined Command Structure

**Recommended Command Flow for v3.0.0+**:

```mermaid
flowchart TD
    A[Project Setup] --> B[initialize]
    B --> C[create_milestone]
    C --> D[create_sprint_tasks]
    D --> E[do_task_auto]
    E --> F{Quality Gates}
    F -->|Pass| G[Hierarchical Completion Check]
    F -->|Fail| H[Technical Debt Logging]
    H --> E
    G --> I[create_pr_auto]
    I --> J[Unified Review]
    J --> K[merge]
    
    L[Weekly Maintenance] --> M[sync_metadata]
    M --> N[Completion Dashboard]
    
    K[Emergency Situations] --> L[emergency_stop]
    K --> M[rollback]
    K --> N[user_intervention]
```

**Key Simplifications**:
- **Unified Review System**: Single `review` command with type flags replaces 4 separate commands
- **Automated Task Execution**: `do_task_auto` handles complete workflow from start to PR
- **Integrated Quality Gates**: Built-in validation eliminates need for separate validation scripts
- **Streamlined PR Creation**: `create_pr_auto` provides comprehensive automation with approval gates
- **Hierarchical Completion Tracking**: Automatic status propagation from tasks → sprints → milestones → project
- **Metadata Synchronization**: `sync_metadata` ensures consistency across all tracking levels

## Command Categories

### 🚀 Project Management
- [`initialize`](#initialize) - Set up new Simone project
- [`status`](#status) - Comprehensive project status dashboard  
- [`project_review`](#project_review) - Conduct project health reviews
- [`version`](#version) - Manage project versioning

### 📋 Task Management
- [`create_general_task`](#create_general_task) - Create new general tasks
- [`create_sprint_tasks`](#create_sprint_tasks) - Create sprint-specific tasks
- [`create_bug`](#create_bug) - Create bug reports with GitHub integration
- [`start_task`](#start_task) - ⚠️ **DEPRECATED** Functionality merged into `do_task` and `do_task_auto`
- [`do_task`](#do_task) - Execute task implementation with guided workflow
- [`do_task_auto`](#do_task_auto) - **NEW** Automated task execution with minimal human intervention
- [`update_task_status`](#update_task_status) - Update task progress with hierarchical completion checking
- [`sync_metadata`](#sync_metadata) - **NEW** Synchronize completion status across project hierarchy
- [`fix_bug`](#fix_bug) - Implement bug fixes

### 🔧 Development Workflow
- [`commit`](#commit) - Create structured commits with task references
- [`create_pr`](#create_pr) - ⚠️ **BASIC VERSION** Use `create_pr_auto` for enhanced automation
- [`create_pr_auto`](#create_pr_auto) - **RECOMMENDED** Automated PR creation with comprehensive context
- [`review_pr`](#review_pr) - Conduct thorough pull request reviews
- [`merge`](#merge) - Merge code with quality checks
- [`test`](#test) - Execute comprehensive testing workflows

### 🎯 Sprint & Milestone Management
- [`create_milestone`](#create_milestone) - AI-powered milestone generation from natural language
- [`create_sprints_from_milestone`](#create_sprints_from_milestone) - Generate sprints from milestones
- [`sync`](#sync) - Synchronize project state and dependencies

### 🤖 Automation & Quality Gates
- **Built-in Quality Validation** - Integrated into `do_task_auto` and automated workflows
- **GitHub Actions Integration** - Automated CI/CD quality validation pipeline
- **Unified Validation System** - Replaces standalone validation scripts

### 🔍 Helper Commands
- [`troubleshoot`](#troubleshoot) - Comprehensive project diagnostic and issue resolution
- [`research`](#research) - Comprehensive codebase investigation and analysis
- [`plan`](#plan) - Strategic feature and implementation planning
- [`analyze`](#analyze) - Deep code and system analysis
- [`investigate`](#investigate) - Targeted bug and issue investigation

### 🔍 Quality Assurance
- [`review`](#review) - **NEW** Unified review system for code, quality, testing, and discussions
- [`code_review`](#code_review) - ⚠️ **DEPRECATED** Use `review --type-code` instead
- [`quality_review`](#quality_review) - ⚠️ **DEPRECATED** Use `review --type-quality` instead  
- [`testing_review`](#testing_review) - ⚠️ **DEPRECATED** Use `review --type-testing` instead
- [`discuss_review`](#discuss_review) - ⚠️ **DEPRECATED** Use `review --type-discussion` instead
- [`log_technical_debt`](#log_technical_debt) - Document and track technical debt

### 🛡️ Safety & Emergency Response
- [`emergency_stop`](#emergency_stop) - Immediately halt all autonomous operations
- [`rollback`](#rollback) - Safe rollback with backup and recovery
- [`safety_check`](#safety_check) - Comprehensive safety validation
- [`safety_monitor`](#safety_monitor) - Real-time monitoring with alerts
- [`user_intervention`](#user_intervention) - Manual override and control

### ⚡ Utility Commands
- [`prime`](#prime) - Initialize Claude context with project information
- [`yolo`](#yolo) - Quick development actions (use with caution)
- [`command-validator`](#command-validator) - ⚠️ **DEPRECATED** Command validation now integrated into framework

---

## Command Details

### initialize

**Purpose**: Set up a new Simone project structure and configuration.

**Usage**: 
```
/project:simone:initialize [project_name]
```

**Arguments**:
- `project_name` (optional) - Name of the project to initialize

**What it does**:
1. Creates complete `.simone/` directory structure
2. Initializes project manifest with metadata
3. Sets up templates and documentation framework
4. Configures Claude integration files
5. Creates initial architectural decision records

**Output**: Complete project structure ready for development

---

### status

**Purpose**: Provides comprehensive status overview of project health, task progress, deployment state, and workflow metrics.

**Usage**:
```
/project:simone:status [scope] [detail_level] [format]
```

**Arguments**:
- `scope` - project | tasks | sprint | deployment | quality | team
- `detail_level` - summary | detailed | executive | operational  
- `format` - dashboard | report | metrics

**Features**:
- Real-time project health metrics
- Sprint and milestone progress tracking
- Task distribution and completion rates
- Deployment and environment status
- Code quality and technical debt analysis
- Team productivity and workflow metrics
- Automated insights and recommendations

**Output**: Comprehensive dashboard with actionable insights

---

### create_general_task

**Purpose**: Creates a new general task in `.simone/04_GENERAL_TASKS/` following project documentation standards.

**Usage**:
```
/project:simone:create_general_task [task_description]
```

**Arguments**:
- `task_description` - Description or title of the task to create

**Process**:
1. Generates sequential task ID (T###)
2. Loads project context and requirements
3. Verifies no duplicate tasks exist
4. Researches codebase for implementation context
5. Creates task file using standard template
6. Adds technical guidance and references
7. Updates project manifest
8. Validates architectural alignment

**Output**: Structured task file ready for implementation

---

### create_sprint_tasks

**Purpose**: Create tasks specifically associated with a sprint.

**Usage**:
```
/project:simone:create_sprint_tasks [sprint_id] [task_description]
```

**Arguments**:
- `sprint_id` - Target sprint identifier
- `task_description` - Description of the sprint task

**Features**:
- Associates tasks with specific sprints
- Manages sprint capacity and velocity
- Creates sprint-specific task IDs (T##_S##)
- Integrates with sprint planning and tracking

---

### create_bug

**Purpose**: Create comprehensive bug reports with tracking, task generation, and GitHub integration.

**Usage**:
```
/project:simone:create_bug [bug_description]
```

**Arguments**:
- `bug_description` - Description of the bug to report

**Enhanced Workflow** (NEW in v2.0.6):
1. **Bug Analysis**: Parse arguments and research codebase impact
2. **Comprehensive Documentation**: Create detailed bug report with technical analysis
3. **Task Generation**: Automatically create associated fix tasks
4. **GitHub Integration**: Create GitHub issue with proper cross-referencing
5. **Project Tracking**: Update manifest and establish traceability

**New GitHub Integration Features**:
- **Automatic Issue Creation**: Uses GitHub CLI to create issues with template
- **Cross-Referencing**: Links local bug reports to GitHub issues
- **Label Management**: Applies severity and component labels automatically
- **Bidirectional Tracking**: Updates both local and GitHub issue status

**Process**:
1. Creates detailed bug report with metadata and technical analysis
2. Assigns severity and priority levels based on impact assessment
3. Sets up reproduction steps and environment information
4. Links to relevant code sections with specific file references
5. **NEW**: Creates GitHub issue with comprehensive template
6. **NEW**: Establishes bidirectional linking between local and GitHub
7. Creates associated fix task with cross-references
8. Updates project tracking with GitHub issue information

**Output Includes**:
- Local bug report in `.simone/06_BUGS/BUG###_Title.md`
- Associated fix task in appropriate sprint or general tasks
- GitHub issue with proper labeling and cross-references
- Updated project manifest with GitHub issue links

---

### start_task

> ⚠️ **DEPRECATED**: This command has been superseded by `do_task` and `do_task_auto` which provide complete task execution workflows. This functionality is maintained for backward compatibility but will be removed in v3.0.0.
>
> **Migration**: Use `do_task` for guided task execution or `do_task_auto` for automated workflows.

**Purpose**: Creates a Git branch for a task and sets up the development environment.

**Usage**:
```
/project:simone:start_task <task_id>
```

**Arguments**:
- `task_id` - Task identifier (T###, T##_S##, or BUG###)

**Process**:
1. Validates task exists and is available
2. Checks Git status and ensures clean working directory
3. Creates appropriately named feature branch
4. Updates task metadata with branch information
5. Sets up development environment
6. Provides next steps guidance

**Branch Naming**:
- Sprint tasks: `task/T##_S##_title`
- General tasks: `task/T###_title`
- Bug fixes: `bug/BUG###_title` or `hotfix/BUG###_title`

---

### do_task

**Purpose**: Execute complete task implementation with guided approval workflow for commits and PR creation.

**Usage**:
```
/project:simone:do_task <task_id>
```

**Arguments**:
- `task_id` - Task identifier to implement (e.g., T01-S02, T003, BUG001)

**Complete Workflow**:
1. **Implementation**: Full task execution following requirements
2. **Quality Review**: Pre-commit assessment and validation
3. **Technical Debt Assessment**: Automatic identification and logging of technical debt
4. **Code Review**: Automated code quality and security checks
5. **Approval Gates**: User-controlled commit and PR creation
6. **Integration**: Automatic Git workflow with user approval

**New Approval Gate Features**:
- **Commit Approval**: Review changes and approve commit with custom message
- **PR Approval**: Review PR details and approve creation with team assignment
- **User Control**: Modify, skip, or abort at any checkpoint
- **Auto-execution**: Commands run automatically after user approval

**Implementation Process**:
1. Create and switch to task branch
2. Execute task work with progress tracking
3. Implementation quality review and validation
4. **NEW**: Technical debt assessment and logging
5. Automated code review with parallel subagents
6. **NEW**: Commit approval gate with change preview
7. **NEW**: Auto-commit execution with task reference
8. **NEW**: PR approval gate with team assignment
9. **NEW**: Auto-PR creation with proper linking
10. **NEW**: Task status update to "review" state

**Quality Features**:
- Comprehensive acceptance criteria validation
- Automated testing and code quality checks
- Technical debt identification and tracking
- Documentation updates and verification
- Security and performance impact assessment
- Full audit trail and progress tracking

**Integration Benefits**:
- **Complete Workflow**: End-to-end task completion with Git integration
- **Safety First**: User approval required for all commits and PRs
- **Team Ready**: PRs created with proper reviewers and documentation
- **Traceability**: Full linking between tasks, commits, and PRs

---

### do_task_auto

**Purpose**: Execute complete task implementation with comprehensive automation, minimal human intervention, and intelligent quality validation.

**Usage**:
```
/project:simone:do_task_auto <task_id> [persona_flags] [automation_flags]
```

**Arguments**:
- `task_id` - Task identifier to implement (e.g., T01-S02, T003, BUG001)

**Persona Flags** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect` - System design and architecture expertise
- `--persona-security` - Security analysis and OWASP compliance  
- `--persona-frontend` - Frontend development and UX optimization
- `--persona-backend` - Backend systems and API development
- `--persona-analyzer` - Code analysis and metrics evaluation
- `--persona-mentor` - Guidance and best practices coaching
- `--persona-refactorer` - Code optimization and maintainability
- `--persona-performance` - Performance optimization and scalability
- `--persona-qa` - Quality assurance and testing strategies

**Automation Flags**:
- `--introspect` - Show transparent AI reasoning with 🤔 Thinking and 🎯 Decision indicators
- `--uc` - Use UltraCompressed mode for 70% token reduction
- `--consensus` - Multi-model consensus gathering for critical decisions
- `--think-deep` - Extended reasoning for complex problems
- `--bypass-approval` - Skip human approval gates for routine tasks
- `--quality-strict` - Enforce strictest quality standards

**Comprehensive Automated Workflow (12 Steps)**:
1. **Automation Readiness Assessment** - Evaluate task complexity, risk level, and automation confidence
2. **Task Validation** - Comprehensive dependency and requirement validation
3. **Persona-Driven Analysis** - Multi-domain expert analysis with automatic persona activation
4. **Architectural Compliance** - Validate dependencies and design alignment
5. **Automated Branch Management** - Intelligent branch creation with validation
6. **Progress Tracking Setup** - Real-time automation metadata and progress tracking
7. **Continuous Implementation** - Automated implementation with real-time quality monitoring
8. **Technical Debt Management** - Automated debt assessment, categorization, and resolution
9. **Comprehensive Code Review** - Multi-persona automated code review with issue resolution
10. **Auto-Issue Resolution** - Intelligent resolution of routine issues with validation
11. **Validated Commit** - Automated commit with comprehensive quality validation
12. **PR Preparation** - Complete preparation for automated PR creation

**Automation Confidence Scoring**:
```
Score = (Test Coverage + Domain Familiarity) - (Task Complexity + Risk Level)
• Score ≥10: Full automation with bypass approval
• Score 5-9: Standard automation with quality gates  
• Score 0-4: Cautious automation with checkpoints
• Score <0: Manual execution recommended
```

**Quality Gate Pipeline**:
- **Code Quality**: Linting, complexity analysis, maintainability assessment
- **Security Validation**: Vulnerability scanning, OWASP compliance, secret detection
- **Performance Testing**: Benchmark validation, regression analysis, optimization
- **Test Coverage**: Comprehensive test execution with coverage validation
- **Documentation**: Automatic documentation updates and validation

**Key Features**:
- **Intelligent Persona Activation**: Automatically activates relevant domain expertise
- **Continuous Quality Validation**: Real-time monitoring with automated issue resolution
- **Technical Debt Integration**: Automatic identification, logging, and resolution
- **MCP Enhanced**: Sequential Thinking, Serena, Context7, and Work History integration
- **Risk Assessment**: Comprehensive risk analysis with mitigation strategies
- **Human Handoff**: Seamless transition to human review with complete context

**Benefits**:
- **Streamlined task completion** with automated steps
- **Quality gate compliance** through validation automation
- **Consistent quality standards** across all implementations
- **Comprehensive validation** checklist automation
- **Human focus** on strategic decisions rather than routine validation

**Integration with Standard Workflow**:
- Maintains full backward compatibility with `do_task`
- Seamlessly integrates with existing Simone project structure
- Automatically updates all project tracking and documentation
- Prepares for automated PR creation with `create_pr_auto`

---

### update_task_status

**Purpose**: Update the status and progress of tasks with comprehensive hierarchical completion tracking.

**Usage**:
```
/project:simone:update_task_status <task_id> <new_status> [effort_hours] [reason]
```

**Arguments**:
- `task_id` - Task identifier
- `new_status` - pending | in_progress | completed | blocked | cancelled
- `effort_hours` (optional) - Actual effort spent on task
- `reason` (optional) - Reason for status change

**Enhanced Features** (NEW in v3.0.0):
- **Completion Validation**: Prevents marking as completed without meeting acceptance criteria
- **Hierarchical Checking**: Automatically checks sprint/milestone/project completion
- **Atomic Updates**: Transaction-safe metadata updates with rollback capability
- **Progress Propagation**: Updates sprint and milestone progress percentages
- **Cross-Reference Sync**: Maintains consistency across all tracking systems

**Workflow**:
1. Validates completion requirements (if marking as completed)
2. Updates task file metadata with atomic transaction
3. Synchronizes project manifest
4. Updates sprint meta files
5. Checks for sprint completion (if task completed)
6. Checks for milestone completion (if sprint completed)
7. Checks for project completion (if milestone completed)
8. Generates hierarchical completion report

---

### sync_metadata

**Purpose**: Synchronize completion status across the entire project hierarchy and fix metadata inconsistencies.

**Usage**:
```
/project:simone:sync_metadata [--dashboard] [--fix-inconsistencies] [--validate-only]
```

**Arguments**:
- `--dashboard` - Show completion status dashboard after sync
- `--fix-inconsistencies` - Automatically fix detected inconsistencies
- `--validate-only` - Only validate without making changes

**Core Functionality**:
- **Hierarchical Validation**: Ensures completion status is consistent across task → sprint → milestone → project levels
- **Completion Requirements**: Validates that completed tasks meet all acceptance criteria
- **Progress Synchronization**: Updates progress percentages at all hierarchy levels
- **Inconsistency Detection**: Identifies and optionally repairs metadata inconsistencies
- **Status Propagation**: Automatically marks sprints/milestones/project as completed when appropriate

**When to Use**:
- **Weekly maintenance**: Recommended weekly sync to ensure consistency
- **After bulk updates**: When multiple tasks have been updated outside normal workflow
- **Project health checks**: Before important milestones or reviews
- **Inconsistency resolution**: When status appears incorrect across hierarchy
- **Progress reporting**: For accurate project completion dashboards

**Output Examples**:
```
📊 Project progress: 75% (3/4 milestones completed)
🏃 Sprint progress: 85% (17/20 sprints completed)
📋 Task progress: 89% (156/175 tasks completed)

🎉 Milestone M03 completed - all sprints finished!
🔍 Checking project completion...
```

**Integration**:
- Called automatically by `do_task_auto` on task completion
- Used by `update_task_status` for hierarchical checking
- Referenced by `status` command for consistency reporting
- Supports project completion detection and reporting

---

### create_milestone

**Purpose**: AI-powered milestone generation from natural language descriptions using intelligent template population and scope analysis.

**Usage**:
```
/project:simone:create_milestone "<milestone description>"
```

**Arguments**:
- `milestone description` - Natural language description of the milestone to create

**Examples**:
```bash
# Basic authentication milestone
/project:simone:create_milestone "Implement user authentication system with JWT tokens, MFA support, and social login integration"

# E-commerce feature milestone  
/project:simone:create_milestone "Build comprehensive product catalog with advanced search, real-time inventory tracking, recommendation engine, and admin management tools"

# API development milestone
/project:simone:create_milestone "Create RESTful API v2 with GraphQL support, rate limiting, comprehensive documentation, and developer portal"
```

**AI Features**:
- **Natural Language Processing**: Converts human descriptions into structured milestone metadata
- **Domain Intelligence**: Built-in knowledge for authentication, e-commerce, APIs, and data processing
- **Automated Planning**: AI-generated sprint breakdown with dependency analysis
- **Risk Assessment**: Comprehensive risk identification with mitigation strategies

**Generated Content**:
- Comprehensive YAML frontmatter with 30+ metadata fields
- Executive summary and milestone vision
- Business objectives with measurable KPIs
- Feature breakdown with MoSCoW prioritization
- Sprint planning with timeline estimation
- Risk analysis with mitigation strategies
- Technical architecture considerations

**Process**:
1. Parse and validate milestone prompt
2. Analyze project context and existing milestones
3. Generate milestone metadata using AI analysis
4. Create intelligent scope and feature breakdown
5. Generate sprint planning and timeline
6. Assess risks and dependencies automatically
7. Create milestone directory structure
8. Populate milestone meta file with generated content
9. Update project manifest with new milestone
10. Validate and review generated milestone

**Integration**:
- Automatic project manifest updates
- Standard Simone directory structure creation
- Full template system integration
- Seamless workflow with existing commands

**Follow-up Commands**:
```bash
# Generate sprint structure
/project:simone:create_sprints_from_milestone M##_Milestone_Name

# Create initial tasks
/project:simone:create_sprint_tasks S01_M##

# Review milestone
/project:simone:project_review --milestone M##
```

---

### create_sprints_from_milestone

**Purpose**: Generate sprint structure and tasks from milestone definitions.

**Usage**:
```
/project:simone:create_sprints_from_milestone <milestone_id>
```

**Arguments**:
- `milestone_id` - Milestone to break down into sprints

**Process**:
1. Analyzes milestone requirements and scope
2. Creates optimal sprint breakdown
3. Distributes tasks across sprints
4. Sets up sprint planning documentation
5. Establishes dependencies and timeline

---

### commit

**Purpose**: Create structured commits with proper task references and documentation.

**Usage**:
```
/project:simone:commit <task_id> [commit_message]
```

**Arguments**:
- `task_id` - Associated task identifier
- `commit_message` (optional) - Custom commit message

**Features**:
- Structured commit message format
- Automatic task reference linking
- Change validation and quality checks
- Documentation updates
- Integration with task tracking

---

### create_pr

**Purpose**: Create comprehensive pull requests with proper documentation and reviews.

**Usage**:
```
/project:simone:create_pr <task_id> [target_branch]
```

**Arguments**:
- `task_id` - Task identifier for the PR
- `target_branch` (optional) - Target branch (defaults to main)

**Features**:
- Comprehensive PR description generation
- Automated testing verification
- Documentation and change summaries
- Review assignment
- Integration with task completion

---

### create_pr_auto

**Purpose**: Create comprehensive pull requests with AI-generated content, intelligent reviewer assignment, and automated quality context.

**Usage**:
```
/project:simone:create_pr_auto <task_id> [persona_flags] [automation_flags]
```

**Arguments**:
- `task_id` - Task identifier for the PR

**Persona Flags**:
- `--persona-architect` - Architecture and design review focus
- `--persona-security` - Security implications and compliance review
- `--persona-frontend` - UI/UX and frontend impact analysis
- `--persona-backend` - API and backend system review
- `--persona-analyzer` - Code quality and metrics analysis
- `--persona-mentor` - Best practices and educational review
- `--persona-refactorer` - Code optimization and maintainability
- `--persona-performance` - Performance impact and optimization
- `--persona-qa` - Quality assurance and testing review

**Automation Flags**:
- `--introspect` - Show transparent reasoning with 🤔 Thinking and 🎯 Decision indicators
- `--auto-assign` - Automatically assign reviewers based on code ownership and expertise
- `--comprehensive` - Generate maximum detail for complex changes
- `--ready-to-merge` - Mark PR as ready for immediate merge (use with caution)
- `--draft` - Create as draft PR for early feedback

**Comprehensive Automated Workflow (10 Steps)**:
1. **PR Prerequisites Validation** - Git state, CI/CD status, automation readiness assessment
2. **Change Analysis** - Comprehensive commit history analysis and impact assessment
3. **AI-Powered Content Generation** - Intelligent PR title and description generation
4. **Reviewer Assignment** - Code ownership analysis and expertise-based assignment
5. **Automated Labeling** - Dynamic label assignment based on change analysis
6. **Quality Summary** - Comprehensive QA results and validation summaries
7. **Risk Assessment** - Multi-dimensional risk analysis and review focus recommendations
8. **Testing Strategy** - Comprehensive testing and deployment guidance generation
9. **Automated PR Creation** - Full automation context integration and execution
10. **Stakeholder Notification** - Comprehensive tracking updates and notifications

**AI-Generated PR Content**:
- **Smart Title Generation**: Conventional Commits format with task reference
- **Comprehensive Description**: Multi-section PR description with automation context
- **Change Analysis**: Detailed file changes, impact assessment, and categorization
- **Quality Metrics**: Test coverage, security scores, performance impact
- **Risk Assessment**: Multi-dimensional risk analysis with mitigation strategies
- **Review Guidance**: Specific focus areas and recommendations for reviewers

**Intelligent Reviewer Assignment**:
- **Code Ownership Analysis**: Automatic detection of primary and secondary owners
- **Expertise Mapping**: Domain expert identification based on change type
- **Load Balancing**: Review workload distribution and availability consideration
- **Compliance Requirements**: Automatic assignment for security/compliance sensitive changes

**Automated Quality Context**:
```markdown
## 🤖 Automated Quality Context
### Quality Gate Results: ✅ All Passed
### Automation Confidence: 8.5/10
### Risk Assessment: Low
### Review Focus: Business logic validation, UX considerations
### Testing Strategy: Manual UX testing recommended
### Deployment: Standard deployment process approved
```

**Project Management Integration**:
- **GitHub Projects**: Automatic project board updates and status changes
- **Milestone Assignment**: Links to appropriate milestones and progress tracking
- **Issue Linking**: Automatic cross-referencing with related issues and tasks
- **Sprint Tracking**: Integration with sprint progress and completion metrics

**Benefits**:
- **Comprehensive Context**: Rich PR descriptions with all necessary information
- **Intelligent Assignment**: Optimal reviewer selection based on expertise and availability
- **Quality Transparency**: Complete quality validation results and automation context
- **Review Efficiency**: Clear focus areas allow reviewers to concentrate on strategic decisions
- **Process Integration**: Seamless integration with project management and tracking systems

**Human Review Optimization**:
- **Strategic Focus**: Reviewers focus on business logic and architectural decisions
- **Clear Guidance**: Specific recommendations for what requires human judgment
- **Risk Transparency**: Complete risk assessment with mitigation strategies
- **Quality Assurance**: All technical quality concerns pre-validated and documented

---

### review_pr

**Purpose**: Conduct thorough pull request reviews with quality checks.

**Usage**:
```
/project:simone:review_pr <pr_id>
```

**Arguments**:
- `pr_id` - Pull request identifier or URL

**Features**:
- Comprehensive code quality analysis
- Architecture and design review
- Security and performance assessment
- Documentation review
- Testing coverage analysis

---

### merge

**Purpose**: Merge code with comprehensive quality checks and documentation.

**Usage**:
```
/project:simone:merge <pr_id> [merge_strategy]
```

**Arguments**:
- `pr_id` - Pull request to merge
- `merge_strategy` - merge | squash | rebase

**Quality Checks**:
- All tests passing
- Code review approval
- Documentation updated
- No merge conflicts
- Security scans clean

---

### test

**Purpose**: Execute comprehensive testing workflows with reporting.

**Usage**:
```
/project:simone:test [test_scope] [test_type]
```

**Arguments**:
- `test_scope` - all | unit | integration | e2e | specific_module
- `test_type` - run | coverage | performance | security

**Features**:
- Multi-level testing execution
- Coverage analysis and reporting
- Performance benchmarking
- Security testing integration
- Quality metrics generation

---

### log_technical_debt

**Purpose**: Document and track technical debt items with comprehensive impact analysis and resolution planning.

**Usage**:
```
/project:simone:log_technical_debt [debt_description] [--persona-flags]
```

**Arguments**:
- `debt_description` (optional) - Natural language description of the technical debt
- `--persona-flags` - Domain expertise flags for enhanced analysis

**Persona Integration**:
```bash
# Security-focused debt analysis
/project:simone:log_technical_debt "weak input validation" --persona-security

# Architecture debt with transparency
/project:simone:log_technical_debt "tight coupling between services" --persona-architect --introspect

# Code quality analysis with multiple domains
/project:simone:log_technical_debt "duplicate validation logic" --persona-analyzer --persona-refactorer
```

**Available Personas**:
- `--persona-architect`: Architecture debt analysis and system design impact
- `--persona-security`: Security debt identification and risk assessment  
- `--persona-frontend`: Frontend-specific debt categorization and UX impact
- `--persona-backend`: Backend performance and API design debt analysis
- `--persona-analyzer`: Code quality metrics and maintainability assessment
- `--persona-performance`: Performance bottlenecks and optimization debt
- `--persona-qa`: Testing debt and quality assurance gaps

**Comprehensive Process**:
1. **Parse debt description** and analyze context from current work
2. **Categorize and assess severity** using domain expertise
3. **Analyze business and technical impact** with quantified risk scoring
4. **Generate unique debt ID** (TD_###) and create file structure
5. **Create comprehensive documentation** using technical debt template
6. **Update debt registry** and establish cross-references
7. **Integrate with project tracking** and health metrics

**Debt Categories**:
- **Code Quality**: Duplication, complexity, naming, maintainability
- **Architecture**: Design violations, coupling issues, missing abstractions
- **Security**: Authentication gaps, validation flaws, data exposure
- **Performance**: Inefficient algorithms, resource leaks, optimization opportunities
- **Documentation**: Missing or outdated documentation, unclear implementations
- **Testing**: Coverage gaps, flaky tests, missing scenarios

**Severity Levels**:
- **Critical**: Security vulnerabilities, production blockers, data corruption risks
- **High**: Performance degradation, significant maintenance burden
- **Medium**: Code maintainability issues, future scalability concerns  
- **Low**: Code clarity improvements, minor convention violations

**Risk Assessment**:
- **Risk Scoring**: 1-25 scale (Likelihood × Impact)
- **Business Impact**: Development velocity, maintenance cost, customer impact
- **Technical Impact**: System reliability, performance, architecture integrity
- **Resolution Planning**: Effort estimation, timeline, implementation approach

**Generated Outputs**:
- Technical debt item in `.simone/07_TECHNICAL_DEBT/ACTIVE/TD_###_description.md`
- Updated debt registry in `.simone/07_TECHNICAL_DEBT/DEBT_REGISTRY.md`
- Project health metrics updated in `.simone/00_PROJECT_MANIFEST.md`
- Cross-references to source context (tasks, code reviews, etc.)

**Integration Features**:
- **Task Workflow**: Seamlessly integrates with task execution and code review
- **Sprint Planning**: Debt metrics inform capacity and priority planning
- **Project Reviews**: Debt health included in comprehensive project assessments
- **Quality Gates**: Critical debt items can block milestone progression

---

### code_review

**Purpose**: Perform detailed code reviews with quality analysis.

**Usage**:
```
/project:simone:code_review [scope] [focus_area]
```

**Arguments**:
- `scope` - current_changes | full_codebase | specific_files
- `focus_area` - architecture | security | performance | maintainability

**Analysis Areas**:
- Code quality and standards
- Architecture and design patterns
- Security vulnerabilities
- Performance implications
- Technical debt identification
- Maintainability assessment

---

### project_review

**Purpose**: Conduct comprehensive project health and progress reviews.

**Usage**:
```
/project:simone:project_review [review_type] [period]
```

**Arguments**:
- `review_type` - health | retrospective | planning | stakeholder
- `period` - sprint | milestone | quarterly | annual

**Review Areas**:
- Project health and metrics
- Technical debt accumulation and management
- Goal achievement and progress
- Risk assessment and mitigation
- Team performance and capacity
- Process improvements

---

### fix_bug

**Purpose**: Implement comprehensive bug fixes with validation.

**Usage**:
```
/project:simone:fix_bug <bug_id>
```

**Arguments**:
- `bug_id` - Bug identifier to fix

**Process**:
1. Analyzes bug report and reproduction steps
2. Identifies root cause and impact
3. Implements fix with minimal side effects
4. Creates comprehensive test coverage
5. Updates documentation and tracking

---

### sync

**Purpose**: Synchronize project state, dependencies, and cross-references.

**Usage**:
```
/project:simone:sync [sync_scope]
```

**Arguments**:
- `sync_scope` - all | tasks | sprints | documentation | dependencies

**Synchronization**:
- Task dependencies and relationships
- Sprint and milestone progress
- Documentation cross-references
- Project manifest updates
- External system integration

---

### prime

**Purpose**: Initialize Claude context with comprehensive project information.

**Usage**:
```
/project:simone:prime [context_scope]
```

**Arguments**:
- `context_scope` - full | current | specific_area

**Context Loading**:
- Project architecture and constraints
- Current sprint and milestone status
- Active tasks and priorities
- Team context and capacity
- Technical standards and patterns

---

### version

**Purpose**: Manage project versioning, releases, and change tracking.

**Usage**:
```
/project:simone:version [action] [version_number]
```

**Arguments**:
- `action` - current | bump | tag | release
- `version_number` - Semantic version (if creating/tagging)

**Features**:
- Semantic versioning management
- Release documentation generation
- Change log compilation
- Tag creation and management
- Release coordination

---

### testing_review

**Purpose**: Review testing coverage, quality, and effectiveness.

**Usage**:
```
/project:simone:testing_review [focus_area]
```

**Arguments**:
- `focus_area` - coverage | quality | performance | automation

**Review Areas**:
- Test coverage analysis and gaps
- Test quality and effectiveness
- Performance testing adequacy
- Automation opportunities
- Testing strategy alignment

---

### discuss_review

**Purpose**: Facilitate structured discussions around code and project reviews.

**Usage**:
```
/project:simone:discuss_review <review_id> [discussion_focus]
```

**Arguments**:
- `review_id` - Review identifier or reference
- `discussion_focus` - technical | process | strategic | team

**Features**:
- Structured discussion facilitation
- Decision documentation
- Action item generation
- Consensus building
- Knowledge sharing

---

### yolo

**Purpose**: Quick development actions for rapid prototyping and experimentation.

**Usage**:
```
/project:simone:yolo [action] [scope]
```

**Arguments**:
- `action` - prototype | experiment | quick_fix | explore
- `scope` - current_task | new_feature | investigation

**⚠️ **Warning**: Use with caution - bypasses some quality checks for speed

**Use Cases**:
- Rapid prototyping
- Proof of concept development
- Quick experimentation
- Emergency hot fixes
- Exploratory development

---

## Command Integration

### MCP Server Integration

Many commands integrate with Model Context Protocol servers for enhanced functionality:

- **Sequential Thinking**: Structured approach to complex tasks
- **Work History**: Learning from past task patterns and outcomes
- **Context7**: Maintaining project context and relationships
- **Serena**: Enhanced project analysis and development assistance

### Cross-Command Workflows

Commands are designed to work together in common workflows:

**Standard Task Workflow (Manual)**:
1. `create_general_task` - Create task
2. `start_task` - Set up development environment  
3. `do_task` - Implement solution
4. `commit` - Commit changes
5. `create_pr` - Create pull request
6. `review_pr` - Conduct review
7. `merge` - Merge to main branch

**🤖 Automated Task Workflow (NEW)**:
1. `create_general_task` - Create task (manual)
2. `do_task_auto` - **Automated implementation with comprehensive validation**
   - Automatic branch creation and management
   - Continuous quality validation during implementation
   - Automated technical debt assessment and resolution
   - Comprehensive code review with auto-issue resolution
   - Validated automated commit
3. `create_pr_auto` - **Automated PR creation with rich context**
   - AI-generated comprehensive PR descriptions
   - Intelligent reviewer assignment
   - Automated labeling and project integration
   - Quality metrics and risk assessment
4. **Human Review** - Focus on business logic and strategic decisions
5. `merge` - Merge to main branch

**Quality Gate Integration**:
- `quality_gate_validator` - Comprehensive validation pipeline (automated)
- **CI/CD Pipeline** - Automated quality validation in GitHub Actions
- **Continuous Monitoring** - Real-time quality and performance tracking

**Sprint Planning → Execution → Review**:
1. `create_sprints_from_milestone` - Plan sprint
2. `create_sprint_tasks` - Create sprint tasks
3. `status` - Monitor progress
4. `project_review` - Retrospective analysis

**Helper Commands Workflows**:

**Diagnostic & Problem Resolution**:
1. `troubleshoot` - Comprehensive project diagnostic
2. `investigate` - Targeted issue investigation
3. `analyze` - Deep code and system analysis
4. `create_milestone` or `create_general_task` - Create remediation items
5. `log_technical_debt` - Track identified technical debt

**Feature Planning & Research**:
1. `research` - Investigate existing patterns and best practices
2. `plan` - Strategic feature and implementation planning
3. `create_milestone` - Generate structured milestones (automatic)
4. `create_sprints_from_milestone` - Break down into sprints
5. `create_sprint_tasks` - Create specific implementation tasks

**Quality Assurance & Improvement**:
1. `analyze` - Comprehensive quality analysis
2. `troubleshoot` - System health diagnostic
3. `log_technical_debt` - Document improvement opportunities
4. `plan` - Create improvement initiative plans
5. `create_general_task` - Implement specific improvements

**Safety & Emergency Response Workflow**:
1. `safety_check` - Pre-operation validation
2. `safety_monitor --start` - Begin monitoring
3. Autonomous operations (`yolo`, `do_task`)
4. `user_intervention` - Manual control when needed
5. `emergency_stop` - Emergency halt if required
6. `rollback` - Safe recovery if problems occur

### Quality Assurance Integration

Quality is built into every command:
- Automated validation and checks
- Documentation requirements
- Testing integration
- Code quality analysis
- Technical debt tracking
- Architecture compliance

## Best Practices

### Command Usage
1. **Start with `prime`** to load project context
2. **Use `status`** regularly to monitor progress
3. **Follow task workflows** from creation to completion
4. **Leverage quality commands** for code review and testing
5. **Synchronize regularly** with `sync` command

### Project Workflow
1. Maintain clean Git state before starting tasks
2. Use proper branch naming conventions
3. Reference task IDs in all related work
4. Update documentation as you progress
5. Run quality checks before merging

### Documentation Integration
- Commands automatically update project documentation
- All actions are logged and tracked
- Cross-references are maintained
- Architecture compliance is validated

## Helper Commands

### troubleshoot

**Purpose**: Comprehensive project diagnostic and issue resolution with systematic analysis and milestone integration.

**Usage**: 
```
/project:simone:troubleshoot [scope_flags] [persona_flags] [advanced_flags]
```

**Scope Flags**:
- `--scope-full` - Complete project health assessment (default)
- `--scope-performance` - Focus on performance bottlenecks
- `--scope-security` - Security vulnerabilities and compliance
- `--scope-quality` - Code quality and technical debt
- `--scope-infrastructure` - Environment and deployment issues
- `--scope-workflow` - Development process bottlenecks

**Available Personas**:
- `--persona-architect` - System architecture diagnostics
- `--persona-security` - Security vulnerability assessment
- `--persona-analyzer` - Code quality metrics and performance analysis
- `--persona-qa` - Testing infrastructure diagnostics
- `--persona-devops` - Infrastructure and deployment diagnostics
- `--persona-performance` - Performance bottlenecks analysis

**Advanced Flags**:
- `--introspect` - Show transparent diagnostic reasoning process
- `--consensus` - Multi-model consensus on issue prioritization
- `--think-deep` - Extended troubleshooting analysis
- `--compressed` - Output concise diagnostic summary only

**Process** (12 TODO Items):
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

**MCP Integration**: Sequential Thinking, Work History, Context7, and Serena for enhanced diagnostic capabilities

**Output**: 
- Diagnostic report in `.simone/10_STATE_OF_PROJECT/diagnostic_report_[timestamp].md`
- Suggested milestones for major improvement initiatives
- Immediate action items in task format

**Integration**: Works with `create_milestone`, `create_general_task`, `log_technical_debt`, and `safety_check`

---

### research

**Purpose**: Comprehensive codebase investigation and analysis for understanding implementation patterns, dependencies, and best practices.

**Usage**:
```
/project:simone:research [target_flags] [persona_flags] [advanced_flags]
```

**Research Target Flags**:
- `--target-feature` - Research specific feature implementation
- `--target-pattern` - Investigate code patterns and architectural decisions
- `--target-dependency` - Analyze dependency usage and integration
- `--target-technology` - Research technology adoption and implementation

**Available Personas**:
- `--persona-architect` - System architecture research and design patterns
- `--persona-analyzer` - Code analysis and pattern recognition
- `--persona-security` - Security research and vulnerability analysis
- `--persona-performance` - Performance research and optimization strategies

**Advanced Flags**:
- `--introspect` - Show transparent research reasoning process
- `--think-deep` - Extended investigation with comprehensive analysis
- `--compressed` - Output concise research summary only

**Process** (8 TODO Items):
1. Parse research query and define investigation scope
2. Execute comprehensive codebase scanning and pattern identification
3. Analyze implementation approaches and architectural decisions
4. Investigate dependencies, libraries, and technology stack
5. Research best practices and industry standards comparison
6. Identify knowledge gaps and learning opportunities
7. Generate research findings and recommendations
8. Create actionable research report with next steps

**MCP Integration**: Sequential Thinking, Context7 for pattern recognition and industry knowledge integration

**Output**: Research findings in `.simone/10_STATE_OF_PROJECT/research_[topic]_[timestamp].md`

**Use Cases**: 
- Understanding existing codebase patterns
- Technology adoption research
- Best practices comparison
- Dependency analysis and optimization

---

### plan

**Purpose**: Strategic feature and implementation planning with comprehensive architecture design and milestone breakdown.

**Usage**:
```
/project:simone:plan [type_flags] [persona_flags] [advanced_flags]
```

**Planning Type Flags**:
- `--type-feature` - Plan new feature implementation (default)
- `--type-refactor` - Plan refactoring and improvement initiatives
- `--type-migration` - Plan technology or architecture migration
- `--type-integration` - Plan system integration or API development

**Available Personas**:
- `--persona-architect` - System architecture and design planning
- `--persona-pm` - Project management and milestone planning
- `--persona-qa` - Quality assurance and testing strategy planning
- `--persona-security` - Security implementation planning
- `--persona-performance` - Performance optimization planning

**Advanced Flags**:
- `--introspect` - Show transparent planning reasoning process
- `--consensus` - Multi-model consensus on planning approach
- `--think-deep` - Extended planning with comprehensive analysis

**Process** (10 TODO Items):
1. Parse planning requirements and define project scope
2. Analyze existing codebase and architectural constraints
3. Research technical requirements and implementation approaches
4. Design high-level architecture and component structure
5. Break down implementation into manageable milestones
6. Identify dependencies, risks, and potential blockers
7. Estimate effort and timeline for each milestone
8. Create detailed task breakdown with acceptance criteria
9. Generate comprehensive implementation plan
10. Output structured milestones and tasks using templates

**MCP Integration**: Sequential Thinking for systematic planning, Context7 for system understanding, Work History for estimation, Serena for synthesis

**Output**: 
- Implementation plan in `.simone/10_STATE_OF_PROJECT/implementation_plan_[feature]_[timestamp].md`
- Generated milestones in `.simone/02_MILESTONES/`
- Generated tasks in `.simone/04_TASKS/`

**Integration**: Automatically creates milestones and tasks using `milestone_meta_template.md` and `task_template.md`

---

### analyze

**Purpose**: Deep code and system analysis with comprehensive quality, security, performance, and architecture assessment.

**Usage**:
```
/project:simone:analyze [type_flags] [persona_flags] [advanced_flags]
```

**Analysis Type Flags**:
- `--type-code` - Analyze code quality, patterns, and structure (default)
- `--type-performance` - Analyze performance bottlenecks and optimization opportunities
- `--type-security` - Analyze security vulnerabilities and compliance
- `--type-architecture` - Analyze system architecture and design patterns
- `--type-dependencies` - Analyze dependency relationships and management

**Available Personas**:
- `--persona-analyzer` - Code analysis and metrics evaluation expertise
- `--persona-architect` - System architecture analysis
- `--persona-security` - Security analysis and vulnerability assessment
- `--persona-performance` - Performance analysis and optimization
- `--persona-qa` - Quality analysis and testing assessment

**Advanced Flags**:
- `--introspect` - Show transparent analysis reasoning process
- `--consensus` - Multi-model consensus on analysis findings
- `--think-deep` - Extended analysis with comprehensive investigation

**Process** (9 TODO Items):
1. Parse analysis target and define analysis scope
2. Execute comprehensive code scanning and metric collection
3. Analyze code quality, complexity, and maintainability
4. Assess architectural patterns and design quality
5. Evaluate performance characteristics and bottlenecks
6. Conduct security analysis and vulnerability assessment
7. Analyze dependency relationships and technical debt
8. Generate analysis findings with actionable recommendations
9. Create structured analysis report with improvement suggestions

**MCP Integration**: Sequential Thinking for systematic analysis, Context7 for architectural understanding, Work History for pattern analysis, Serena for findings synthesis

**Output**: 
- Analysis report in `.simone/10_STATE_OF_PROJECT/analysis_report_[target]_[timestamp].md`
- Improvement tasks in `.simone/04_TASKS/` for critical findings
- Technical debt items using `technical_debt_template.md`

**Integration**: Works with `log_technical_debt`, `create_general_task`, `plan`, and `troubleshoot`

---

### investigate

**Purpose**: Targeted bug and issue investigation with systematic root cause analysis and remediation planning.

**Usage**:
```
/project:simone:investigate [type_flags] [persona_flags] [advanced_flags]
```

**Investigation Type Flags**:
- `--type-bug` - Investigate specific bug reports or issues (default)
- `--type-performance` - Investigate performance degradation or bottlenecks
- `--type-security` - Investigate security incidents or vulnerabilities
- `--type-failure` - Investigate system failures or outages
- `--type-anomaly` - Investigate unusual behavior or patterns

**Available Personas**:
- `--persona-analyzer` - Code analysis and debugging expertise
- `--persona-qa` - Testing and quality assurance investigation
- `--persona-security` - Security incident investigation
- `--persona-performance` - Performance issue investigation
- `--persona-devops` - Infrastructure and deployment investigation

**Advanced Flags**:
- `--introspect` - Show transparent investigation reasoning process
- `--think-deep` - Extended investigation with comprehensive analysis
- `--compressed` - Output concise investigation summary only

**Process** (11 TODO Items):
1. Parse investigation request and define investigation scope
2. Gather initial evidence and reproduce issue if possible
3. Analyze logs, error messages, and system state
4. Trace code execution paths and identify potential causes
5. Examine recent changes and deployment history
6. Investigate environmental factors and dependencies
7. Analyze similar historical issues and patterns
8. Test hypotheses and validate root cause theories
9. Determine impact scope and affected components
10. Document findings and root cause analysis
11. Suggest remediation plan and prevention strategies

**MCP Integration**: Sequential Thinking for systematic investigation, Work History for pattern recognition and historical analysis, Context7 for code flow understanding, Serena for comprehensive documentation

**Output**: 
- Investigation report in `.simone/10_STATE_OF_PROJECT/investigation_[issue]_[timestamp].md`
- Bug report using `bug_report_template.md` if needed
- Remediation tasks in `.simone/04_TASKS/`

**Integration**: Works with `create_bug`, `fix_bug`, `create_general_task`, and `safety_check`

---

### quality_gate_validator

**Purpose**: Comprehensive validation pipeline for automated task execution with configurable quality thresholds and detailed reporting.

**Usage**:
```bash
./quality-gate-validator.sh [--task-id TASK_ID] [--strict] [--bypass-non-critical]
```

**Arguments**:
- `--task-id TASK_ID` - Associate validation with specific task
- `--strict` - Enable strict quality gates with highest standards
- `--bypass-non-critical` - Skip non-critical validations for speed

**Comprehensive Validation Pipeline**:
1. **Git State Validation** - Repository cleanliness and branch status
2. **Dependency Health** - Security audits and package currency
3. **Code Quality** - Linting, complexity, and maintainability analysis
4. **Security Assessment** - Vulnerability scanning and secret detection
5. **Test Execution** - Comprehensive test suite with coverage analysis
6. **Performance Validation** - Benchmark testing and regression analysis
7. **Documentation Review** - Documentation completeness and currency

**Quality Thresholds** (Configurable):
```yaml
quality_gates:
  test_coverage_minimum: 80%
  security_score_minimum: "A"
  performance_regression_max: "10%"
  complexity_score_max: 10
  technical_debt_max: "5 days"
```

**Security Scanning Integration**:
- **Multiple Tools**: semgrep, snyk, bandit, safety integration
- **OWASP Compliance**: Automated OWASP Top 10 validation
- **Secret Detection**: Hardcoded credentials and API key scanning
- **Dependency Audits**: NPM audit, Cargo audit, vulnerability databases

**Performance Analysis**:
- **Bundle Size Monitoring**: Track and alert on bundle size increases
- **Benchmark Validation**: Automated performance regression testing
- **Resource Usage**: Memory, CPU, and I/O impact assessment
- **Load Testing**: Integration with performance testing frameworks

**Reporting and Metrics**:
- **JSON Reports**: Structured validation results with timestamps
- **Quality Trends**: Historical quality metrics and trend analysis
- **Dashboard Integration**: Integration with quality monitoring dashboards
- **CI/CD Integration**: Seamless integration with GitHub Actions pipeline

**CI/CD Integration**:
```yaml
# .github/workflows/simone-auto-quality.yml
- name: Run Quality Gate Validation
  run: ./.simone/01_UTILS/quality-gate-validator.sh --task-id ${{ steps.extract-task.outputs.task_id }}
```

**Benefits**:
- **Comprehensive Coverage**: Multi-dimensional quality assessment
- **Configurable Standards**: Adaptable thresholds for different project needs
- **Automated Reporting**: Detailed reports with actionable insights
- **CI/CD Ready**: Seamless integration with automation pipelines
- **Trend Analysis**: Historical quality tracking and improvement measurement

---

## Safety & Emergency Response Commands

### emergency_stop

**Purpose**: Immediately halt all autonomous operations and secure the system in emergency situations.

**Usage**:
```
/project:simone:emergency_stop [--all|--task <task_id>|--process <pid>|--reason <reason>]
```

**Arguments**:
- `--all` - Stop all autonomous operations (default behavior)
- `--task <task_id>` - Stop specific task execution
- `--process <pid>` - Stop specific process by ID
- `--reason <reason>` - Provide reason for emergency stop

**Features**:
- **Immediate Stop Actions**: Kills all autonomous processes (YOLO, do_task, autonomous execution)
- **State Preservation**: Creates emergency branches and working directory snapshots
- **Emergency Logging**: Comprehensive logging of stop reason, system state, and actions taken
- **Recovery Options**: Offers immediate rollback, safe mode recovery, or manual recovery
- **Integration**: Creates emergency stop signals that other commands can check

**Use Cases**:
- Runaway autonomous operations
- Security concerns detected
- System resource exhaustion
- Manual intervention required immediately

---

### rollback

**Purpose**: Safely rollback autonomous operations when things go wrong, with comprehensive backup and recovery options.

**Usage**:
```
/project:simone:rollback [--task <task_id>|--branch <branch_name>|--emergency|--auto]
```

**Arguments**:
- `--task <task_id>` - Rollback specific task changes
- `--branch <branch_name>` - Rollback to specific branch state
- `--emergency` - Emergency rollback mode (faster, less validation)
- `--auto` - Automatic rollback without user confirmation

**Features**:
- **Scope Detection**: Auto-detects rollback scope or targets specific tasks/branches
- **Pre-Rollback Safety**: Creates backup branches and assesses rollback impact
- **User Confirmation**: Requires approval unless in auto mode
- **Recovery Options**: Restore from backup or cherry-pick specific changes
- **Integration**: Called automatically by safety systems

**Process**:
1. Analyze current state and rollback scope
2. Create backup branches for recovery
3. Present rollback plan for approval
4. Execute rollback with state preservation
5. Verify rollback success and cleanup

---

### safety_check

**Purpose**: Perform comprehensive safety checks before and during autonomous operations to prevent dangerous or problematic actions.

**Usage**:
```
/project:simone:safety_check [--safe|--balanced|--yolo]
```

**Arguments**:
- `--safe` - Maximum safety mode with strict thresholds
- `--balanced` - Balanced safety mode (default)
- `--yolo` - Minimal safety checks for rapid development

**Safety Checks**:
- **Git Status**: Clean working directory, proper branch state
- **Test Baseline**: All tests passing before autonomous operations
- **System Resources**: CPU, memory, disk space availability
- **Critical File Protection**: Prevents modification of protected files
- **Security Validation**: Checks for obvious security vulnerabilities

**Integration**:
- Called automatically by `yolo`, `do_task`, `commit`, `merge`
- Configurable thresholds based on safety mode
- Emergency stop triggers for critical conditions

---

### safety_monitor

**Purpose**: Real-time monitoring of autonomous operations with safety alerting and emergency response capabilities.

**Usage**:
```
/project:simone:safety_monitor [--start|--stop|--status|--dashboard|--alerts]
```

**Arguments**:
- `--start` - Start monitoring daemon
- `--stop` - Stop monitoring daemon
- `--status` - Show current monitoring status
- `--dashboard` - Interactive monitoring dashboard
- `--alerts` - Show recent alerts and warnings

**Monitoring Capabilities**:
- **Real-time Dashboard**: Interactive monitoring with system health metrics
- **Continuous Monitoring**: System resources, process health, Git repository status
- **Alert System**: Automatic alerting with severity levels (CRITICAL/WARNING/INFO)
- **Emergency Response**: Automatic emergency stop triggers for critical conditions
- **Performance Tracking**: Operation timing, success rates, resource usage

**Alert Conditions**:
- CPU/Memory usage above thresholds
- Git repository in inconsistent state
- Test failures during autonomous operations
- Security vulnerabilities detected
- File system errors or conflicts

---

### command-validator

> ⚠️ **DEPRECATED**: Command validation functionality has been integrated directly into the Simone framework. This utility script is no longer needed as validation is now built into automated commands and GitHub Actions.
>
> **Migration**: Remove references to command-validator.sh and rely on built-in framework validation.

**Purpose**: Provided validation hooks for command execution (now integrated into framework).

**Former Features**:
- Command execution tracking and validation
- Step completion verification  
- File modification validation
- Execution state management

**Replacement**: Validation is now handled by:
- `do_task_auto` command with built-in validation
- GitHub Actions quality gates
- Framework-native validation capabilities

---

### user_intervention

**Purpose**: Provide manual override and intervention capabilities for autonomous operations with approval workflows and safety overrides.

**Usage**:
```
/project:simone:user_intervention [--pause|--resume|--approve <task_id>|--reject <task_id>|--override <check>|--emergency]
```

**Arguments**:
- `--pause` - Pause all autonomous operations
- `--resume` - Resume paused operations
- `--approve <task_id>` - Approve specific pending task
- `--reject <task_id>` - Reject specific pending task
- `--override <check>` - Override specific safety check
- `--emergency` - Emergency intervention menu

**Intervention Features**:
- **Operation Control**: Pause/resume all autonomous operations
- **Task Approval System**: Approve or reject pending tasks with detailed reasoning
- **Safety Overrides**: Override specific safety checks with expiration timers
- **Emergency Menu**: Interactive emergency intervention with multiple options
- **Process Management**: Forcefully terminate autonomous processes if needed
- **Health Monitoring**: Comprehensive system health checks with scoring

**Safety Controls**:
- All overrides are temporary with expiration
- Comprehensive logging of all intervention actions
- User authentication for sensitive operations
- Automatic reversion to safe mode after intervention

---

## Troubleshooting

### Common Issues

**Command Not Found**:
- Ensure you're in a Simone-initialized project
- Check `.claude/commands/simone/` directory exists
- Verify Claude Code is properly configured

**Permission Errors**:
- Check file permissions in `.simone/` directory
- Ensure Git repository is properly initialized
- Verify write access to project directory

**Context Issues**:
- Run `prime` command to reload project context
- Check `.simone/00_PROJECT_MANIFEST.md` exists
- Verify project structure is complete

### Getting Help

- **Command-specific help**: Most commands provide guidance when run without arguments
- **Project status**: Use `status` command for comprehensive overview
- **Documentation**: Reference template files in `.simone/99_TEMPLATES/`
- **GitHub Issues**: [Report problems](https://github.com/steig/claude-steig/issues)

## Integration with Claude Code

The Simone Framework commands are designed specifically for Claude Code and provide:

- **Context-aware assistance**: Commands understand your project structure and history
- **Intelligent automation**: Reduces manual tasks while maintaining quality
- **Documentation-driven**: All actions align with project documentation
- **Quality-focused**: Built-in checks ensure consistent, high-quality output
- **Team-friendly**: Supports collaboration and knowledge sharing

---

## Deprecated Components

### Architecture Templates
- **`architecture_initialization_checklist.md`**: ⚠️ **DEPRECATED** - Functionality merged into `architecture_template.md`
- **Migration**: Use the unified `architecture_template.md` which includes the complete initialization checklist

### Review Commands
- **`code_review.md`**: ⚠️ **DEPRECATED** - Use `review --type-code` instead
- **`quality_review.md`**: ⚠️ **DEPRECATED** - Use `review --type-quality` instead  
- **`testing_review.md`**: ⚠️ **DEPRECATED** - Use `review --type-testing` instead
- **`discuss_review.md`**: ⚠️ **DEPRECATED** - Use `review --type-discussion` instead

### Bug Templates
- **Legacy bug templates**: ⚠️ **DEPRECATED** - Consolidated into unified bug template

### Utility Scripts
- **`quality-gate-validator.sh`**: ⚠️ **DEPRECATED** - Functionality integrated into automated workflows
- **`command-validator.sh`**: ⚠️ **DEPRECATED** - Validation now built into framework

---

For detailed implementation guides and examples, see:
- [Template System Documentation](template-system.md)
- [Workflow Documentation](../workflows/)
- [Migration Guide](../migration/deprecated-features.md) - Migration paths for deprecated components
- [Best Practices](../best-practices/)