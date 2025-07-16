#!/bin/bash

# Simone Framework Installer and Upgrade Tool - Security Hardened Version
# Intelligently installs or upgrades the Simone project management framework

# Strict error handling and security settings
set -euo pipefail
IFS=$'\n\t'

# Security: Ensure clean environment
unset CDPATH
export PATH="/usr/local/bin:/usr/bin:/bin"

# Validate we're running in a safe environment
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# Create secure temporary directory
readonly TEMP_DIR="$(mktemp -d -t simone-install.XXXXXXXXXX)"
trap 'rm -rf "$TEMP_DIR"' EXIT INT TERM

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configuration with input validation
readonly SIMONE_REPO="https://github.com/steig/claude-steig"
readonly SIMONE_DIR=".simone"
readonly VERSION_FILE="$SIMONE_DIR/.version"
readonly CURRENT_VERSION="3.0.0"

# Global variables (will be validated)
TARGET_DIR=""
REMOTE_INSTALL=false
INSTALLED_VERSION=""

# Input validation functions
validate_path() {
    local path="$1"
    local context="$2"
    
    # Check for null bytes and dangerous characters
    if [[ "$path" =~ $'\0' ]]; then
        error "Invalid path in $context: contains null bytes"
    fi
    
    # Check for relative path traversal
    if [[ "$path" =~ \.\./|\.\.\\ ]]; then
        error "Invalid path in $context: path traversal detected"
    fi
    
    # Ensure path is reasonable length
    if [[ ${#path} -gt 255 ]]; then
        error "Invalid path in $context: path too long (max 255 characters)"
    fi
    
    # Additional checks for special characters that could be dangerous
    if [[ "$path" =~ [;&\|`\$\(\)] ]]; then
        error "Invalid path in $context: contains dangerous characters"
    fi
}

validate_version() {
    local version="$1"
    if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+)?$ ]]; then
        error "Invalid version format: $version"
    fi
}

validate_directory_name() {
    local name="$1"
    if [[ ! "$name" =~ ^[a-zA-Z0-9._-]+$ ]]; then
        error "Invalid directory name: $name"
    fi
}

# Secure logging functions
log() {
    printf '%s[INFO]%s %s\n' "$BLUE" "$NC" "$1" >&2
}

success() {
    printf '%s[SUCCESS]%s %s\n' "$GREEN" "$NC" "$1" >&2
}

warn() {
    printf '%s[WARNING]%s %s\n' "$YELLOW" "$NC" "$1" >&2
}

error() {
    printf '%s[ERROR]%s %s\n' "$RED" "$NC" "$1" >&2
    exit 1
}

# Secure file operations
secure_copy() {
    local src="$1"
    local dest="$2"
    
    # Validate inputs
    validate_path "$src" "source"
    validate_path "$dest" "destination"
    
    # Check source exists and is readable
    if [[ ! -r "$src" ]]; then
        error "Source file not readable: $src"
    fi
    
    # Check destination directory exists and is writable
    local dest_dir
    dest_dir="$(dirname "$dest")"
    if [[ ! -w "$dest_dir" ]]; then
        error "Destination directory not writable: $dest_dir"
    fi
    
    # Perform copy with error checking
    if ! cp "$src" "$dest"; then
        error "Failed to copy $src to $dest"
    fi
}

secure_mkdir() {
    local dir="$1"
    validate_path "$dir" "mkdir"
    
    if ! mkdir -p "$dir"; then
        error "Failed to create directory: $dir"
    fi
}

# Check if we're in a project directory
check_project_directory() {
    local project_indicators=(
        "package.json"
        "requirements.txt" 
        "composer.json"
        "Cargo.toml"
        "go.mod"
        ".git"
        "pom.xml"
        "Gemfile"
        "CMakeLists.txt"
    )
    
    local found=false
    for indicator in "${project_indicators[@]}"; do
        if [[ -f "$indicator" || -d "$indicator" ]]; then
            found=true
            break
        fi
    done
    
    if [[ "$found" == false ]]; then
        warn "This doesn't appear to be a project directory."
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log "Installation cancelled."
            exit 0
        fi
    fi
}

# Securely change to target directory
change_to_target_directory() {
    if [[ -n "$TARGET_DIR" ]]; then
        validate_path "$TARGET_DIR" "target directory"
        
        # Create target directory if it doesn't exist
        secure_mkdir "$TARGET_DIR"
        
        # Get absolute path safely
        local abs_target_dir
        if ! abs_target_dir="$(cd "$TARGET_DIR" && pwd -P)"; then
            error "Failed to resolve absolute path for: $TARGET_DIR"
        fi
        
        log "Installing to directory: $abs_target_dir"
        
        # Change to directory safely
        if ! cd "$abs_target_dir"; then
            error "Failed to change to directory: $abs_target_dir"
        fi
    else
        local current_dir
        current_dir="$(pwd -P)"
        log "Installing to current directory: $current_dir"
    fi
}

# Detect current installation status
detect_installation() {
    if [[ -d "$SIMONE_DIR" ]]; then
        if [[ -f "$VERSION_FILE" ]]; then
            if [[ -r "$VERSION_FILE" ]]; then
                INSTALLED_VERSION="$(cat "$VERSION_FILE")"
                validate_version "$INSTALLED_VERSION"
                log "Found Simone installation version: $INSTALLED_VERSION"
                return 0
            else
                error "Version file exists but is not readable: $VERSION_FILE"
            fi
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

# Secure backup function
backup_installation() {
    if [[ -d "$SIMONE_DIR" ]]; then
        local backup_dir
        backup_dir=".simone.backup.$(date +%Y%m%d_%H%M%S)"
        validate_directory_name "$(basename "$backup_dir")"
        
        log "Creating backup of existing installation..."
        
        if ! cp -r "$SIMONE_DIR" "$backup_dir"; then
            error "Failed to create backup directory: $backup_dir"
        fi
        
        success "Backup created at $backup_dir"
    fi
}

# Secure installation of core structure
install_core_structure() {
    local source_dir="$1"
    validate_path "$source_dir" "source directory"
    
    log "Installing core Simone structure..."
    
    # Create main directories securely
    local directories=(
        "$SIMONE_DIR"
        "$SIMONE_DIR/01_UTILS"
        "$SIMONE_DIR/01_PROJECT_DOCS"
        "$SIMONE_DIR/02_REQUIREMENTS"
        "$SIMONE_DIR/03_SPRINTS"
        "$SIMONE_DIR/04_GENERAL_TASKS"
        "$SIMONE_DIR/05_ARCHITECTURAL_DECISIONS"
        "$SIMONE_DIR/06_BUGS"
        "$SIMONE_DIR/07_TECHNICAL_DEBT"
        "$SIMONE_DIR/07_TECHNICAL_DEBT/ACTIVE"
        "$SIMONE_DIR/07_TECHNICAL_DEBT/RESOLVED"
        "$SIMONE_DIR/10_STATE_OF_PROJECT"
        "$SIMONE_DIR/99_TEMPLATES"
    )
    
    for dir in "${directories[@]}"; do
        secure_mkdir "$dir"
    done
    
    # Copy templates securely
    if [[ -d "$source_dir/.simone/99_TEMPLATES" ]]; then
        copy_directory_contents "$source_dir/.simone/99_TEMPLATES" "$SIMONE_DIR/99_TEMPLATES"
        success "Templates installed"
    fi
    
    # Copy utilities securely
    if [[ -d "$source_dir/.simone/01_UTILS" ]]; then
        copy_directory_contents "$source_dir/.simone/01_UTILS" "$SIMONE_DIR/01_UTILS"
        
        # Make shell scripts executable (safely)
        find "$SIMONE_DIR/01_UTILS" -name "*.sh" -type f -exec chmod +x {} \; 2>/dev/null || true
        success "Performance optimization and utility scripts installed"
    fi
}

# Secure directory copying
copy_directory_contents() {
    local src_dir="$1"
    local dest_dir="$2"
    
    validate_path "$src_dir" "source directory"
    validate_path "$dest_dir" "destination directory"
    
    if [[ ! -d "$src_dir" ]]; then
        error "Source directory does not exist: $src_dir"
    fi
    
    # Use find for safer file enumeration
    while IFS= read -r -d '' file; do
        local basename
        basename="$(basename "$file")"
        
        # Skip hidden files and version files
        if [[ "$basename" =~ ^\. ]] || [[ "$basename" == ".version" ]]; then
            continue
        fi
        
        validate_path "$file" "file to copy"
        secure_copy "$file" "$dest_dir/$basename"
    done < <(find "$src_dir" -maxdepth 1 -type f -print0)
}

# Input validation for command line arguments
validate_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                show_help
                exit 0
                ;;
            --force)
                # Force flag is safe
                ;;
            --remote)
                REMOTE_INSTALL=true
                ;;
            --*)
                error "Unknown option: $1"
                ;;
            *)
                # Validate target directory
                validate_path "$1" "target directory argument"
                TARGET_DIR="$1"
                ;;
        esac
        shift
    done
}

show_help() {
    cat << 'EOF'
Simone Framework Installer - Security Hardened

Usage: ./install-simone-secure.sh [OPTIONS] [TARGET_DIR]

OPTIONS:
    --help, -h      Show this help message
    --force         Force reinstall even if current version
    --remote        Force remote installation mode

ARGUMENTS:
    TARGET_DIR      Target directory for installation (optional)

Examples:
    ./install-simone-secure.sh                    # Install in current directory
    ./install-simone-secure.sh /path/to/project   # Install in specific directory
    ./install-simone-secure.sh --force            # Force reinstall

EOF
}

# Main installation logic
main() {
    log "Starting Simone Framework installation (Security Hardened)"
    log "Script: $SCRIPT_NAME"
    log "Working directory: $(pwd)"
    
    # Validate all arguments first
    validate_arguments "$@"
    
    # Security check: ensure we're not running as root
    if [[ $EUID -eq 0 ]]; then
        error "This script should not be run as root for security reasons"
    fi
    
    # Change to target directory
    change_to_target_directory
    
    # Check if this looks like a project
    check_project_directory
    
    # Detect existing installation
    detect_installation
    
    # Create backup if needed
    backup_installation
    
    # Determine source directory
    local source_dir
    if [[ "$REMOTE_INSTALL" == true ]] || [[ ! -d "$SCRIPT_DIR/.simone" ]]; then
        # Remote installation logic would go here
        error "Remote installation not implemented in this security-hardened version"
    else
        source_dir="$SCRIPT_DIR"
        log "Using local repository: $source_dir"
    fi
    
    # Install core structure
    install_core_structure "$source_dir"
    
    # Write version file
    printf '%s\n' "$CURRENT_VERSION" > "$VERSION_FILE"
    
    success "Simone Framework installation completed successfully!"
    log "Version: $CURRENT_VERSION"
    log "Location: $(pwd)/$SIMONE_DIR"
}

# Run main function with all arguments
main "$@"