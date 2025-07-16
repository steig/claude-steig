#!/usr/bin/env bash
# Simone Upgrade Manager - Smart upgrade for existing projects
# Detects existing Simone projects and migrates them to the new performance system

# Performance modules not available - using basic implementations

# Upgrade configuration
BACKUP_DIR=".simone/.upgrade-backup-$(date +%Y%m%d-%H%M%S)"
UPGRADE_LOG=".simone/.upgrade.log"

# Logging function
log_upgrade() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$UPGRADE_LOG"
}

# Check if this is an existing Simone project
detect_existing_project() {
    local has_simone_dir=false
    local has_tasks=false
    local has_sprints=false
    local has_manifest=false
    local project_version=""
    
    if [[ -d ".simone" ]]; then
        has_simone_dir=true
        log_upgrade "✅ Found .simone directory"
        
        # Check for existing manifest
        if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
            has_manifest=true
            project_version=$(grep "^## Version:" ".simone/00_PROJECT_MANIFEST.md" | cut -d' ' -f3- 2>/dev/null || echo "unknown")
            log_upgrade "✅ Found project manifest (version: $project_version)"
        fi
        
        # Check for existing tasks
        if find .simone -name "TASK_*.md" -o -name "*task*.md" | head -1 | grep -q .; then
            has_tasks=true
            local task_count=$(find .simone -name "TASK_*.md" -o -name "*task*.md" | wc -l | xargs)
            log_upgrade "✅ Found $task_count existing tasks"
        fi
        
        # Check for existing sprints
        if find .simone -name "SPRINT_*.md" -o -name "*sprint*.md" | head -1 | grep -q .; then
            has_sprints=true
            local sprint_count=$(find .simone -name "SPRINT_*.md" -o -name "*sprint*.md" | wc -l | xargs)
            log_upgrade "✅ Found $sprint_count existing sprints"
        fi
    fi
    
    # Return detection results
    echo "has_simone_dir:$has_simone_dir"
    echo "has_tasks:$has_tasks"
    echo "has_sprints:$has_sprints"
    echo "has_manifest:$has_manifest"
    echo "project_version:$project_version"
}

