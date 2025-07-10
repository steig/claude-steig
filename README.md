# Simone for Claude Code

## What is this?

Simone is a directory-based project management system designed to work better with Claude Code. It's a sophisticated framework of folders, markdown files, and custom commands that help break down software projects into manageable chunks that AI can handle effectively.

**🙏 Attribution**: This is a specialized fork of the original Simone framework created by [Helmi](https://github.com/helmi). The original work provided the foundational concepts and workflow design. This fork adds comprehensive metadata management and project tracking capabilities.

**⚠️ Complexity Warning**: Simone is a sophisticated system that requires time to understand properly. It's not a simple plug-and-play solution, but rather a framework that works best when you take the time to learn how it operates and adapt it to your workflow.

## 🚀 Key Features

This fork includes specialized improvements for comprehensive project management:

### 📋 **Comprehensive Templates**
- **Detailed YAML frontmatter** with complete metadata tracking
- **Structured sections** for requirements, implementation, testing, and quality control
- **Progress tracking** and status management throughout the project lifecycle
- **Risk assessment** and mitigation planning built into templates
- **Quality checklists** and review processes

### 🔧 **Smart Installation System**
- **Automated installer** with intelligent upgrade detection
- **Backup and rollback** capabilities for safe upgrades
- **Version management** to track framework updates
- **Preservation of user data** during upgrades

### 📊 **Advanced Project Management**
- **Detailed task breakdown** with implementation guidance
- **Architecture decision tracking** with comprehensive ADR templates
- **Project health monitoring** with detailed review templates
- **Success metrics** and measurement frameworks

### 🎯 **Quality & Process Improvements**
- **Built-in quality gates** and approval workflows
- **Compliance tracking** and governance processes
- **Documentation requirements** integrated into workflows
- **Review checklists** for technical, business, and process validation

**📋 Latest Updates**: See [CHANGELOG.md](CHANGELOG.md) for recent changes and improvements.

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

The installer works with both new and existing projects, automatically preserving your manifests, milestones, sprints, tasks, and architectural decisions while updating the framework components.

### 2. Initialize Your Project

Open your project in Claude Code and run:

```
/project:simone:initialize
```

This guides you through the basic setup process. Works with new or existing codebases, and can help you create project documentation (PRDs, architecture docs) or work with documents you already have.

### 3. Set Up Your First Milestone

**NEW**: Use AI-powered milestone generation for faster, comprehensive planning:

```
/project:simone:create_milestone "Build user authentication system with JWT tokens, social login, and MFA support"
```

This command will:
- 🤖 **Analyze your prompt** and extract features, requirements, and constraints
- 📝 **Generate comprehensive milestone** with business objectives, success criteria, and risk assessment
- 🎯 **Create sprint breakdown** with timeline estimation and dependency mapping
- 📊 **Populate all metadata** automatically (30+ YAML fields)
- 🔗 **Integrate with project** by updating manifest and creating proper directory structure

**Alternative (Manual Setup)**: Create a milestone folder in `.simone/02_REQUIREMENTS/` named `M01_Your_Milestone_Name` (e.g., `M01_Basic_Application`). Include at least:

- `M01_PRD.md` - Product requirements document
- Other specs as needed: `M01_Database_Schema.md`, `M01_API_Specs.md`, etc.

*Use the existing chat from step 2 to guide Claude through manual milestone creation, ensuring proper naming with the `M##_` prefix and underscores.*

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

*Important: Only create tasks for your next sprint, not all sprints upfront. After completing Sprint 1, then create tasks for Sprint 2. This ensures the system can reference your existing codebase and incorporate completed work into future task creation.*

### 6. Start Working with Enhanced Approval Workflow

```
/project:simone:do_task
```

Experience the **new guided approval workflow** with user control at every step:

- **Commit Approval Gate**: Preview changes and approve commits
- **PR Approval Gate**: Review PR details before creation  
- **Auto-execution**: Commands run automatically after approval
- **Complete Integration**: End-to-end task completion with Git workflow

For faster execution, specify a task ID:

```
/project:simone:do_task T01_S01
```

**Enhanced Workflow Benefits**:
- 🛡️ **User Control**: Review and approve each critical step
- 🔍 **Quality Assurance**: Comprehensive validation before integration
- 🔄 **Complete Workflow**: Task → Commit → PR → Review in one command
- ⚡ **Team Ready**: PRs created with proper documentation and reviewers

Claude will execute the task with full project context and guide you through approval gates for commits and PR creation.

That's the basic workflow to get started! You can also:

- Create general tasks with `/project:simone:create_general_task`
- Update task status and metadata with `/project:simone:update_task_status T01_S01 completed`
- Use YOLO mode to run a full sprint autonomously
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

Simone now includes automatic integration with multiple MCP servers that provide comprehensive IDE assistance, project management, and context management capabilities.

### Automatic Setup

All MCP servers are automatically installed during project initialization:

```bash
# Installed automatically during /project:simone:initialize
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project $(pwd)
claude mcp add context7 -- uvx --from git+https://github.com/upstash/context7 context7-mcp-server
claude mcp add playwright -- uvx --from git+https://github.com/microsoft/playwright-mcp playwright-mcp-server
claude mcp add work-history -- uvx mcp-work-history
claude mcp add sequential-thinking -- uvx --from git+https://github.com/modelcontextprotocol/servers.git --subdirectory src/sequentialthinking mcp-server-sequentialthinking
```

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

**Work History** provides:
- **Command tracking** and output logging for all Simone operations
- **Historical context** of project development activities
- **Audit trail** of all executed commands and their results

**Sequential Thinking** provides:
- **Structured reasoning** and step-by-step problem-solving capabilities
- **Enhanced logical thinking** for complex development challenges
- **Systematic approach** to breaking down and solving technical problems

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

Organized by milestones, this directory stores product requirements documents (PRDs) and their amendments, providing a clear view of what needs to be built. This helps Claude understand the project requirements. Milestone folders must follow the naming convention `M##_Milestone_Name/` (e.g., `M01_Backend_Setup/`).

### 03_SPRINTS/

Contains sprint plans and task definitions organized by milestone and sprint sequence. Each sprint folder contains individual task files with detailed information for Claude to work on.

### 04_GENERAL_TASKS/

Stores task definitions for work not tied to a specific sprint. Completed tasks use a `TX` prefix (e.g., `TX001_Completed_Task.md`), making it easy for Claude to identify what's been done.

### 05_ARCHITECTURAL_DECISIONS/

Captures significant architectural decisions as Architecture Decision Records (ADRs), documenting the context, options considered, and rationale. This provides critical context for Claude when making technical decisions. Uses a structured ADR template for consistency.

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