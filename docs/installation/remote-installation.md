# Remote Installation Guide

This guide covers installing the Simone Framework directly from the GitHub repository without needing to clone the entire project locally.

## Quick Start

The simplest way to install Simone is using the remote installer:

```bash
# Install in current directory
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash

# Install in a specific directory
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash -s -- /path/to/project
```

## Installation Options

### Basic Remote Installation

```bash
# Current directory
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash

# Specific directory
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash -s -- ~/my-project
```

### Force Remote Installation

If you're running the installer from a local repository but want to fetch the latest version from GitHub:

```bash
# Force remote fetch even from local repo
./install-simone.sh --remote

# Force remote with target directory
./install-simone.sh --remote /path/to/project
```

### Force Reinstallation

To reinstall even if the same version is already present:

```bash
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash -s -- --force
```

## How Remote Installation Works

1. **Automatic Detection**: The installer detects it's running remotely and sets `REMOTE_INSTALL=true`
2. **Repository Cloning**: Creates a temporary directory and clones the repository
3. **Installation**: Runs the normal installation process from the cloned files
4. **Cleanup**: Automatically removes the temporary directory after installation
5. **Version Management**: Sets the version and tracks the installation

## Prerequisites

- **Git**: Required for cloning the repository
- **Bash**: Unix-like shell environment
- **curl**: For downloading the installer script
- **Internet Connection**: To access GitHub

## Supported Platforms

- ✅ **macOS**: Full support
- ✅ **Linux**: Full support (Ubuntu, CentOS, Debian, etc.)
- ✅ **Windows**: WSL (Windows Subsystem for Linux)
- ❌ **Windows**: Native PowerShell (not supported)

## Installation Process

### 1. Environment Detection

The installer automatically detects:
- Project type (Node.js, Python, Rust, etc.)
- Existing Simone installations
- Installation method (remote vs local)

### 2. Smart Installation Logic

**Fresh Installation**:
- Creates complete `.simone/` directory structure
- Installs all templates and documentation
- Sets up Claude Code commands in `.claude/`
- Creates initial project manifest

**Upgrade Detection**:
- Compares installed version with current version
- Preserves all user data during upgrades
- Creates backup before making changes
- Only updates framework files, not user content

### 3. What Gets Installed

**Core Structure**:
```
.simone/
├── 00_PROJECT_MANIFEST.md      # Auto-generated project overview
├── 01_PROJECT_DOCS/            # Project documentation
├── 02_REQUIREMENTS/            # Requirements and specifications  
├── 03_SPRINTS/                 # Sprint planning and execution
├── 04_GENERAL_TASKS/           # General task management
├── 05_ARCHITECTURAL_DECISIONS/ # Architecture Decision Records
├── 10_STATE_OF_PROJECT/        # Project health and reviews
└── 99_TEMPLATES/               # All Simone templates

.claude/
├── commands/
│   └── simone/                 # 23+ Simone commands
└── CLAUDE.md                   # Claude Code instructions
```

**Templates Installed** (14 templates):
- Project manifest templates
- Task and sprint templates
- Architecture decision templates
- Quality assurance templates
- DevOps and deployment templates

**Commands Installed** (23+ commands):
- Project initialization and management
- Sprint and task execution
- Code review and quality gates
- Architecture and planning tools

## Verification

After installation, verify it worked correctly:

```bash
# Check version
cat .simone/.version

# Verify structure
ls -la .simone/
ls -la .claude/commands/simone/

# Test command availability (in Claude Code)
/project:simone:status
```

## Troubleshooting

### Common Issues

**1. "Command not found" errors**
```bash
# Ensure you have the required tools
which git curl bash

# On macOS, install command line tools if needed
xcode-select --install
```

**2. "Permission denied" errors**
```bash
# Check directory permissions
ls -la $(dirname "$(pwd)")

# Create directory if needed
mkdir -p /path/to/project
cd /path/to/project
```

**3. "Failed to clone repository" errors**
```bash
# Test GitHub connectivity
curl -I https://github.com/steig/claude-steig

# Check git configuration
git config --list
```

**4. Installation appears to hang**
```bash
# The installer might be waiting for input
# Press Enter or answer the prompts

# For non-interactive installation, you can use --force
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash -s -- --force
```

### Network Issues

If you're behind a corporate firewall or proxy:

```bash
# Configure git to use proxy
git config --global http.proxy http://proxy.company.com:8080

# Test repository access
git ls-remote https://github.com/steig/claude-steig
```

### Verbose Installation

For debugging, you can download and run the script manually:

```bash
# Download the script
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh > install-simone.sh

# Make it executable  
chmod +x install-simone.sh

# Run with bash debugging
bash -x ./install-simone.sh
```

## Security Considerations

### Script Verification

The remote installation downloads and executes a script from GitHub. For security-conscious environments:

1. **Review the script** before running:
   ```bash
   curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | less
   ```

2. **Download and inspect** before executing:
   ```bash
   curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh > install-simone.sh
   # Review the script
   cat install-simone.sh
   # Run if satisfied
   bash install-simone.sh
   ```

3. **Verify checksums** (advanced):
   ```bash
   # Get the current commit hash
   curl -sSL https://api.github.com/repos/steig/claude-steig/commits/master | jq -r '.sha'
   
   # Verify it matches your expectations
   ```

### What the Script Does

The installer only:
- ✅ Creates directories and files within your project
- ✅ Downloads framework files from the official repository
- ✅ Sets file permissions appropriately
- ❌ Does not modify system files or global configuration
- ❌ Does not require sudo/administrator privileges
- ❌ Does not install system packages or dependencies

## Advanced Usage

### Custom Installation Paths

```bash
# Install to a non-standard location
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash -s -- ~/Documents/my-projects/new-project

# The installer will create the directory if it doesn't exist
```

### Integration with CI/CD

For automated environments:

```bash
#!/bin/bash
# Automated setup script

set -e

# Create project directory
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Create basic project files
echo '{"name": "'$PROJECT_NAME'"}' > package.json

# Install Simone non-interactively
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash -s -- --force

# Verify installation
test -f .simone/.version || exit 1
echo "Simone installed successfully: $(cat .simone/.version)"
```

### Multiple Project Setup

```bash
# Install to multiple projects
for project in project1 project2 project3; do
    echo "Installing Simone to $project..."
    curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash -s -- "./$project"
done
```

## Migration from Local Installation

If you previously installed Simone locally and want to use remote installation:

```bash
# The installer will automatically upgrade
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/master/install-simone.sh | bash

# Your user data is preserved during the upgrade
# Check backup directory if created: .simone.backup.TIMESTAMP/
```

## Support

For installation issues:

1. **Check the troubleshooting section** above
2. **Review the installation logs** for error messages
3. **Verify prerequisites** are installed and working
4. **Test with a simple project** in a clean directory
5. **Open an issue** on GitHub with full error details

---

**Next Steps**: After successful installation, see the [Getting Started Guide](../getting-started/quick-start.md) to begin using Simone in your project.