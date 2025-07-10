#!/bin/bash

# Simone Framework Installer/Upgrader
# Intelligently installs or upgrades the Simone project management framework

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SIMONE_REPO="https://github.com/steig/claude-steig"
SIMONE_DIR=".simone"
BACKUP_DIR=".simone.backup.$(date +%Y%m%d_%H%M%S)"
VERSION_FILE="$SIMONE_DIR/.version"
CURRENT_VERSION="2.0.2"
TARGET_DIR=""

# Utility functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Check if we're in a project directory
check_project_directory() {
    if [[ ! -f "package.json" && ! -f "requirements.txt" && ! -f "composer.json" && ! -f "Cargo.toml" && ! -f "go.mod" && ! -f ".git" ]]; then
        warn "This doesn't appear to be a project directory."
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log "Installation cancelled."
            exit 0
        fi
    fi
}

# Change to target directory if specified
change_to_target_directory() {
    if [[ -n "$TARGET_DIR" ]]; then
        # Create target directory if it doesn't exist
        mkdir -p "$TARGET_DIR"
        
        # Convert to absolute path and change to it
        local abs_target_dir=$(cd "$TARGET_DIR" && pwd)
        log "Installing to directory: $abs_target_dir"
        cd "$abs_target_dir"
    else
        log "Installing to current directory: $(pwd)"
    fi
}

# Detect current installation status
detect_installation() {
    if [[ -d "$SIMONE_DIR" ]]; then
        if [[ -f "$VERSION_FILE" ]]; then
            INSTALLED_VERSION=$(cat "$VERSION_FILE")
            log "Found Simone installation version: $INSTALLED_VERSION"
            return 0
        else
            log "Found legacy Simone installation (no version file)"
            INSTALLED_VERSION="legacy"
            return 0
        fi
    else
        log "No existing Simone installation found"
        INSTALLED_VERSION=""
        return 1
    fi
}

# Backup existing installation
backup_installation() {
    if [[ -d "$SIMONE_DIR" ]]; then
        log "Creating backup of existing installation..."
        cp -r "$SIMONE_DIR" "$BACKUP_DIR"
        success "Backup created at $BACKUP_DIR"
    fi
}

# Download and extract Simone framework
download_simone() {
    local temp_dir=$(mktemp -d)
    
    log "Downloading Simone framework..."
    
    # Try git clone first, fallback to curl if needed
    if command -v git &> /dev/null; then
        git clone --depth 1 "$SIMONE_REPO" "$temp_dir" 2>/dev/null || {
            warn "Git clone failed, trying direct download..."
            download_simone_curl "$temp_dir"
        }
    else
        download_simone_curl "$temp_dir"
    fi
    
    echo "$temp_dir"
}

