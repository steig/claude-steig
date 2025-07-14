# Simone for Claude Code

## What is this?

Simone is a directory-based project management system designed to work better with Claude Code. It's a sophisticated framework of folders, markdown files, and custom commands that help break down software projects into manageable chunks that AI can handle effectively.

**🙏 Attribution**: This is a specialized fork of the original Simone framework created by [Helmi](https://github.com/helmi). The original work provided the foundational concepts and workflow design. This fork adds comprehensive metadata management and project tracking capabilities.

**🎭 Inspiration**: Cognitive personas and command patterns inspired by [SuperClaude](https://github.com/NomenAK/SuperClaude), which pioneered innovative approaches to AI-driven development workflows and specialized assistant capabilities.

**⚠️ Complexity Warning**: Simone is a sophisticated system that requires time to understand properly. It's not a simple plug-and-play solution, but rather a framework that works best when you take the time to learn how it operates and adapt it to your workflow.

**🚨 EXPERIMENTAL WARNING**: This is a rapidly evolving, experimental project. Things move fast here and stuff might break. Features change frequently, commands may be unstable, and documentation might lag behind reality. Use at your own risk and expect the unexpected. YOLO! 🎢

## 🚀 Key Features

**Version 3.0.0** includes hierarchical completion tracking and enhanced metadata management:

### **Hierarchical Completion Tracking (v3.0.0)**
- **Automatic Status Propagation**: Tasks → Sprints → Milestones → Project completion
- **Real-time Progress**: Live calculation at all hierarchy levels
- **Completion Validation**: Prevents marking incomplete work as done
- **Completion Dashboard**: Comprehensive progress visualization
- **Project Completion Detection**: Automatic detection when all milestones finished
- **Metadata Synchronization**: Comprehensive consistency across all tracking

### **Enhanced Task Automation (v3.0.0)**
- **Significant time reduction** in task completion with comprehensive automation
- **Integrated completion validation** with acceptance criteria enforcement
- **Quality gate enforcement** blocks completion until standards met
- **Automatic hierarchical checking** when tasks complete
- **Automated PR creation** with reviewer assignment and context
- **CI/CD integration** with automated quality gates and validation

### ⚡ **Performance Optimization (v2.1.0)**
- **60-80% faster** command execution through intelligent caching and indexing
- **SQLite task database** for instant queries (95% faster than file scanning)
- **Smart caching system** with TTL management (90% faster template operations)
- **Git operation batching** reduces sequential operations by 70%
- **Parallel processing** for independent operations
- **Built-in performance monitoring** and benchmarking tools

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

### **Unified Review System (v3.0.0)**
- **Single `review` command** replaces 4 separate review commands  
- **`--type-code/quality/testing/discussion`** flags for specialized reviews
- **Cross-type analysis** with comprehensive review integration
- **Enhanced metadata tracking** for review history and patterns

### **Metadata Synchronization (v3.0.0)**
- **`sync_metadata` command** for comprehensive hierarchy synchronization
- **Troubleshooting guide** for metadata tracking issues
- **Completion validation** prevents incomplete work from being marked done
- **Real-time progress dashboards** with accurate completion percentages

**v3.0.0 Release**: Hierarchical completion tracking and enhanced metadata management. See [CHANGELOG.md](CHANGELOG.md) for complete details.

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

**MCP Integration**: The installer automatically sets up 5 essential MCP servers:
- **Serena**: Enhanced IDE assistance and project management
- **Context7**: Advanced context management and retrieval
- **Playwright**: Browser automation and testing capabilities
- **Work History**: Command tracking and output logging
- **Sequential Thinking**: Enhanced reasoning and structured problem-solving

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

### 6. Start Working - Choose Your Workflow

**🤖 Automated Workflow (NEW - Recommended for Routine Tasks)**:
```
/project:simone:do_task_auto T01_S01 --persona-security --quality-strict
```

Experience **comprehensive automation** with minimal human intervention:
- **Intelligent task execution** with automatic persona activation
- **Continuous quality validation** with real-time monitoring
- **Automated issue resolution** for routine problems
- **Technical debt management** with automatic assessment and resolution
- **Comprehensive code review** with multi-domain analysis
- **Validated commits** with comprehensive quality context
- **Ready for PR creation** with complete automation context

**📋 Standard Workflow (Manual Control)**:
```
/project:simone:do_task T01_S01
```

Experience the **guided approval workflow** with user control at every step:
- **Commit Approval Gate**: Preview changes and approve commits
- **PR Approval Gate**: Review PR details before creation  
- **Auto-execution**: Commands run automatically after approval
- **Complete Integration**: End-to-end task completion with Git workflow

**Workflow Selection Guide**:
- **Use Automated** for: Well-defined tasks, bug fixes, refactoring, routine features
- **Use Standard** for: Complex features, architectural changes, experimental work

**🚀 Create Comprehensive PRs**:
```
/project:simone:create_pr_auto T01_S01 --auto-assign --comprehensive
```

**Automated PR Benefits**:
- **AI-generated descriptions** with comprehensive context and quality metrics
- **Intelligent reviewer assignment** based on code ownership and expertise  
- **Automated labeling** and project management integration
- **Risk assessment** with specific review focus recommendations
- **Quality transparency** with complete validation results

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

## 🧪 Testing & Quality Assurance

Simone v2.1.0 includes comprehensive testing infrastructure to validate the performance optimizations and ensure system reliability.

### Performance Test Suite

The framework includes three levels of performance testing:

#### 1. **Infrastructure Tests** (Unit Tests)
```bash
# Run BATS unit tests for performance components
bats tests/test-performance-infrastructure.bats
bats tests/test-performance-commands.bats
```

**Coverage:**
- SQLite database operations and indexing
- Caching system with TTL management
- Git operation batching functionality
- Template caching effectiveness
- Task indexing and querying performance

#### 2. **Integration Tests** (End-to-End)
```bash
# Run comprehensive performance integration tests
tests/test-performance-integration.sh --medium
tests/test-performance-integration.sh --large
```

**Coverage:**
- Baseline vs optimized performance comparison
- Data integrity validation during optimization
- Large dataset handling (200+ tasks)
- Concurrent operation testing
- Real-world usage simulation

#### 3. **Quick Validation** (Smoke Tests)
```bash
# Run quick performance validation
tests/run-performance-tests.sh quick
```

### Test Runner

Use the unified test runner for comprehensive testing:

```bash
# Run all performance tests
tests/run-performance-tests.sh

# Run specific test suites
tests/run-performance-tests.sh infrastructure
tests/run-performance-tests.sh integration
tests/run-performance-tests.sh benchmark

# Run with different project sizes
tests/run-performance-tests.sh integration large
tests/run-performance-tests.sh benchmark small

# Enable verbose output
VERBOSE=true tests/run-performance-tests.sh
```

### GitHub Actions Integration

Performance tests run automatically on:
- **Push to main/develop**: Full test suite with performance benchmarks
- **Pull Requests**: Regression testing and performance impact analysis
- **Manual Trigger**: Configurable test size and benchmark options

**Workflows:**
- `.github/workflows/test-performance.yml` - Comprehensive performance testing
- `.github/workflows/test-install.yml` - Installation testing with performance validation

### Performance Claims Validation

The test suite validates these v2.1.0 performance improvements:
- ✅ **SQLite Task Database**: 95% faster than file scanning
- ✅ **Smart Caching**: 90% faster template operations
- ✅ **Git Batching**: 70% reduction in sequential calls
- ✅ **Overall Performance**: 60-80% faster operations

### Test Prerequisites

```bash
# Ubuntu/Debian
sudo apt-get install sqlite3 bc git
npm install -g bats

# macOS
brew install sqlite3 bc git bats-core

# Verify installation
tests/run-performance-tests.sh --help
```

### CI/CD Integration

The performance tests integrate with continuous integration:

```yaml
# Example GitHub Actions usage
- name: Run Performance Tests
  run: |
    tests/run-performance-tests.sh integration medium
    tests/run-performance-tests.sh benchmark
```

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