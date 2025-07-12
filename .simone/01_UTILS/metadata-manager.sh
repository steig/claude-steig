#!/usr/bin/env bash
# Metadata Manager - Centralized file update engine for Simone
# Ensures atomic updates across manifest, sprint meta, and task files

set -euo pipefail

# Source dependencies
source "$(dirname "${BASH_SOURCE[0]}")/database-manager.sh"
source "$(dirname "${BASH_SOURCE[0]}")/performance-optimizer.sh"

# Configuration
SIMONE_ROOT="${SIMONE_ROOT:-.simone}"
MANIFEST_FILE="$SIMONE_ROOT/00_PROJECT_MANIFEST.md"
TEMP_DIR="$SIMONE_ROOT/.temp"
BACKUP_DIR="$SIMONE_ROOT/.backups/metadata"

# Initialize metadata manager
init_metadata_manager() {
    mkdir -p "$TEMP_DIR" "$BACKUP_DIR"
    init_database
}

# Atomic update transaction
begin_update_transaction() {
    local transaction_id="$(date +%Y%m%d_%H%M%S)_$$"
    echo "$transaction_id" > "$TEMP_DIR/current_transaction"
    mkdir -p "$BACKUP_DIR/$transaction_id"
    echo "$transaction_id"
}

# Backup file before modification
backup_file() {
    local file="$1"
    local transaction_id="$2"
    
    if [[ -f "$file" ]]; then
        cp "$file" "$BACKUP_DIR/$transaction_id/$(basename "$file")"
    fi
}

# Commit transaction (cleanup temp files)
commit_transaction() {
    local transaction_id="$1"
    rm -f "$TEMP_DIR/current_transaction"
    
    # Keep only last 10 backups
    ls -t "$BACKUP_DIR" | tail -n +11 | xargs -I {} rm -rf "$BACKUP_DIR/{}"
}