# Fallback download method using curl
download_simone_curl() {
    local temp_dir="$1"
    # This would need to be updated based on your actual hosting
    curl -L -o "$temp_dir/simone.zip" "https://github.com/steig/claude-steig/archive/main.zip"
    unzip -q "$temp_dir/simone.zip" -d "$temp_dir"
    mv "$temp_dir"/claude-steig-main/* "$temp_dir/"
}

# Install core Simone structure
install_core_structure() {
    local source_dir="$1"
    
    log "Installing core Simone structure..."
    
    # Create main directories
    mkdir -p "$SIMONE_DIR"/{01_PROJECT_DOCS,02_REQUIREMENTS,03_SPRINTS,04_GENERAL_TASKS,05_ARCHITECTURAL_DECISIONS,10_STATE_OF_PROJECT,99_TEMPLATES}
    
    # Copy templates
    if [[ -d "$source_dir/.simone/99_TEMPLATES" ]]; then
        cp -r "$source_dir/.simone/99_TEMPLATES/"* "$SIMONE_DIR/99_TEMPLATES/"
        success "Templates installed"
    fi
    
    # Copy CLAUDE.md instruction files
    local claude_files=(
        "CLAUDE.md"
        "01_PROJECT_DOCS/CLAUDE.md"
        "02_REQUIREMENTS/CLAUDE.md"
        "03_SPRINTS/CLAUDE.MD"
        "04_GENERAL_TASKS/CLAUDE.MD"
        "05_ARCHITECTURAL_DECISIONS/CLAUDE.md"
        "10_STATE_OF_PROJECT/CLAUDE.md"
    )
    
    for file in "${claude_files[@]}"; do
        local source_file="$source_dir/.simone/$file"
        local dest_file="$SIMONE_DIR/$file"
        
        if [[ -f "$source_file" ]]; then
            mkdir -p "$(dirname "$dest_file")"
            cp "$source_file" "$dest_file"
        fi
    done
    
    success "Core structure installed"
}

# Install Claude Code commands
install_commands() {
    local source_dir="$1"
    
    log "Checking for Claude Code commands in: $source_dir/.claude"
    
    if [[ -d "$source_dir/.claude" ]]; then
        log "Installing Claude Code commands..."
        
        # Create .claude directory if it doesn't exist
        mkdir -p .claude
        
        # Copy commands, preserving existing ones
        if [[ -d "$source_dir/.claude/commands" ]]; then
            mkdir -p .claude/commands
            # Use more robust copying with error checking
            if cp -r "$source_dir/.claude/commands/"* .claude/commands/ 2>/dev/null; then
                success "Claude Code commands installed"
            else
                warn "Failed to copy some Claude Code commands, attempting individual copy..."
                # Try copying each subdirectory individually
                for cmd_dir in "$source_dir/.claude/commands/"*; do
                    if [[ -d "$cmd_dir" ]]; then
                        local cmd_name=$(basename "$cmd_dir")
                        mkdir -p ".claude/commands/$cmd_name"
                        cp -r "$cmd_dir/"* ".claude/commands/$cmd_name/" 2>/dev/null || warn "Failed to copy $cmd_name commands"
                    fi
                done
                success "Claude Code commands installed (with warnings)"
            fi
        else
            warn "No Claude Code commands found in source"
        fi
        
        # Copy other .claude files
        local claude_files=("CLAUDE.md")
        for file in "${claude_files[@]}"; do
            if [[ -f "$source_dir/.claude/$file" ]]; then
                cp "$source_dir/.claude/$file" ".claude/$file"
            fi
        done
    fi
}

# Upgrade existing installation
upgrade_installation() {
    log "Upgrading existing Simone installation..."
    
    # Download new version
    local temp_dir=$(download_simone)
    
    # Backup current installation
    backup_installation
    
    # Preserve user data during upgrade
    preserve_user_data() {
        local backup_manifest=""
        local backup_docs=""
        local backup_requirements=""
        local backup_sprints=""
        local backup_tasks=""
        local backup_adrs=""
        local backup_reviews=""
        
        # Backup user-created content
        [[ -f "$SIMONE_DIR/00_PROJECT_MANIFEST.md" ]] && backup_manifest=$(cat "$SIMONE_DIR/00_PROJECT_MANIFEST.md")
        [[ -d "$SIMONE_DIR/01_PROJECT_DOCS" ]] && backup_docs="$SIMONE_DIR/01_PROJECT_DOCS"
        [[ -d "$SIMONE_DIR/02_REQUIREMENTS" ]] && backup_requirements="$SIMONE_DIR/02_REQUIREMENTS"
        [[ -d "$SIMONE_DIR/03_SPRINTS" ]] && backup_sprints="$SIMONE_DIR/03_SPRINTS"
        [[ -d "$SIMONE_DIR/04_GENERAL_TASKS" ]] && backup_tasks="$SIMONE_DIR/04_GENERAL_TASKS"
        [[ -d "$SIMONE_DIR/05_ARCHITECTURAL_DECISIONS" ]] && backup_adrs="$SIMONE_DIR/05_ARCHITECTURAL_DECISIONS"
        [[ -d "$SIMONE_DIR/10_STATE_OF_PROJECT" ]] && backup_reviews="$SIMONE_DIR/10_STATE_OF_PROJECT"
        
        # Install new version
        install_core_structure "$temp_dir"
        install_commands "$temp_dir"
        
        # Restore user content
        [[ -n "$backup_manifest" ]] && echo "$backup_manifest" > "$SIMONE_DIR/00_PROJECT_MANIFEST.md"
        
        # Restore directories, preserving CLAUDE.md files
        for dir in "$backup_docs" "$backup_requirements" "$backup_sprints" "$backup_tasks" "$backup_adrs" "$backup_reviews"; do
            if [[ -d "$dir" ]]; then
                local target_dir="$SIMONE_DIR/$(basename "$dir")"
                # Copy user files, skip CLAUDE.md files (use new versions)
                find "$dir" -type f ! -name "CLAUDE.md" ! -name "CLAUDE.MD" -exec cp {} "$target_dir/" \; 2>/dev/null || true
            fi
        done
    }
    
    preserve_user_data
    
    # Cleanup
    rm -rf "$temp_dir"
    
    success "Upgrade completed successfully!"
}

# Fresh installation
fresh_installation() {
    log "Performing fresh Simone installation..."
    
    # Download Simone
    local temp_dir=$(download_simone)
    
    # Install everything
    install_core_structure "$temp_dir"
    install_commands "$temp_dir"
    
    # Create initial project manifest
    create_initial_manifest
    
    # Cleanup
    rm -rf "$temp_dir"
    
    success "Fresh installation completed successfully!"
}

# Create initial project manifest
create_initial_manifest() {
    local manifest_file="$SIMONE_DIR/00_PROJECT_MANIFEST.md"
    
    if [[ ! -f "$manifest_file" ]]; then
        log "Creating initial project manifest..."
        
        # Detect project name
        local project_name="Unknown Project"
        if [[ -f "package.json" ]]; then
            project_name=$(grep '"name"' package.json | head -1 | cut -d'"' -f4 2>/dev/null || echo "Unknown Project")
        elif [[ -f "Cargo.toml" ]]; then
            project_name=$(grep '^name = ' Cargo.toml | head -1 | cut -d'"' -f2 2>/dev/null || echo "Unknown Project")
        elif [[ -d ".git" ]]; then
            project_name=$(basename "$(git remote get-url origin 2>/dev/null || pwd)" .git 2>/dev/null || basename "$(pwd)")
        else
            project_name=$(basename "$(pwd)")
        fi
        
        # Use project manifest template
        local template_file="$SIMONE_DIR/99_TEMPLATES/project_manifest_template.md"
        if [[ -f "$template_file" ]]; then
            cp "$template_file" "$manifest_file"
            # Replace placeholders
            sed -i.bak "s/{PROJECT_NAME}/$project_name/g" "$manifest_file" 2>/dev/null || true
            sed -i.bak "s/{CREATED_DATE}/$(date '+%Y-%m-%d')/g" "$manifest_file" 2>/dev/null || true
            sed -i.bak "s/{UPDATED_DATE}/$(date '+%Y-%m-%d %H:%M:%S')/g" "$manifest_file" 2>/dev/null || true
            rm -f "$manifest_file.bak" 2>/dev/null || true
        fi
        
        success "Initial project manifest created"
    fi
}

# Set version
set_version() {
    echo "$CURRENT_VERSION" > "$VERSION_FILE"
    log "Version set to $CURRENT_VERSION"
}

# Main installation logic
main() {
    echo "🚀 Simone Framework Installer/Upgrader v$CURRENT_VERSION"
    echo "=================================================="
    
    # Change to target directory first
    change_to_target_directory
    
    check_project_directory
    
    if detect_installation; then
        if [[ "$INSTALLED_VERSION" == "$CURRENT_VERSION" ]]; then
            success "Simone v$CURRENT_VERSION is already installed and up to date!"
            read -p "Force reinstall? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                upgrade_installation
            else
                exit 0
            fi
        else
            log "Upgrade available: $INSTALLED_VERSION → $CURRENT_VERSION"
            read -p "Proceed with upgrade? (Y/n): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                log "Upgrade cancelled."
                exit 0
            fi
            upgrade_installation
        fi
    else
        log "Installing Simone framework for the first time..."
        fresh_installation
    fi
    
    set_version
    
    echo
    echo "🎉 Simone Framework Setup Complete!"
    echo "======================================"
    echo
    echo "Installation location: $(pwd)"
    echo
    echo "Next steps:"
    echo "1. Review: $SIMONE_DIR/00_PROJECT_MANIFEST.md"
    echo "2. Initialize: Run 'claude code' and use /project:simone:initialize"
    echo "3. Documentation: Check $SIMONE_DIR/CLAUDE.md for guidance"
    echo
    echo "For help: https://github.com/your-repo/claude-steig"
    
    if [[ -d "$BACKUP_DIR" ]]; then
        echo
        echo "💾 Backup saved at: $BACKUP_DIR"
        echo "   (Safe to delete after verifying the upgrade)"
    fi
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Simone Framework Installer/Upgrader"
        echo
        echo "Usage: $0 [options] [target_directory]"
        echo
        echo "Arguments:"
        echo "  target_directory   Directory to install Simone framework (optional)"
        echo "                     If not specified, installs in current directory"
        echo
        echo "Options:"
        echo "  --help, -h         Show this help message"
        echo "  --force            Force reinstall even if up to date"
        echo "  --version          Show version information"
        echo
        echo "Examples:"
        echo "  $0                           # Install in current directory"
        echo "  $0 /path/to/project         # Install in specified directory"
        echo "  $0 --force ./my-project     # Force reinstall in ./my-project"
        echo
        echo "The script automatically detects existing installations and upgrades smartly."
        exit 0
        ;;
    --version)
        echo "Simone Framework Installer v$CURRENT_VERSION"
        exit 0
        ;;
    --force)
        FORCE_INSTALL=true
        # Check if next argument is a directory
        if [[ -n "$2" && "$2" != --* ]]; then
            TARGET_DIR="$2"
        fi
        ;;
    --*)
        error "Unknown option: $1. Use --help for usage information."
        ;;
    *)
        # First non-option argument is target directory
        if [[ -n "$1" ]]; then
            TARGET_DIR="$1"
        fi
        ;;
esac

# Run main installation
main "$@"