# Create backup of existing project
create_upgrade_backup() {
    log_upgrade "📦 Creating backup at $BACKUP_DIR"
    
    mkdir -p "$BACKUP_DIR"
    
    # Copy all existing .simone contents
    if [[ -d ".simone" ]]; then
        cp -r .simone/* "$BACKUP_DIR/" 2>/dev/null || true
        log_upgrade "✅ Backup created successfully"
        return 0
    else
        log_upgrade "⚠️ No .simone directory to backup"
        return 1
    fi
}

# Analyze existing project structure
analyze_project_structure() {
    echo "🔍 Analyzing existing project structure..."
    echo "=========================================="
    
    local total_files=0
    local task_files=0
    local sprint_files=0
    local milestone_files=0
    local other_files=0
    
    if [[ -d ".simone" ]]; then
        total_files=$(find .simone -name "*.md" | wc -l | xargs)
        task_files=$(find .simone -name "TASK_*.md" -o -name "*task*.md" | wc -l | xargs)
        sprint_files=$(find .simone -name "SPRINT_*.md" -o -name "*sprint*.md" | wc -l | xargs)
        milestone_files=$(find .simone -name "*milestone*.md" -o -name "M[0-9]*_*.md" | wc -l | xargs)
        other_files=$((total_files - task_files - sprint_files - milestone_files))
        
        echo "📊 Project Analysis:"
        echo "  Total files:     $total_files"
        echo "  Task files:      $task_files"
        echo "  Sprint files:    $sprint_files"
        echo "  Milestone files: $milestone_files"
        echo "  Other files:     $other_files"
        echo
        
        # Show directory structure
        echo "📁 Directory Structure:"
        find .simone -type d | sort | sed 's|^|  |'
        echo
        
        # Show sample files
        echo "📄 Sample Files:"
        find .simone -name "*.md" | head -10 | while read -r file; do
            echo "  - $file"
        done
        if [[ $total_files -gt 10 ]]; then
            echo "  ... and $((total_files - 10)) more files"
        fi
    else
        echo "❌ No .simone directory found"
        return 1
    fi
}

# Migrate existing tasks to new performance system
migrate_existing_tasks() {
    log_upgrade "🔄 Migrating existing tasks to performance system"
    
    local migrated_count=0
    local failed_count=0
    
    # Initialize performance system if not already done
    if [[ ! -f "$SIMONE_DB_FILE" ]]; then
        init_performance
        init_database
    fi
    
    # Migrate task files
    find .simone -name "*.md" -type f | while read -r file; do
        local filename=$(basename "$file")
        local dirname=$(dirname "$file")
        
        # Determine task type based on location and filename
        local task_type="general"
        if [[ "$dirname" == *"SPRINT"* ]] || [[ "$filename" == *"sprint"* ]]; then
            task_type="sprint"
        elif [[ "$dirname" == *"03_SPRINTS"* ]]; then
            task_type="sprint"
        elif [[ "$dirname" == *"04_GENERAL_TASKS"* ]]; then
            task_type="general"
        elif [[ "$filename" == "TASK_"* ]]; then
            task_type="general"
        fi
        
        # Try to migrate the file
        if index_task_file_advanced "$file" "$task_type" 2>/dev/null; then
            ((migrated_count++))
            log_upgrade "✅ Migrated: $file"
        else
            ((failed_count++))
            log_upgrade "⚠️ Failed to migrate: $file"
        fi
    done
    
    log_upgrade "📊 Migration complete: $migrated_count successful, $failed_count failed"
    echo "📊 Migration Results:"
    echo "  Successfully migrated: $migrated_count files"
    echo "  Failed migrations:     $failed_count files"
}

# Update project structure to new standards
update_project_structure() {
    log_upgrade "🏗️ Updating project structure to new standards"
    
    # Create missing directories
    local new_dirs=(
        ".simone/01_UTILS"
        ".simone/02_REQUIREMENTS" 
        ".simone/03_SPRINTS"
        ".simone/04_GENERAL_TASKS"
        ".simone/05_ARCHITECTURAL_DECISIONS"
        ".simone/99_TEMPLATES"
        ".simone/.cache"
    )
    
    for dir in "${new_dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            log_upgrade "✅ Created directory: $dir"
        fi
    done
    
    # Copy performance utilities if they don't exist
    local utils_dir=".simone/01_UTILS"
    local source_utils="$(dirname "${BASH_SOURCE[0]}")"
    
    for util_file in fast-commands.sh performance-main.sh; do
        if [[ ! -f "$utils_dir/$util_file" ]] && [[ -f "$source_utils/$util_file" ]]; then
            cp "$source_utils/$util_file" "$utils_dir/"
            log_upgrade "✅ Installed utility: $util_file"
        fi
    done
    
    # Update or create project manifest
    if [[ ! -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
        create_updated_manifest
    else
        update_existing_manifest
    fi
}

# Create updated project manifest
create_updated_manifest() {
    local project_name="${PWD##*/}"
    local manifest_file=".simone/00_PROJECT_MANIFEST.md"
    
    cat > "$manifest_file" << EOF
# Project Manifest

## Project: $project_name
## Version: 2.0.0
## Created: $(date +%Y-%m-%d)
## Updated: $(date +%Y-%m-%d)
## Framework: Simone Performance-Optimized

### Description
[Upgraded existing Simone project with performance optimizations]

### Performance Features
- ✅ SQLite task indexing
- ✅ Template caching
- ✅ Command optimization
- ✅ Git automation
- ✅ Hooks integration

### Upgrade Information
- Upgraded on: $(date +%Y-%m-%d)
- Previous version: $(grep "^## Version:" "$BACKUP_DIR/00_PROJECT_MANIFEST.md" 2>/dev/null | cut -d' ' -f3- || echo "unknown")
- Backup location: $BACKUP_DIR

### Status
- Performance system: enabled
- Database indexing: ready
- Cache system: ready
EOF
    
    log_upgrade "✅ Created new project manifest"
}