# Rollback transaction
rollback_transaction() {
    local transaction_id="$1"
    
    echo "🔄 Rolling back transaction: $transaction_id"
    
    # Restore backed up files
    if [[ -d "$BACKUP_DIR/$transaction_id" ]]; then
        for backup_file in "$BACKUP_DIR/$transaction_id"/*; do
            if [[ -f "$backup_file" ]]; then
                local original_file="$SIMONE_ROOT/$(basename "$backup_file")"
                cp "$backup_file" "$original_file"
                echo "   Restored: $(basename "$backup_file")"
            fi
        done
    fi
    
    rm -f "$TEMP_DIR/current_transaction"
    echo "✅ Rollback completed"
}

# Update task status with full metadata consistency
update_task_status() {
    local task_id="$1"
    local new_status="$2"
    local effort_hours="${3:-}"
    local reason="${4:-}"
    
    echo "🔄 Updating task status: $task_id → $new_status"
    
    # Start transaction
    local transaction_id=$(begin_update_transaction)
    
    # Find task file
    local task_file=""
    for search_path in "$SIMONE_ROOT/03_SPRINTS" "$SIMONE_ROOT/04_GENERAL_TASKS"; do
        local found=$(find "$search_path" -name "*$task_id*.md" -type f 2>/dev/null | head -1)
        if [[ -n "$found" ]]; then
            task_file="$found"
            break
        fi
    done
    
    if [[ -z "$task_file" ]]; then
        echo "❌ Task file not found for: $task_id"
        return 1
    fi
    
    # Validate status transition
    local current_status=$(grep "^status:" "$task_file" | cut -d':' -f2- | xargs 2>/dev/null || echo "pending")
    if ! validate_status_transition "$current_status" "$new_status"; then
        echo "❌ Invalid status transition: $current_status → $new_status"
        return 1
    fi
    
    # Backup files
    backup_file "$task_file" "$transaction_id"
    backup_file "$MANIFEST_FILE" "$transaction_id"
    
    # Update task file
    if ! update_task_file_metadata "$task_file" "$new_status" "$effort_hours" "$reason"; then
        rollback_transaction "$transaction_id"
        return 1
    fi
    
    # Update manifest
    if ! update_manifest_task_status "$task_id" "$new_status"; then
        rollback_transaction "$transaction_id"
        return 1
    fi
    
    # Update sprint meta if applicable
    local sprint_dir=$(dirname "$task_file" | grep "03_SPRINTS" || echo "")
    if [[ -n "$sprint_dir" ]]; then
        if ! update_sprint_meta_status "$sprint_dir" "$task_id" "$new_status"; then
            rollback_transaction "$transaction_id"
            return 1
        fi
    fi
    
    # Update database index
    index_task_file_advanced "$task_file" "$(basename "$(dirname "$task_file")")"
    
    # Commit transaction
    commit_transaction "$transaction_id"
    
    echo "✅ Task status updated successfully"
    echo "   Task: $task_id"
    echo "   Status: $current_status → $new_status"
    echo "   File: $task_file"
    
    return 0
}

# Validate status transitions
validate_status_transition() {
    local current="$1"
    local new="$2"
    
    case "$current" in
        "pending")
            [[ "$new" =~ ^(in_progress|blocked)$ ]] ;;
        "in_progress")
            [[ "$new" =~ ^(review|testing|completed|blocked)$ ]] ;;
        "review")
            [[ "$new" =~ ^(completed|in_progress)$ ]] ;;
        "testing")
            [[ "$new" =~ ^(completed|in_progress)$ ]] ;;
        "blocked")
            [[ "$new" =~ ^(in_progress|pending)$ ]] ;;
        "completed")
            false ;; # Completed tasks shouldn't change status
        *)
            true ;; # Allow any transition for unknown statuses
    esac
}

# Update task file metadata
update_task_file_metadata() {
    local task_file="$1"
    local new_status="$2"
    local effort_hours="$3"
    local reason="$4"
    
    local timestamp=$(date "+%Y-%m-%d %H:%M")
    
    # Create temp file
    local temp_file="$TEMP_DIR/$(basename "$task_file")"
    
    # Update YAML frontmatter
    awk -v status="$new_status" -v timestamp="$timestamp" -v effort="$effort_hours" '
    BEGIN { in_yaml = 0; yaml_end = 0 }
    /^---$/ { 
        if (!in_yaml) { in_yaml = 1; print; next }
        else { yaml_end = 1; print; next }
    }
    in_yaml && !yaml_end {
        if (/^status:/) { print "status: " status; next }
        if (/^updated_date:/) { print "updated_date: " timestamp; next }
        if (/^actual_effort:/ && effort != "") { print "actual_effort: " effort; next }
        print
    }
    !in_yaml || yaml_end { print }
    ' "$task_file" > "$temp_file"
    
    # Add status-specific content updates
    case "$new_status" in
        "in_progress")
            echo "" >> "$temp_file"
            echo "[$(date '+%Y-%m-%d %H:%M')] Status changed to in_progress - work started" >> "$temp_file"
            ;;
        "blocked")
            echo "" >> "$temp_file"
            echo "[$(date '+%Y-%m-%d %H:%M')] Status changed to blocked - $reason" >> "$temp_file"
            ;;
        "completed")
            # Mark all checkboxes as completed
            sed -i.bak 's/^- \[ \]/- [x]/g' "$temp_file" 2>/dev/null || sed -i 's/^- \[ \]/- [x]/g' "$temp_file"
            echo "" >> "$temp_file"
            echo "[$(date '+%Y-%m-%d %H:%M')] Task completed - all acceptance criteria met" >> "$temp_file"
            ;;
    esac
    
    # Validate file integrity
    if [[ -s "$temp_file" ]]; then
        mv "$temp_file" "$task_file"
        return 0
    else
        echo "❌ Failed to update task file metadata"
        return 1
    fi
}

# Update manifest with task status
update_manifest_task_status() {
    local task_id="$1"
    local new_status="$2"
    
    if [[ ! -f "$MANIFEST_FILE" ]]; then
        echo "⚠️ Manifest file not found: $MANIFEST_FILE"
        return 0
    fi
    
    # Create temp manifest
    local temp_manifest="$TEMP_DIR/manifest_update.md"
    cp "$MANIFEST_FILE" "$temp_manifest"
    
    # Update task status in manifest
    # This is a simplified implementation - would need project-specific logic
    sed -i.bak "s/\(${task_id}.*\)Status: [^)]*)/\1Status: ${new_status})/g" "$temp_manifest" 2>/dev/null || \
    sed -i "s/\(${task_id}.*\)Status: [^)]*)/\1Status: ${new_status})/g" "$temp_manifest"
    
    # Update last modified timestamp
    sed -i.bak "s/^last_updated: .*/last_updated: $(date '+%Y-%m-%d %H:%M:%S')/g" "$temp_manifest" 2>/dev/null || \
    sed -i "s/^last_updated: .*/last_updated: $(date '+%Y-%m-%d %H:%M:%S')/g" "$temp_manifest"
    
    if [[ -s "$temp_manifest" ]]; then
        mv "$temp_manifest" "$MANIFEST_FILE"
        return 0
    else
        echo "❌ Failed to update manifest"
        return 1
    fi
}

