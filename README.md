# Simone for Claude Code

## Overview

Simone is a directory-based project management framework designed to enhance Claude Code development workflows. It provides a structured approach to organizing software projects through folders, markdown files, and custom commands that break down complex projects into manageable components optimized for AI-assisted development.

**Attribution**: This framework builds upon the original Simone implementation created by [Helmi](https://github.com/helmi). The foundational concepts and workflow design from the original work have been extended with comprehensive metadata management and project tracking capabilities.

**Inspiration**: Cognitive personas and command patterns are inspired by [SuperClaude](https://github.com/NomenAK/SuperClaude), which introduced innovative approaches to AI-driven development workflows and specialized assistant capabilities.

**Important Considerations**: Simone is a comprehensive framework that requires understanding of its concepts and structure for effective use. It is designed for teams and individuals who benefit from structured project management integrated with AI-assisted development workflows.

**Development Status**: This framework is actively developed with regular feature updates and improvements. Users should review documentation and test features in non-critical environments before full adoption.

## Key Features

Current version includes hierarchical completion tracking and enhanced metadata management:

### Hierarchical Completion Tracking
- Automatic status propagation from tasks through sprints to milestones and project completion
- Real-time progress calculation at all hierarchy levels
- Completion validation that prevents marking incomplete work as done
- Comprehensive progress visualization through completion dashboard
- Automatic project completion detection when all milestones are finished
- Metadata synchronization ensuring consistency across all tracking levels

### Enhanced Task Automation
- Streamlined task completion through comprehensive automation
- Integrated completion validation with acceptance criteria enforcement
- Quality gate enforcement that blocks completion until standards are met
- Automatic hierarchical status checking when tasks complete
- Automated pull request creation with reviewer assignment and context
- CI/CD integration with automated quality gates and validation


### Comprehensive Templates
- Detailed YAML frontmatter with complete metadata tracking
- Structured sections for requirements, implementation, testing, and quality control
- Progress tracking and status management throughout the project lifecycle
- Risk assessment and mitigation planning built into templates
- Quality checklists and review processes

### Smart Installation System
- Automated installer with intelligent upgrade detection
- Backup and rollback capabilities for safe upgrades
- Version management to track framework updates
- Preservation of user data during upgrades

### Advanced Project Management
- Detailed task breakdown with implementation guidance
- Architecture decision tracking with comprehensive ADR templates
- Project health monitoring with detailed review templates
- Success metrics and measurement frameworks

### Quality & Process Improvements
- Built-in quality gates and approval workflows
- Compliance tracking and governance processes
- Documentation requirements integrated into workflows
- Review checklists for technical, business, and process validation

### Unified Review System
- Single review command replaces multiple separate review commands
- Specialized review types with configurable flags for code, quality, testing, and discussion
- Cross-type analysis with comprehensive review integration
- Enhanced metadata tracking for review history and patterns

### Metadata Synchronization
- Comprehensive hierarchy synchronization command for maintaining consistency
- Troubleshooting guide for metadata tracking issues
- Completion validation that prevents incomplete work from being marked done
- Real-time progress dashboards with accurate completion percentages

See [CHANGELOG.md](CHANGELOG.md) for complete version history and feature details.

## How to Get Started

### 1. Install Simone

#### Quick Install (Remote)
```bash
# Install directly from GitHub to current directory
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash

# Or install to a specific directory
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash -s -- /path/to/my-project
```

#### Local Development Install
```bash
# Clone the Simone framework for development
git clone https://github.com/steig/claude-steig.git
cd claude-steig

# Run installer from the local repository
./install-simone.sh

# Install to a specific directory from the cloned repo
./install-simone.sh /path/to/my-project

# Force reinstall with latest changes
./install-simone.sh --force /path/to/existing-project
```

#### Advanced Options
```bash
# Force remote installation even when running locally
./install-simone.sh --remote

# View all installation options
./install-simone.sh --help
```

**Smart Installation Features:**
- **Automatic detection** of existing installations vs fresh installs
- **Intelligent upgrades** that preserve all your project data
- **Backup creation** before any changes (`.simone.backup.TIMESTAMP/`)
- **Version tracking** to prevent unnecessary reinstalls
- **Complete setup** including comprehensive templates and Claude Code commands
- **Automatic MCP server installation** for enhanced AI capabilities

The installer works with both new and existing projects, automatically preserving your manifests, milestones, sprints, tasks, and architectural decisions while updating the framework components.

**MCP Integration**: The installer automatically sets up 6 essential MCP servers:
- **Serena**: Enhanced IDE assistance and project management
- **Context7**: Advanced context management and retrieval
- **Playwright**: Browser automation and testing capabilities
- **GitHub**: Repository management and API integration
- **Sequential Thinking**: Enhanced reasoning and structured problem-solving
- **Fetch**: Web content retrieval and markdown extraction capabilities

### 2. Initialize Your Project

Open your project in Claude Code and run:

```
/project:simone:initialize
```

This guides you through the basic setup process. Works with new or existing codebases, and can help you create project documentation (PRDs, architecture docs) or work with documents you already have.

### 3. Set Up Your First Milestone

Use AI-powered milestone generation for efficient, comprehensive planning:

```
/project:simone:create_milestone "Build user authentication system with JWT tokens, social login, and MFA support"
```

This command will:
- Analyze your prompt and extract features, requirements, and constraints
- Generate comprehensive milestone with business objectives, success criteria, and risk assessment
- Create sprint breakdown with timeline estimation and dependency mapping
- Populate all metadata automatically with 30+ YAML fields
- Integrate with project by updating manifest and creating proper directory structure

Alternative (Manual Setup): Create a milestone folder in `.simone/02_REQUIREMENTS/` named `M01_Your_Milestone_Name` (e.g., `M01_Basic_Application`). Include at least:

- `M01_PRD.md` - Product requirements document
- Other specs as needed: `M01_Database_Schema.md`, `M01_API_Specs.md`, etc.

Use the existing chat from step 2 to guide Claude through manual milestone creation, ensuring proper naming with the `M##_` prefix and underscores.

### 4. Break Down into Sprints

```
/project:simone:create_sprints_from_milestone
```

This analyzes your milestone and breaks it down into logical sprints. It looks at the entire scope and creates meaningful sprint boundaries without detailed tasks yet.

### 5. Create Your First Tasks

```
/project:simone:create_sprint_tasks
```

This analyzes your sprints, reviews documentation, researches necessary information, and identifies knowledge gaps to gain comprehensive understanding of your project. Creates detailed, actionable tasks for the current sprint.

Important: Only create tasks for your next sprint, not all sprints upfront. After completing Sprint 1, then create tasks for Sprint 2. This ensures the system can reference your existing codebase and incorporate completed work into future task creation.

### 6. Start Working - Choose Your Workflow

**Automated Workflow (Recommended for Routine Tasks)**:
```
/project:simone:do_task_auto T01_S01 --persona-security --quality-strict
```

Experience comprehensive automation with minimal human intervention:
- Intelligent task execution with automatic persona activation
- Continuous quality validation with real-time monitoring
- Automated issue resolution for routine problems
- Technical debt management with automatic assessment and resolution
- Comprehensive code review with multi-domain analysis
- Validated commits with comprehensive quality context
- Ready for PR creation with complete automation context

**Standard Workflow (Manual Control)**:
```
/project:simone:do_task T01_S01
```

Experience the guided approval workflow with user control at every step:
- Commit Approval Gate: Preview changes and approve commits
- PR Approval Gate: Review PR details before creation  
- Auto-execution: Commands run automatically after approval
- Complete Integration: End-to-end task completion with Git workflow

**Workflow Selection Guide**:
- Use Automated for: Well-defined tasks, bug fixes, refactoring, routine features
- Use Standard for: Complex features, architectural changes, experimental work

**Create Comprehensive PRs**:
```
/project:simone:create_pr_auto T01_S01 --auto-assign --comprehensive
```

**Automated PR Benefits**:
- AI-generated descriptions with comprehensive context and quality metrics
- Intelligent reviewer assignment based on code ownership and expertise  
- Automated labeling and project management integration
- Risk assessment with specific review focus recommendations
- Quality transparency with complete validation results

That's the basic workflow to get started! You can also:

- Create general tasks with `/project:simone:create_general_task`
- Update task status and metadata with `/project:simone:update_task_status T01_S01 completed`
- Use YOLO mode to run a full sprint autonomously
- **Use helper commands** for planning and research:
  - `/project:simone:troubleshoot` - Comprehensive project diagnostics
  - `/project:simone:plan` - Strategic feature planning with automatic milestone creation
  - `/project:simone:research` - Investigate codebase patterns and best practices
  - `/project:simone:analyze` - Deep code quality and architecture analysis
  - `/project:simone:investigate` - Targeted bug and issue investigation
- Explore other commands in `.claude/commands/simone/`

### 7. Task Status Management

```
/project:simone:update_task_status T01_S01 in_progress
```

The `update_task_status` command provides comprehensive status management with full metadata tracking:

- **Status transitions**: pending → in_progress → review → completed (and blocked states)
- **Metadata updates**: Automatically updates YAML frontmatter with timestamps, effort tracking, and progress
- **Content updates**: Updates task sections based on status (logs, checklists, etc.)
- **Integration**: Updates project manifest and sprint tracking
- **Quality gates**: Ensures all acceptance criteria are met before completion

**Usage Examples:**
```bash
# Start working on a task
/project:simone:update_task_status T01_S01 in_progress

# Mark ready for review with time tracking  
/project:simone:update_task_status T01_S01 review 3.5

# Complete a task
/project:simone:update_task_status T01_S01 completed 4
```

**Important**: Simone is a complex system, not a simple set-and-forget tool. It works best when you understand how it operates. Take time to read through the commands and consider adapting them to your workflow.

## MCP Server Integration

Simone includes integration with multiple MCP servers that provide comprehensive IDE assistance, project management, and context management capabilities. Choose between **local installation** or **Docker containers**.

### Deployment Options

#### Option 1: Local Installation (Default)

All MCP servers are automatically installed during project initialization:

```bash
# Installed automatically during /project:simone:initialize
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project $(pwd)
claude mcp add context7 -- uvx --from git+https://github.com/upstash/context7 context7-mcp-server
claude mcp add playwright -- uvx --from git+https://github.com/microsoft/playwright-mcp playwright-mcp-server
claude mcp add github -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PERSONAL_ACCESS_TOKEN} ghcr.io/github/github-mcp-server
claude mcp add sequential-thinking -- uvx --from git+https://github.com/modelcontextprotocol/servers.git --subdirectory src/sequentialthinking mcp-server-sequentialthinking
claude mcp add fetch -- uvx --from git+https://github.com/modelcontextprotocol/servers.git --subdirectory src/fetch mcp-server-fetch
```

#### Option 2: Docker Containers (Recommended)

**Choose between single-project or multi-project setup:**

##### Single Project (Simple)
```bash
# One-time setup
./scripts/mcp-docker.sh setup

# Start MCP services (serves current project)
./scripts/mcp-docker.sh start

# Check service status
./scripts/mcp-docker.sh health
```

##### Multi-Project (Up to 3 simultaneous projects)
```bash
# Setup project 1
cd /path/to/project1
./scripts/mcp-multi.sh setup 1

# Setup project 2  
cd /path/to/project2
./scripts/mcp-multi.sh setup 2

# Start both projects (can run simultaneously)
./scripts/mcp-multi.sh start 1 /path/to/project1
./scripts/mcp-multi.sh start 2 /path/to/project2

# Check status of all projects
./scripts/mcp-multi.sh status
```

**Docker Benefits:**
- **Isolated environments** for each MCP server
- **Consistent deployments** across different systems  
- **Complete project isolation** with separate ports, networks, and data
- **Simultaneous operation** of multiple projects
- **Health monitoring** and service discovery
- **Persistent data storage** with Docker volumes

**Port Assignments (Multi-Project):**
- **Project 1**: Gateway `9000`, Services `8080-8084`
- **Project 2**: Gateway `9010`, Services `8090-8094`
- **Project 3**: Gateway `9020`, Services `8100-8104`

**Multi-Project Benefits:**
- ✅ **Complete isolation** - no data mixing between projects
- ✅ **Simultaneous operation** - work on multiple projects at once
- ✅ **No port conflicts** - automatic port assignment
- ✅ **Independent scaling** - start/stop projects individually

See [Multi-Project Guide](docs/multi-project/README.md) for complete multi-project setup instructions.

### Capabilities

**Serena** provides:
- **Enhanced IDE assistance** and code analysis
- **Improved project management** capabilities  
- **Context-aware development** support throughout Simone operations

**Context7** provides:
- **Advanced context management** and retrieval
- **Smart context preservation** across sessions
- **Advanced memory capabilities** for complex projects

**Playwright** provides:
- **Browser automation** and web testing capabilities
- **End-to-end testing** support
- **Web scraping** and interaction tools

**GitHub** provides:
- **Repository management** and API integration capabilities
- **Issue and PR management** with automated workflows
- **Code review automation** and repository insights

**Sequential Thinking** provides:
- **Structured reasoning** and step-by-step problem-solving capabilities
- **Enhanced logical thinking** for complex development challenges
- **Systematic approach** to breaking down and solving technical problems

**Fetch** provides:
- **Web content retrieval** from URLs and conversion to markdown format
- **Internet research capabilities** for gathering external documentation and resources
- **Content extraction** for integrating external information into development workflows

### Usage

Every time you prime your knowledge with `/project:simone:prime`, all MCP servers are automatically initialized:

1. **Verifies MCP server status** to ensure all are active
2. **Loads Serena instructions** with `/mcp__serena__initial_instructions`
3. **Ensures proper configuration** for using all MCP tools

**Important**: Always run `/mcp__serena__initial_instructions` when starting a new conversation or after any compacting operation to ensure Claude remains properly configured to use Serena's tools.

## How it Works

Simone organizes your project into:

- **Milestones**: Major features or project phases
- **Sprints**: Groups of related tasks within a milestone
- **Tasks**: Individual work items scoped for one Claude session

Each task gets full project context so Claude knows exactly what to build and how it fits into your architecture.


## 📋 Completion Naming Convention

Simone uses a consistent "X" prefix to mark completed work items, providing clear visual distinction between active and finished work:

- **Tasks**: `T001` → `TX001` (completed)
- **Sprints**: `S01_M01` → `SX01_M01` (completed)  
- **Milestones**: `M01` → `MX01` (completed)
- **Bugs**: `BUG001` → `BUGX001` (resolved)

This convention makes it easy to filter active work, maintain project history, and track completion progress across all work item types. All completed items retain their full context and remain accessible for reference.

## Why I built this

AI coding tools have become incredibly powerful, but they all face the same fundamental challenge: context management. The context window is limited in size, and we have little control over what stays in context and what doesn't.

The problem with long-running sessions is context decay - as you work, critical project knowledge silently falls off the end of the context window. You don't know what's been forgotten until something goes wrong.

My solution: Start fresh for each task, but provide rich surrounding context. By keeping tasks focused and well-scoped, I can dedicate more of the context window to relevant project knowledge, requirements, and architectural decisions. This way:

- Each task starts with exactly the project context it needs
- No critical knowledge gets lost in long sessions
- Claude can work confidently with full awareness of requirements
- The surrounding context guides development, not just the task description

The result is a task-based workflow where Claude always has the right context for the job at hand.

## Key Components

### 00_PROJECT_MANIFEST.md

The central document containing the project's vision, goals, and high-level overview. It serves as the starting point for Claude to understand the project. **Important**: The manifest file must be named exactly `00_PROJECT_MANIFEST.md`, not `MANIFEST.md`.

### 01_PROJECT_DOCS/

Contains general project documentation including technical specifications, user guides, and API documentation that Claude can reference.

### 02_REQUIREMENTS/

Organized by milestones, this directory stores product requirements documents (PRDs) and their amendments, providing a clear view of what needs to be built. This helps Claude understand the project requirements. Milestone folders follow the naming convention `M##_Milestone_Name/` (e.g., `M01_Backend_Setup/`). Completed milestones use `MX##_Milestone_Name/` for clear distinction.

### 03_SPRINTS/

Contains sprint plans and task definitions organized by milestone and sprint sequence. Each sprint folder contains individual task files with detailed information for Claude to work on. Sprint folders follow `S##_M##_Sprint_Name/` format, with completed sprints using `SX##_M##_Sprint_Name/`.

### 04_GENERAL_TASKS/

Stores task definitions for work not tied to a specific sprint. Completed tasks use a `TX` prefix (e.g., `TX001_Completed_Task.md`), making it easy for Claude to identify what's been done.

### 05_ARCHITECTURAL_DECISIONS/

Captures significant architectural decisions as Architecture Decision Records (ADRs), documenting the context, options considered, and rationale. This provides critical context for Claude when making technical decisions. Uses a structured ADR template for consistency.

### 06_BUGS/

Bug tracking and resolution documentation. Bug reports follow the naming convention `BUG###_Bug_Description.md` (e.g., `BUG001_Login_Validation_Error.md`). Resolved bugs use `BUGX###_Bug_Description.md` for clear status distinction and historical tracking.

### 10_STATE_OF_PROJECT/

Contains timestamped project review snapshots created by the `project_review` command. These provide a historical record of project health, technical decisions, and progress over time.

### 99_TEMPLATES/

Contains comprehensive, templates for all document types:

**Core Templates:**
- **`task_template.md`** - Detailed task structure with requirements, implementation, testing, and quality control
- **`sprint_meta_template.md`** - Sprint planning with goals, capacity, and quality standards
- **`milestone_meta_template.md`** - Comprehensive milestone tracking with success metrics
- **`project_manifest_template.md`** - Advanced project overview with metadata and health tracking

**Specialized Templates:**
- **`adr_template.md`** - Comprehensive Architecture Decision Records with detailed analysis
- **`architecture_template.md`** - Complete architecture documentation framework
- **`prd_template.md`** - Product Requirements Document template
- **`specs_template.md`** - Technical specifications template
- **`project_review_template.md`** - Project health and progress review template

**Features:**
- Rich YAML frontmatter with metadata tracking
- Built-in quality gates and review processes
- Progress tracking and status management
- Risk assessment and mitigation planning
- Success metrics and measurement frameworks

### .claude/commands/simone/

Custom Claude Code commands that power the Simone workflow:

- `initialize` - Set up project structure and documentation
- `create_sprints_from_milestone` - Break milestones into logical sprints
- `create_sprint_tasks` - Generate detailed tasks from sprint plans
- `do_task` - Execute individual tasks with guided approval workflow for commits and PRs
- `do_task_auto` - **NEW** Automated task execution with comprehensive validation and minimal human intervention
- `create_pr_auto` - **NEW** AI-powered PR creation with intelligent reviewer assignment and quality context
- `quality_gate_validator` - **NEW** Comprehensive validation pipeline with configurable quality thresholds
- `yolo` - Autonomous sprint execution (use with caution)
- And many more for testing, reviewing, and project management

## Directory Structure

```plaintext
.simone/
├── 00_PROJECT_MANIFEST.md
├── 01_PROJECT_DOCS/
├── 02_REQUIREMENTS/
│   ├── M01_Backend_Setup/
│   ├── M02_Frontend_Setup/
│   └── ...
├── 03_SPRINTS/
│   ├── S01_M01_Initial_API/
│   ├── S02_M01_Database_Schema/
│   └── ...
├── 04_GENERAL_TASKS/
│   ├── TX001_Refactor_Logging_Module.md  # Completed task
│   ├── T002_API_Rate_Limiting.md          # Open task
│   └── ...
├── 05_ARCHITECTURE_DECISIONS/
│   ├── ADR001_Database_Selection.md
│   └── ...
├── 10_STATE_OF_PROJECT/         # Project review snapshots
└── 99_TEMPLATES/                 # Template collection
    ├── adr_template.md           # Architecture Decision Records
    ├── architecture_template.md  # Complete architecture docs
    ├── milestone_meta_template.md
    ├── prd_template.md          # Product Requirements
    ├── project_manifest_template.md
    ├── project_review_template.md
    ├── specs_template.md        # Technical specifications
    ├── sprint_meta_template.md
    └── task_template.md
```

## Configuration Tips

### Enabling Parallel Task Execution

While Simone commands like `create_sprint_tasks` support the `useParallelSubagents` instruction, Claude Code needs to be configured to actually execute tasks in parallel. By default, it only runs one task at a time.

To enable parallel execution:

```bash
# Set the number of parallel tasks (example: 3)
claude config set --global "parallelTasksCount" 3

# Check your current configuration
claude config list -g
```

**Important considerations:**

- Choose the number based on your system's capabilities and rate limits
- Parallel execution increases API usage significantly
- Some tasks may have conflicts when run in parallel
- Start with a small number (2-3) and adjust based on your experience

## Contributing & Feedback

This version is maintained at [steig/claude-steig](https://github.com/steig/claude-steig).

- **GitHub Issues**: [Report bugs and feature requests](https://github.com/steig/claude-steig/issues)
- **Pull Requests**: Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for details
- **Quality Standards**: We use pre-commit hooks to ensure code quality - see contributing guide for setup

### Development Setup

To contribute to the Simone Framework:

```bash
# Clone and set up development environment
git clone https://github.com/steig/claude-steig.git
cd claude-steig

# Install pre-commit hooks for quality assurance
pip install pre-commit
pre-commit install

# Test the setup
pre-commit run --all-files
```

Our pre-commit hooks ensure:
- ✅ Shell script quality (ShellCheck + shfmt)
- ✅ Markdown formatting (markdownlint)
- ✅ Security scanning (detect-secrets)
- ✅ General formatting and validation

### Original Framework
The original Simone framework was created by [Helmi](https://github.com/helmi). 

- **Original Repository**: Check Helmi's repositories for the original implementation
- **Anthropic Discord**: Find @helmi for discussions about the original framework