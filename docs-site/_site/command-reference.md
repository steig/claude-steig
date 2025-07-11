# Command Reference

Complete reference for all Simone Framework commands available in Claude Code.

## Overview

The Simone Framework provides 22 specialized commands for project management, development workflow, and quality assurance. Each command is designed to work seamlessly with the `.simone/` directory structure and project documentation.

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
- [`start_task`](#start_task) - Set up task development environment
- [`do_task`](#do_task) - Execute task implementation
- [`update_task_status`](#update_task_status) - Update task progress
- [`fix_bug`](#fix_bug) - Implement bug fixes

### 🎯 Sprint & Milestone Management
- [`create_milestone`](#create_milestone) - AI-powered milestone generation from natural language
- [`create_sprints_from_milestone`](#create_sprints_from_milestone) - Generate sprints from milestones
- [`sync`](#sync) - Synchronize project state and dependencies

### 🔧 Development Workflow
- [`commit`](#commit) - Create structured commits with task references
- [`create_pr`](#create_pr) - Create pull requests with proper documentation
- [`review_pr`](#review_pr) - Conduct thorough pull request reviews
- [`merge`](#merge) - Merge code with quality checks
- [`test`](#test) - Execute comprehensive testing workflows

### 🔍 Quality Assurance
- [`code_review`](#code_review) - Perform detailed code reviews
- [`discuss_review`](#discuss_review) - Facilitate review discussions
- [`testing_review`](#testing_review) - Review testing coverage and quality

### ⚡ Utility Commands
- [`prime`](#prime) - Initialize Claude context with project information
- [`yolo`](#yolo) - Quick development actions (use with caution)

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
3. **Code Review**: Automated code quality and security checks
4. **Approval Gates**: User-controlled commit and PR creation
5. **Integration**: Automatic Git workflow with user approval

**New Approval Gate Features**:
- **Commit Approval**: Review changes and approve commit with custom message
- **PR Approval**: Review PR details and approve creation with team assignment
- **User Control**: Modify, skip, or abort at any checkpoint
- **Auto-execution**: Commands run automatically after user approval

**Implementation Process**:
1. Create and switch to task branch
2. Execute task work with progress tracking
3. Implementation quality review and validation
4. Automated code review with parallel subagents
5. **NEW**: Commit approval gate with change preview
6. **NEW**: Auto-commit execution with task reference
7. **NEW**: PR approval gate with team assignment
8. **NEW**: Auto-PR creation with proper linking
9. **NEW**: Task status update to "review" state

**Quality Features**:
- Comprehensive acceptance criteria validation
- Automated testing and code quality checks
- Documentation updates and verification
- Security and performance impact assessment
- Full audit trail and progress tracking

**Integration Benefits**:
- **Complete Workflow**: End-to-end task completion with Git integration
- **Safety First**: User approval required for all commits and PRs
- **Team Ready**: PRs created with proper reviewers and documentation
- **Traceability**: Full linking between tasks, commits, and PRs

---

### update_task_status

**Purpose**: Update the status and progress of tasks.

**Usage**:
```
/project:simone:update_task_status <task_id> <new_status>
```

**Arguments**:
- `task_id` - Task identifier
- `new_status` - pending | in_progress | completed | blocked | cancelled

**Features**:
- Updates task metadata and timestamps
- Synchronizes project manifest
- Maintains audit trail
- Updates sprint and milestone progress

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

**Task Creation → Development → Review → Merge**:
1. `create_general_task` - Create task
2. `start_task` - Set up development environment  
3. `do_task` - Implement solution
4. `commit` - Commit changes
5. `create_pr` - Create pull request
6. `review_pr` - Conduct review
7. `merge` - Merge to main branch

**Sprint Planning → Execution → Review**:
1. `create_sprints_from_milestone` - Plan sprint
2. `create_sprint_tasks` - Create sprint tasks
3. `status` - Monitor progress
4. `project_review` - Retrospective analysis

### Quality Assurance Integration

Quality is built into every command:
- Automated validation and checks
- Documentation requirements
- Testing integration
- Code quality analysis
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

For detailed implementation guides and examples, see:
- [Template System Documentation](template-system.md)
- [Workflow Documentation](../workflows/)
- [Best Practices](../best-practices/)