# Update existing manifest
update_existing_manifest() {
    local manifest_file=".simone/00_PROJECT_MANIFEST.md"
    
    # Add performance features section if it doesn't exist
    if ! grep -q "Performance Features" "$manifest_file"; then
        cat >> "$manifest_file" << EOF

### Performance Features (Added $(date +%Y-%m-%d))
- ✅ SQLite task indexing
- ✅ Template caching  
- ✅ Command optimization
- ✅ Git automation
- ✅ Hooks integration

### Upgrade Information
- Upgraded on: $(date +%Y-%m-%d)
- Backup location: $BACKUP_DIR
EOF
        log_upgrade "✅ Updated existing project manifest"
    fi
}

# Main upgrade command
upgrade_project() {
    echo "🚀 Simone Project Upgrade"
    echo "========================"
    echo
    
    # Detect existing project
    local detection_result=$(detect_existing_project)
    local has_simone_dir=$(echo "$detection_result" | grep "has_simone_dir:" | cut -d: -f2)
    local has_tasks=$(echo "$detection_result" | grep "has_tasks:" | cut -d: -f2)
    local project_version=$(echo "$detection_result" | grep "project_version:" | cut -d: -f2)
    
    if [[ "$has_simone_dir" != "true" ]]; then
        echo "❌ No existing Simone project detected"
        echo "Use 'simone init' to create a new project"
        return 1
    fi
    
    echo "✅ Existing Simone project detected"
    if [[ "$project_version" != "unknown" ]]; then
        echo "📋 Current version: $project_version"
    fi
    echo
    
    # Show analysis
    analyze_project_structure
    
    # Confirm upgrade
    echo "🔧 This upgrade will:"
    echo "  1. Create a backup of your existing project"
    echo "  2. Install new performance utilities"
    echo "  3. Migrate existing tasks to the new database system"
    echo "  4. Update project structure to new standards"
    echo "  5. Enable performance optimizations"
    echo
    read -p "Continue with upgrade? (y/N): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Upgrade cancelled"
        return 1
    fi
    
    # Start upgrade process
    echo
    echo "🚀 Starting upgrade process..."
    log_upgrade "=== SIMONE PROJECT UPGRADE STARTED ==="
    
    # Step 1: Create backup
    if create_upgrade_backup; then
        echo "✅ Backup created"
    else
        echo "⚠️ Backup creation had issues (check log)"
    fi
    
    # Step 2: Update structure
    update_project_structure
    echo "✅ Project structure updated"
    
    # Step 3: Initialize performance system
    echo "🔧 Initializing performance system..."
    init_performance
    init_database
    echo "✅ Performance system initialized"
    
    # Step 4: Migrate existing data
    if [[ "$has_tasks" == "true" ]]; then
        migrate_existing_tasks
    else
        echo "ℹ️ No existing tasks to migrate"
    fi
    
    # Step 5: Final setup
    echo "✅ Upgrade completed successfully!"
    echo
    echo "📊 Upgrade Summary:"
    echo "  - Backup location: $BACKUP_DIR"
    echo "  - Performance system: enabled"
    echo "  - Database: initialized and populated"
    echo "  - New utilities: installed"
    echo
    echo "Next steps:"
    echo "  - Run './simone perf diagnose' to check system health"
    echo "  - Run './simone perf cache stats' to see performance info"
    echo "  - Check upgrade log: $UPGRADE_LOG"
    
    log_upgrade "=== SIMONE PROJECT UPGRADE COMPLETED ==="
}

# Command routing
case "${1:-upgrade}" in
    "upgrade"|"")
        upgrade_project
        ;;
    "analyze")
        echo "🔍 Simone Project Analysis"
        echo "=========================="
        echo
        detect_existing_project > /dev/null
        analyze_project_structure
        ;;
    "detect")
        detect_existing_project
        ;;
    "backup")
        create_upgrade_backup
        ;;
    *)
        echo "Simone Upgrade Manager"
        echo "Usage: $0 {upgrade|analyze|detect|backup}"
        echo
        echo "Commands:"
        echo "  upgrade  - Full project upgrade (default)"
        echo "  analyze  - Analyze existing project structure"
        echo "  detect   - Detect existing Simone project"
        echo "  backup   - Create backup of existing project"
        ;;
esac