# Simone

A progressive task management framework that adapts to your project's complexity.

## Overview

Simone is a file-based task management system designed for software development teams. It starts with just 5 essential commands and can scale to comprehensive project management when needed. Built specifically for AI-assisted development workflows, particularly with Claude Code.

**Core Design**: Tasks are markdown files, organization is folders, and complexity is opt-in.

## Attribution

- **Original Framework**: Based on [Simone](https://github.com/helmi/simone) by Helmi, which established the foundational directory-based project management concepts
- **Inspiration**: Command patterns and cognitive personas inspired by [SuperClaude](https://github.com/NomenAK/SuperClaude), providing AI-driven development workflows

## Installation

```bash
# Quick install (30 seconds)
curl -sSL https://raw.githubusercontent.com/yourusername/simone/main/install-simone.sh | bash

# Or clone and install
git clone https://github.com/yourusername/simone
cd simone
./install-simone.sh
```

## Quick Start

```bash
# Basic workflow
simone add "Implement user authentication"    # Create task
simone list                                   # View tasks
simone done 1234567                          # Complete task
simone note "API uses JWT tokens"            # Save knowledge
simone find "auth"                           # Search everything
```

## Progressive Complexity

Simone adapts to your needs through optional modes:

### 🟢 Simple Mode (Default)
- 5 commands: `add`, `list`, `done`, `note`, `find`
- Flat task structure
- No configuration required

### 🔵 Organize Mode
```bash
simone enable organize
```
- Adds priority levels (urgent/normal/backlog)
- Monthly archive organization
- Task statistics and reporting

### 🟣 Team Mode
```bash
simone enable team
```
- Task assignments with `@mentions`
- Daily standup views
- Sprint support

### ⚫ Full Mode
```bash
simone enable full
```
- Complete project management framework
- 40+ specialized commands
- Quality gates and workflows
- Comprehensive metadata tracking

## Key Features

### 📁 File-Based Architecture
- Tasks are markdown files
- No database dependencies
- Git-friendly versioning
- Direct file access when needed

### 🤖 AI-Native Design
- Optimized for Claude Code integration
- Clear, parseable task structure
- Minimal metadata overhead
- Natural language friendly

### 🔄 Data Portability
- Export to JSON, CSV, Markdown
- No vendor lock-in
- Standard markdown format
- Easy migration paths

### ⚡ Performance Focus
- Instant task creation (<0.1s)
- No network dependencies
- Lightweight file operations
- Scales to thousands of tasks

## Documentation

- **[Getting Started](docs/README.md)** - Installation and basic usage
- **[How It Works](docs/HOW-IT-WORKS.md)** - Core concepts and architecture
- **[Command Reference](docs/COMMANDS.md)** - All commands with examples
- **[Examples](docs/EXAMPLES.md)** - Real-world usage patterns
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and solutions
- **[Migration Guide](docs/MIGRATION-GUIDE.md)** - For existing Simone users
- **[Philosophy](docs/PHILOSOPHY.md)** - Design principles and rationale

## For Existing Simone Users

If you're using the original Simone framework with full complexity:

```bash
# Analyze current structure
simone-migrate --analyze

# Migrate to appropriate complexity level
simone-migrate

# Or maintain full compatibility
simone-migrate --force-full
```

## Project Structure

```
.simone/
├── tasks/       # Active tasks
├── done/        # Completed tasks
└── notes/       # Project knowledge

# With progressive modes enabled:
├── tasks/
│   ├── urgent/      # organize mode
│   ├── normal/      # organize mode
│   ├── backlog/     # organize mode
│   └── @person/     # team mode
└── sprints/         # team mode
```

## Integration

### Claude Code Commands
Simone includes Claude Code integration for AI-assisted task management:

```bash
/project:simone:do_task 1234567       # AI task execution
/project:simone:create_pr             # Pull request automation
/project:simone:review                # Code review assistance
```

### Version Control
```bash
# Recommended .gitignore entries
.simone/.cache/
.simone/done/        # Optional: exclude completed tasks
```

## Requirements

- Bash 4.0+
- Git (for version control integration)
- Claude Code (for AI features)
- Docker (optional, for MCP servers)

## Development Status

Simone is actively maintained with regular updates. The framework is used in production by multiple teams but should be evaluated for your specific needs.

### Version History
- **v3.x** - Progressive complexity system
- **v2.x** - Enhanced metadata and tracking
- **v1.x** - Original framework structure

## Contributing

Contributions are welcome. Please review existing documentation and maintain compatibility with the progressive complexity system.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: See [docs/](docs/) directory
- **Issues**: GitHub issue tracker
- **Discussions**: GitHub discussions for questions and ideas

---

*Simone is designed to start simple and grow with your project's needs. Begin with basic task tracking and add complexity only when your team requires it.*