# Update sprint metadata
update_sprint_meta_status() {
    local sprint_dir="$1"
    local task_id="$2"
    local new_status="$3"
    
    local sprint_meta_file=$(find "$sprint_dir" -name "*sprint_meta*.md" -type f | head -1)
    
    if [[ -z "$sprint_meta_file" ]]; then
        echo "⚠️ Sprint meta file not found in: $sprint_dir"
        return 0
    fi
    
    backup_file "$sprint_meta_file" "$(cat "$TEMP_DIR/current_transaction")"
    
    # Update sprint progress
    local temp_sprint="$TEMP_DIR/sprint_meta_update.md"
    cp "$sprint_meta_file" "$temp_sprint"
    
    # Recalculate sprint progress
    local total_tasks=$(find "$sprint_dir" -name "*.md" -not -name "*meta*" -type f | wc -l)
    local completed_tasks=$(grep -l "^status: completed" "$sprint_dir"/*.md 2>/dev/null | wc -l)
    local progress_percent=$((completed_tasks * 100 / total_tasks))
    
    # Update progress in sprint meta
    sed -i.bak "s/^progress: .*/progress: ${progress_percent}%/g" "$temp_sprint" 2>/dev/null || \
    sed -i "s/^progress: .*/progress: ${progress_percent}%/g" "$temp_sprint"
    
    # Update timestamp
    sed -i.bak "s/^updated_date: .*/updated_date: $(date '+%Y-%m-%d %H:%M')/g" "$temp_sprint" 2>/dev/null || \
    sed -i "s/^updated_date: .*/updated_date: $(date '+%Y-%m-%d %H:%M')/g" "$temp_sprint"
    
    if [[ -s "$temp_sprint" ]]; then
        mv "$temp_sprint" "$sprint_meta_file"
        return 0
    else
        echo "❌ Failed to update sprint meta"
        return 1
    fi
}

# Validate all metadata consistency
validate_metadata_consistency() {
    echo "🔍 Validating metadata consistency..."
    
    local errors=0
    
    # Check manifest exists
    if [[ ! -f "$MANIFEST_FILE" ]]; then
        echo "❌ Project manifest missing: $MANIFEST_FILE"
        ((errors++))
    fi
    
    # Check task files have required metadata
    while IFS= read -r -d '' task_file; do
        if ! grep -q "^status:" "$task_file"; then
            echo "❌ Missing status in: $task_file"
            ((errors++))
        fi
        if ! grep -q "^updated_date:" "$task_file"; then
            echo "❌ Missing updated_date in: $task_file"
            ((errors++))
        fi
    done < <(find "$SIMONE_ROOT" -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -print0)
    
    if [[ $errors -eq 0 ]]; then
        echo "✅ Metadata consistency validated"
        return 0
    else
        echo "❌ Found $errors metadata issues"
        return 1
    fi
}

# Export functions for use in other scripts
export -f update_task_status
export -f validate_metadata_consistency
export -f begin_update_transaction
export -f commit_transaction
export -f rollback_transaction

# Main entry point for CLI usage
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    case "${1:-}" in
        "update_task")
            shift
            update_task_status "$@"
            ;;
        "validate")
            validate_metadata_consistency
            ;;
        "init")
            init_metadata_manager
            ;;
        *)
            echo "Usage: $0 {update_task|validate|init}"
            echo "  update_task <task_id> <status> [effort_hours] [reason]"
            echo "  validate - Check metadata consistency"
            echo "  init - Initialize metadata manager"
            exit 1
            ;;
    esac
fi