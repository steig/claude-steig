# Simone Framework Installation Guide

## Quick Install

```bash
# Download and run installer
curl -sSL https://raw.githubusercontent.com/steig/claude-simone/main/install-simone.sh | bash
```

## Manual Install

1. **Download the installer:**
   ```bash
   wget https://raw.githubusercontent.com/steig/claude-simone/main/install-simone.sh
   chmod +x install-simone.sh
   ```

2. **Run the installer:**
   ```bash
   ./install-simone.sh
   ```

## What the Installer Does

### Fresh Installation
- Creates `.simone/` directory structure
- Installs all templates and documentation
- Installs Claude Code commands in `.claude/`
- Creates initial project manifest
- Sets up version tracking

### Smart Upgrades
- Detects existing installations
- Backs up current setup (`.simone.backup.TIMESTAMP/`)
- Preserves all user-created content:
  - Project manifests
  - Milestones and requirements
  - Sprints and tasks
  - Architectural decisions
  - Project reviews
- Updates templates and commands
- Maintains version information

## Installation Options

```bash
# Show help
./install-simone.sh --help

# Show version
./install-simone.sh --version

# Force reinstall
./install-simone.sh --force
```

## What Gets Installed

### Directory Structure
```
.simone/
├── 00_PROJECT_MANIFEST.md          # Project overview (created/preserved)
├── 01_PROJECT_DOCS/                # Project documentation (preserved)
├── 02_REQUIREMENTS/                # Milestones and requirements (preserved)
├── 03_SPRINTS/                     # Sprint execution (preserved)
├── 04_GENERAL_TASKS/               # Non-sprint tasks (preserved)
├── 05_ARCHITECTURAL_DECISIONS/     # ADR documentation (preserved)
├── 10_STATE_OF_PROJECT/            # Project reviews (preserved)
└── 99_TEMPLATES/                   # Templates (updated)
    ├── adr_template.md
    ├── architecture_template.md
    ├── milestone_meta_template.md
    ├── prd_template.md
    ├── project_manifest_template.md
    ├── project_review_template.md
    ├── specs_template.md
    ├── sprint_meta_template.md
    └── task_template.md
```

### Claude Code Commands
```
.claude/
└── commands/
    └── simone/
        ├── initialize.md
        ├── create_general_task.md
        ├── create_sprints_from_milestone.md
        ├── create_sprint_tasks.md
        └── project_review.md
```

## After Installation

1. **Initialize Simone (for new projects):**
   ```bash
   claude code
   # Then use: /project:simone:initialize
   ```

2. **Review your setup:**
   - Check `.simone/00_PROJECT_MANIFEST.md`
   - Read `.simone/CLAUDE.md` for guidance

3. **Start using Simone:**
   - Create milestones: Add folders in `.simone/02_REQUIREMENTS/`
   - Plan sprints: Use `/project:simone:create_sprints_from_milestone`
   - Create tasks: Use `/project:simone:create_general_task`

## Troubleshooting

### Permission Errors
```bash
# Make sure script is executable
chmod +x install-simone.sh
```

### Backup Recovery
If upgrade fails, restore from backup:
```bash
# Find your backup
ls -la .simone.backup.*

# Restore (replace TIMESTAMP with actual backup)
rm -rf .simone
mv .simone.backup.TIMESTAMP .simone
```

### Manual Installation
If the script fails, you can manually copy the framework:
```bash
# Clone repository
git clone https://github.com/steig/claude-workflow.git temp-simone

# Copy framework
cp -r temp-simone/.simone .
cp -r temp-simone/.claude .

# Cleanup
rm -rf temp-simone
```

## Version Management

The installer tracks versions in `.simone/.version`. This enables:
- Smart upgrade detection
- Selective updates
- Rollback capabilities

## Requirements

- **Bash 4.0+** (standard on macOS/Linux)
- **Git** (optional, for cloning repository)
- **curl/wget** (for downloading)

## Support

- **Documentation:** Check `.simone/CLAUDE.md`
- **Issues:** [GitHub Issues](https://github.com/steig/claude-workflow/issues)
- **Updates:** Run installer again to upgrade