# Changelog

## 2025-07-10 - v2.0.3

### 🚀 Installation & Repository Strategy

#### Remote Installation Support
- **Dual installation modes** - Support for both remote (curl/wget) and local installation
- **Auto-detection** of installation context (remote vs local)
- **Remote repository support** - Install directly from GitHub with one command
- **Improved installation script** with `--remote` flag for forcing remote installation
- **Updated documentation** to reflect both installation methods
- **Comprehensive installation guide** with troubleshooting and proxy support

#### Installation Improvements
- **Quick install command**: `curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash`
- **Temporary directory cleanup** after remote installations
- **Better error handling** for network issues and missing dependencies
- **Enhanced help documentation** with examples for all installation methods

## 2025-07-10

### 🚀 Enhancements

This release represents a complete overhaul of the Simone framework with comprehensive enhancements across all areas.

#### 📋 Template System
- **Comprehensive YAML frontmatter** added to all templates with detailed metadata tracking
- **Task template** with requirements analysis, implementation guidance, testing strategy, and quality control
- **Advanced sprint template** with capacity planning, risk assessment, and success metrics
- **Comprehensive milestone template** with detailed progress tracking and quality gates
- **Project manifest** with health monitoring and status tracking
- **Complete ADR template** with decision matrices, risk analysis, and implementation planning
- **New architecture template** for comprehensive system documentation
- **Project review template** for systematic health assessments
- **PRD and specs templates** for requirements and technical specifications

#### 🔧 Smart Installation System
- **New bash installer** (`install-simone.sh`) with intelligent upgrade detection
- **Automatic backup creation** before upgrades with timestamped backups
- **User data preservation** during upgrades (manifests, milestones, sprints, tasks, ADRs)
- **Version tracking** to prevent unnecessary reinstalls
- **Smart project detection** and setup guidance
- **Complete framework installation** including templates and Claude Code commands

#### 📊 Advanced Project Management Features
- **Progress tracking** with detailed status management
- **Risk assessment frameworks** built into templates
- **Quality control processes** with review checklists
- **Success metrics and measurement** frameworks
- **Compliance tracking** and governance processes
- **Implementation planning** with phased approaches

#### 🎯 Quality & Process Improvements
- **Built-in quality gates** and approval workflows
- **Review checklists** for technical, business, and process validation
- **Documentation requirements** integrated into all workflows
- **Testing strategies** embedded in task templates
- **Security considerations** built into all processes

### Changed

#### Template Structure
- **All template filenames** converted to lowercase for consistency
- **Updated workflow references** to use new template naming
- **Standardized placeholder format** using `{PLACEHOLDER}` syntax

#### Installation Process
- **Replaced `npx hello-simone`** with smart bash installer
- **Added automatic upgrade capabilities** that preserve user data
- **Improved setup process** with better project detection

#### Documentation
- **Updated README** with proper attribution to original creator (Helmi)
- **Added comprehensive installation guide** (INSTALL.md)
- **Directory structure documentation** showing all templates
- **Updated contributing guidelines** with repository information

### Fixed

#### Template References
- **Updated all CLAUDE.md files** to reference correct template names
- **Fixed command references** to use lowercase template filenames
- **Corrected workflow documentation** to match actual template structure

#### Installation Reliability
- **Improved error handling** in installation process
- **Better backup and recovery** mechanisms
- **Version compatibility checking** to prevent conflicts

### Added

#### New Templates
- `architecture_template.md` - Complete architecture documentation framework
- `prd_template.md` - Product Requirements Document template
- `specs_template.md` - Technical specifications template
- `project_review_template.md` - Project health assessment template
- `architecture_initialization_checklist.md` - Setup verification checklist

#### Installation Infrastructure
- `install-simone.sh` - Smart installer with upgrade capabilities
- `INSTALL.md` - Comprehensive installation documentation
- `.version` file tracking for upgrade management

#### Features
- **Metadata tracking** across all templates
- **Progress monitoring** with percentage completion
- **Quality metrics** and scoring systems
- **Approval workflows** with stakeholder sign-offs
- **Audit trails** for decision tracking

### Technical Details

#### Repository Structure
- **Updated repository references** to `steig/claude-steig`
- **Proper attribution** to original Simone framework by Helmi

#### Backward Compatibility
- **User data preservation** during upgrades ensures no loss of existing work
- **Template structure compatibility** maintains existing workflow patterns
- **Command compatibility** ensures existing usage patterns continue working

### Installation

#### Quick Install
```bash
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash
```

#### Manual Install
```bash
wget https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh
chmod +x install-simone.sh
./install-simone.sh
```

### Attribution

This edition builds upon the original Simone framework created by [Helmi](https://github.com/helmi). The foundational concepts, workflow design, and architectural principles from the original work made these enhancements possible.

---

## 2025-05-30

### Added

- `npx hello-simone` quick start command for easy Simone installation
- Interactive, adaptive initialize command that:
  - Auto-detects project type and framework
  - Guides users through conversational setup
  - Creates documentation through Q&A process
  - Adapts to existing vs new projects

### Changed

- initialize command completely rewritten for better user experience
- Removed complex branching logic in favor of adaptive process
- Focus on conversational interaction rather than rigid steps

### Improved

- Better handling of existing documentation during setup
- Smart project detection (Node.js, Python, PHP, etc.)
- Milestone creation now interactive and context-aware

## 2025-05-29

### Added

- ADR template for architecture decision records
- Task ID filtering in commit command (T01_S02, TX003 patterns)
- YOLO mode in commit command to skip user approval
- Code review results now write to task Output Log sections
- create_general_task command for structured task creation
- create_sprint_tasks command for detailed sprint planning
- create_sprints_from_milestone command for milestone-based sprint planning
- prime command for quick project context loading
- yolo command for autonomous task execution without user interaction

### Changed

- Date format simplified to YYYY-MM-DD HH:MM in templates
- Milestone template heading structure updated
- do_task command now uses parallel subagents and updates project manifest
- project_review command removes timeline pressure and focuses on current state

### Removed

- create_sprint, create_task, plan_milestone commands (replaced by new workflow)

## Developer Notes

This update represents a significant evolution based on real-world usage and user feedback. The command architecture has been changed with better use of parallel agents, loops, and conditionals, which work surprisingly well in practice.

**Command Complexity**: The commands may behave differently between Claude Opus and Sonnet models. While the complexity might be challenging for Sonnet, testing suggests it should handle the workflows effectively.

**Task Quality Improvements**: The new `create_sprint_tasks` and `create_general_task` commands now provide much better context and codebase references, resulting in notably higher quality task generation with specific implementation guidance.

**YOLO Mode Warning**: The standalone `yolo` command requires extreme caution. It should only be used:

- Within isolated development environments
- With Claude Code's permission-skipping mode enabled (`claude --dangerously-skip-permissions`)
- Never on production systems or systems with important data

The YOLO mode can potentially modify or delete files outside your project directory. Use at your own risk and only in completely isolated environments.

**Feedback Welcome**: Submit issues or pull requests on GitHub. This framework continues to evolve based on real-world usage patterns.

## 2025-05-23

Initial release of Simone framework
