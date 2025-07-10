# Installation Guide

Complete guide to installing and setting up the Simone Framework.

## Prerequisites

- Git installed on your system
- A project directory (optional - Simone can be installed anywhere)
- Basic familiarity with command line tools

## Quick Installation

### 1. Clone the Repository

```bash
git clone https://github.com/steig/claude-steig.git
cd claude-steig
```

### 2. Run the Installer

```bash
# Install in current directory
./install-simone.sh

# Or install in a specific project directory
./install-simone.sh /path/to/your/project
```

The installer will:
- Create the `.simone/` directory structure
- Copy all templates and configuration files
- Set up command integration with Claude
- Create an initial project manifest

## Installation Options

### Install to Current Directory

```bash
cd your-project
/path/to/claude-steig/install-simone.sh
```

This creates a `.simone/` folder in your current project directory.

### Install to Specific Directory

```bash
# Install to absolute path
./install-simone.sh /Users/username/my-project

# Install to relative path
./install-simone.sh ./my-new-project

# Create new directory and install
./install-simone.sh ~/Documents/new-project
```

### Force Reinstall

If you need to reinstall over an existing installation:

```bash
./install-simone.sh --force /path/to/existing-project
```

⚠️ **Warning**: Force reinstall will backup existing data but replace all system files.

## What Gets Installed

### Directory Structure

```
.simone/
├── 00_PROJECT_MANIFEST.md          # Project overview and status
├── 01_PROJECT_DOCS/                # Project documentation
├── 02_REQUIREMENTS/                 # Requirements and specifications
├── 03_SPRINTS/                      # Sprint planning and execution
├── 04_GENERAL_TASKS/                # Individual tasks and todos
├── 05_ARCHITECTURAL_DECISIONS/      # ADRs and design decisions
├── 10_STATE_OF_PROJECT/             # Project reviews and retrospectives
└── 99_TEMPLATES/                    # All available templates
```

### Templates Installed

The installer copies 14+ templates including:
- Project planning templates
- Sprint execution templates
- Task management templates
- Quality assurance templates
- DevOps workflow templates

### Claude Integration

Each directory includes a `CLAUDE.md` file that provides Claude with:
- Context about the directory's purpose
- Instructions for working with files in that directory
- Templates and patterns to follow

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
# Make installer executable
chmod +x install-simone.sh

# Run with sudo if needed (not recommended)
sudo ./install-simone.sh
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

# Clean install if needed
rm -rf .simone
./install-simone.sh
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