# Installation Guide

Complete guide to installing and setting up the Simone Framework.

## Prerequisites

- Git installed on your system
- A project directory (optional - Simone can be installed anywhere)
- Basic familiarity with command line tools
- Internet connection (for remote installation)

## Quick Installation

### Option 1: Local Installation (Current Method)

**Note**: This version of Simone is currently distributed as a local framework. Remote installation via GitHub is planned for future releases.

```bash
# Clone or download the Simone framework
git clone [repository-url] claude-simone
cd claude-simone

# Install in current directory  
./install-simone.sh

# Or install in a specific project directory
./install-simone.sh /path/to/your/project

# Force reinstallation
./install-simone.sh --force

# Show version information
./install-simone.sh --version
```

### Option 2: Copy Framework to Project

For existing projects, copy the framework structure:

```bash
# Copy Simone framework to your project
cp -r /path/to/claude-simone/.simone /path/to/your/project/
cp /path/to/claude-simone/simone /path/to/your/project/

# Make the script executable
chmod +x /path/to/your/project/simone

# Initialize with quality enforcement
cd /path/to/your/project
./simone init
```

The installer will:
- Create the `.simone/` directory structure with quality enforcement
- Copy all templates and configuration files (19 templates available)
- Set up command integration with Claude Code (47 commands)
- Install quality validation system with lazy pattern detection
- Create an initial project manifest with quality requirements
- Detect if upgrading and preserve your data
- Enable progressive quality restrictions and scoring

## Installation Options

### Command Line Options

```bash
./install-simone.sh [options] [target_directory]

Options:
  --help, -h     Show help message
  --force        Force reinstall even if up to date
  --version      Show version information  
  --remote       Force remote installation (fetch from GitHub)

Examples:
  ./install-simone.sh                      # Install in current directory
  ./install-simone.sh ./my-project         # Install in ./my-project
  ./install-simone.sh --force              # Force reinstall
  ./install-simone.sh --remote /tmp/test   # Remote install to /tmp/test
```

### Install to Current Directory

```bash
cd your-project

# Remote install (recommended)
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash

# Local install from cloned repo
/path/to/claude-steig/install-simone.sh
```

This creates a `.simone/` folder in your current project directory.

### Install to Specific Directory

```bash
# Remote install to specific path
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash -s -- /path/to/project

# Local install to absolute path
./install-simone.sh /Users/username/my-project

# Local install to relative path
./install-simone.sh ./my-new-project

# Create new directory and install
./install-simone.sh ~/Documents/new-project
```

### Force Reinstall

If you need to reinstall over an existing installation:

```bash
# Remote force reinstall
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash -s -- --force

# Local force reinstall
./install-simone.sh --force /path/to/existing-project
```

⚠️ **Warning**: Force reinstall will backup existing data but replace all system files.

## What Gets Installed

### Directory Structure

```
your-project/
├── .simone/
│   ├── 00_PROJECT_MANIFEST.md          # Project overview and status
│   ├── 01_PROJECT_DOCS/                # Project documentation
│   ├── 02_REQUIREMENTS/                 # Requirements and specifications
│   ├── 03_SPRINTS/                      # Sprint planning and execution
│   ├── 04_GENERAL_TASKS/                # Individual tasks and todos
│   ├── 05_ARCHITECTURAL_DECISIONS/      # ADRs and design decisions
│   ├── 10_STATE_OF_PROJECT/             # Project reviews and retrospectives
│   └── 99_TEMPLATES/                    # All available templates
└── .claude/
    └── commands/
        └── simone/                     # 23 Simone-specific commands
```

### Features Included

**14 Templates** covering:
- Task management with YAML frontmatter
- Sprint planning and execution
- Architecture decision records (ADRs)
- Quality assurance and code reviews
- DevOps workflows and deployment
- Project reviews and retrospectives

**23 Commands** for Claude Code:
- `/project:simone:initialize` - Project setup
- `/project:simone:create_milestone` - Milestone creation
- `/project:simone:plan_sprint` - Sprint planning
- `/project:simone:do_task` - Task execution
- And 19 more specialized commands

**CLAUDE.md Context Files**:
- Each directory includes instructions for Claude
- Provides context about directory purpose
- Ensures consistent AI assistance

## Verification

### Check Installation

```bash
# Verify directory structure
ls -la .simone/

# Check version
cat .simone/.version

# List available templates
ls .simone/99_TEMPLATES/
```

### Test Claude Integration

1. Open Claude Code in your project directory
2. Try creating a new task: `Create a task for implementing user authentication`
3. Claude should automatically use Simone templates and structure

## Upgrading

### Automatic Upgrade Detection

The installer automatically detects existing installations and preserves your data:

```bash
# Run installer again to upgrade
./install-simone.sh
```

The upgrade process:
1. Backs up your existing installation
2. Preserves all user-created content
3. Updates system files and templates
4. Maintains your project data

### Manual Backup

For extra safety, manually backup your `.simone/` directory:

```bash
cp -r .simone .simone.backup.$(date +%Y%m%d)
```

## Troubleshooting

### Permission Issues

```bash
# Make installer executable (local install)
chmod +x install-simone.sh

# For permission errors during remote install
sudo curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | sudo bash
```

### Git Not Found

```bash
# Install git first
# macOS
brew install git

# Ubuntu/Debian
sudo apt-get update && sudo apt-get install git

# Windows (use Git Bash or WSL)
# Download from https://git-scm.com
```

### Behind Corporate Proxy

```bash
# Set proxy environment variables
export HTTP_PROXY=http://proxy.company.com:8080
export HTTPS_PROXY=http://proxy.company.com:8080

# Then run installation
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash
```

### Directory Already Exists

```bash
# Use force flag to overwrite
./install-simone.sh --force

# Or manually remove and reinstall
rm -rf .simone
./install-simone.sh
```

### Version Conflicts

```bash
# Check current version
cat .simone/.version

# Force upgrade to latest
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash -s -- --force
```

### Installation Verification Failed

```bash
# Verify installation manually
ls -la .simone/
ls -la .claude/commands/simone/

# Check for specific files
test -f .simone/00_PROJECT_MANIFEST.md && echo "✓ Manifest exists" || echo "✗ Manifest missing"
test -d .simone/99_TEMPLATES && echo "✓ Templates exist" || echo "✗ Templates missing"
```

## Uninstallation

To remove Simone from a project:

```bash
# Remove the entire .simone directory
rm -rf .simone
```

⚠️ **Warning**: This removes all your project data, sprints, tasks, and documentation.

## Next Steps

After installation:

1. **Review the Project Manifest**: Check `.simone/00_PROJECT_MANIFEST.md`
2. **Explore Templates**: Browse `.simone/99_TEMPLATES/` 
3. **Read the Quick Start**: See [quick-start.md](quick-start.md)
4. **Set up your first sprint**: Follow [sprint-execution.md](../workflows/sprint-execution.md)

## Support

- **GitHub Issues**: [Report problems](https://github.com/steig/claude-steig/issues)
- **Documentation**: See [framework overview](framework-overview.md)
- **Templates**: Reference [template catalog](../templates/template-catalog.md)
- **Discussions**: [Community forum](https://github.com/steig/claude-steig/discussions)

## Version Information

- **Current Version**: 3.1.0
- **Minimum Claude Code Version**: Latest stable release
- **Repository**: https://github.com/steig/claude-steig