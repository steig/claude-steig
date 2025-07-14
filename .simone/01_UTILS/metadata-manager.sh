#!/usr/bin/env bash
# Metadata Manager - Centralized file update engine for Simone
# Ensures atomic updates across manifest, sprint meta, and task files

set -euo pipefail

# Simplified metadata manager - no SQLite dependencies

# Configuration
SIMONE_ROOT="${SIMONE_ROOT:-.simone}"
MANIFEST_FILE="$SIMONE_ROOT/00_PROJECT_MANIFEST.md"
TEMP_DIR="$SIMONE_ROOT/.temp"
BACKUP_DIR="$SIMONE_ROOT/.backups/metadata"

# Initialize metadata manager
init_metadata_manager() {
    mkdir -p "$TEMP_DIR" "$BACKUP_DIR"
    # No database initialization needed - Serena handles this
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
    
    # Validate completion requirements if marking as completed
    if [[ "$new_status" == "completed" ]]; then
        if ! validate_completion_requirements "$task_file"; then
            echo "❌ Task completion validation failed"
            echo "   Please ensure all acceptance criteria are met before marking as completed"
            return 1
        fi
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
    
    # Note: Task indexing now handled by Serena MCP
    
    # Commit transaction
    commit_transaction "$transaction_id"
    
    echo "✅ Task status updated successfully"
    echo "   Task: $task_id"
    echo "   Status: $current_status → $new_status"
    echo "   File: $task_file"
    
    # Check hierarchical completion if task was completed
    if [[ "$new_status" == "completed" && -n "$sprint_dir" ]]; then
        echo "
🔍 Checking hierarchical completion status..."
        check_sprint_completion "$sprint_dir"
    fi
    
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

# ============================================================================
# HIERARCHICAL COMPLETION TRACKING FUNCTIONS
# ============================================================================

# Validate completion requirements before allowing status change to completed
validate_completion_requirements() {
    local task_file="$1"
    local errors=0
    
    echo "🔍 Validating completion requirements for: $(basename "$task_file")"
    
    # Check acceptance criteria completion
    local unchecked_criteria=$(grep -c "^- \[ \]" "$task_file" 2>/dev/null || echo "0")
    if [[ $unchecked_criteria -gt 0 ]]; then
        echo "❌ $unchecked_criteria acceptance criteria not completed"
        ((errors++))
    else
        echo "✅ All acceptance criteria completed"
    fi
    
    # Check for required output section if task is completed
    if ! grep -q "## Output" "$task_file"; then
        echo "⚠️ No output section - consider adding completion details"
    fi
    
    # Check for quality gates in task content
    if grep -q "quality_gate" "$task_file"; then
        local failed_gates=$(grep -c "quality_gate: failed" "$task_file" 2>/dev/null || echo "0")
        if [[ $failed_gates -gt 0 ]]; then
            echo "❌ $failed_gates quality gates failed"
            ((errors++))
        fi
    fi
    
    return $errors
}

# Check if a sprint is completed and update its status
check_sprint_completion() {
    local sprint_dir="$1"
    
    if [[ ! -d "$sprint_dir" ]]; then
        echo "❌ Sprint directory not found: $sprint_dir"
        return 1
    fi
    
    echo "🔍 Checking sprint completion: $(basename "$sprint_dir")"
    
    # Count total and completed tasks in sprint
    local total_tasks=$(find "$sprint_dir" -name "*.md" -not -name "*meta*" -not -name "*sprint*" | wc -l)
    local completed_tasks=0
    
    if [[ $total_tasks -eq 0 ]]; then
        echo "⚠️ No tasks found in sprint"
        return 0
    fi
    
    # Count completed tasks
    while IFS= read -r -d '' task_file; do
        if grep -q "^status: completed" "$task_file"; then
            ((completed_tasks++))
        fi
    done < <(find "$sprint_dir" -name "*.md" -not -name "*meta*" -not -name "*sprint*" -print0)
    
    echo "📊 Sprint progress: $completed_tasks/$total_tasks tasks completed"
    
    # Update sprint status if all tasks completed
    if [[ $completed_tasks -eq $total_tasks ]]; then
        echo "🎉 All tasks completed - updating sprint status"
        update_sprint_status "$sprint_dir" "completed"
        
        # Extract milestone ID and check milestone completion
        local milestone_id=$(basename "$sprint_dir" | grep -o "M[0-9]\+")
        if [[ -n "$milestone_id" ]]; then
            echo "🔗 Checking milestone completion for: $milestone_id"
            check_milestone_completion "$milestone_id"
        fi
        
        return 0
    else
        # Update sprint progress
        local progress_percent=$(( (completed_tasks * 100) / total_tasks ))
        update_sprint_progress "$sprint_dir" $progress_percent
        return 1
    fi
}

# Update sprint status in meta file
update_sprint_status() {
    local sprint_dir="$1"
    local new_status="$2"
    local sprint_meta=$(find "$sprint_dir" -name "*sprint*meta*.md" | head -1)
    
    if [[ -z "$sprint_meta" ]]; then
        echo "⚠️ Sprint meta file not found in: $sprint_dir"
        return 1
    fi
    
    # Begin transaction
    local transaction_id=$(begin_update_transaction "sprint_status_update")
    
    # Update status in sprint meta
    if grep -q "^status:" "$sprint_meta"; then
        sed -i.bak "s/^status:.*/status: $new_status/" "$sprint_meta"
    else
        # Add status if missing
        echo "status: $new_status" >> "$sprint_meta"
    fi
    
    # Update completion date
    local current_date=$(date "+%Y-%m-%d %H:%M")
    if grep -q "^completion_date:" "$sprint_meta"; then
        sed -i.bak "s/^completion_date:.*/completion_date: $current_date/" "$sprint_meta"
    else
        echo "completion_date: $current_date" >> "$sprint_meta"
    fi
    
    # Commit transaction
    commit_transaction "$transaction_id" "Updated sprint status to $new_status"
    
    echo "✅ Sprint status updated to: $new_status"
}

# Update sprint progress percentage
update_sprint_progress() {
    local sprint_dir="$1"
    local progress_percent="$2"
    local sprint_meta=$(find "$sprint_dir" -name "*sprint*meta*.md" | head -1)
    
    if [[ -z "$sprint_meta" ]]; then
        return 1
    fi
    
    # Update progress in sprint meta
    if grep -q "^progress:" "$sprint_meta"; then
        sed -i.bak "s/^progress:.*/progress: ${progress_percent}%/" "$sprint_meta"
    else
        echo "progress: ${progress_percent}%" >> "$sprint_meta"
    fi
    
    echo "📊 Sprint progress updated to: ${progress_percent}%"
}

# Check if a milestone is completed and update its status
check_milestone_completion() {
    local milestone_id="$1"
    
    echo "🔍 Checking milestone completion: $milestone_id"
    
    # Find milestone directory
    local milestone_dir=".simone/02_REQUIREMENTS/$milestone_id"*
    if [[ ! -d $milestone_dir ]]; then
        echo "❌ Milestone directory not found for: $milestone_id"
        return 1
    fi
    
    milestone_dir=$(echo $milestone_dir | head -1)  # Handle wildcards
    
    # Count total and completed sprints in milestone
    local total_sprints=$(find ".simone/03_SPRINTS" -name "*$milestone_id*" -type d | wc -l)
    local completed_sprints=0
    
    if [[ $total_sprints -eq 0 ]]; then
        echo "⚠️ No sprints found for milestone: $milestone_id"
        return 0
    fi
    
    # Check each sprint completion status
    while IFS= read -r -d '' sprint_dir; do
        local sprint_meta=$(find "$sprint_dir" -name "*sprint*meta*.md" | head -1)
        if [[ -f "$sprint_meta" ]]; then
            local sprint_status=$(grep "^status:" "$sprint_meta" | cut -d':' -f2 | xargs || echo "active")
            if [[ "$sprint_status" == "completed" ]]; then
                ((completed_sprints++))
            fi
        fi
    done < <(find ".simone/03_SPRINTS" -name "*$milestone_id*" -type d -print0)
    
    echo "📊 Milestone progress: $completed_sprints/$total_sprints sprints completed"
    
    # Update milestone status if all sprints completed
    if [[ $completed_sprints -eq $total_sprints ]]; then
        echo "🎉 All sprints completed - updating milestone status"
        update_milestone_status "$milestone_dir" "completed"
        
        # Check project completion
        check_project_completion
        
        return 0
    else
        # Update milestone progress
        local progress_percent=$(( (completed_sprints * 100) / total_sprints ))
        update_milestone_progress "$milestone_dir" $progress_percent
        return 1
    fi
}

# Update milestone status in meta file
update_milestone_status() {
    local milestone_dir="$1"
    local new_status="$2"
    local milestone_meta=$(find "$milestone_dir" -name "*milestone*meta*.md" | head -1)
    
    if [[ -z "$milestone_meta" ]]; then
        echo "⚠️ Milestone meta file not found in: $milestone_dir"
        return 1
    fi
    
    # Begin transaction
    local transaction_id=$(begin_update_transaction "milestone_status_update")
    
    # Update status in milestone meta
    if grep -q "^status:" "$milestone_meta"; then
        sed -i.bak "s/^status:.*/status: $new_status/" "$milestone_meta"
    else
        echo "status: $new_status" >> "$milestone_meta"
    fi
    
    # Update completion date
    local current_date=$(date "+%Y-%m-%d %H:%M")
    if grep -q "^completion_date:" "$milestone_meta"; then
        sed -i.bak "s/^completion_date:.*/completion_date: $current_date/" "$milestone_meta"
    else
        echo "completion_date: $current_date" >> "$milestone_meta"
    fi
    
    # Commit transaction
    commit_transaction "$transaction_id" "Updated milestone status to $new_status"
    
    echo "✅ Milestone status updated to: $new_status"
}

# Update milestone progress percentage
update_milestone_progress() {
    local milestone_dir="$1"
    local progress_percent="$2"
    local milestone_meta=$(find "$milestone_dir" -name "*milestone*meta*.md" | head -1)
    
    if [[ -z "$milestone_meta" ]]; then
        return 1
    fi
    
    # Update progress in milestone meta
    if grep -q "^progress:" "$milestone_meta"; then
        sed -i.bak "s/^progress:.*/progress: ${progress_percent}%/" "$milestone_meta"
    else
        echo "progress: ${progress_percent}%" >> "$milestone_meta"
    fi
    
    echo "📊 Milestone progress updated to: ${progress_percent}%"
}

# Check if the entire project is completed
check_project_completion() {
    echo "🔍 Checking overall project completion"
    
    # Count total and completed milestones
    local total_milestones=$(find ".simone/02_REQUIREMENTS" -name "M*" -type d | wc -l)
    local completed_milestones=0
    
    if [[ $total_milestones -eq 0 ]]; then
        echo "⚠️ No milestones found in project"
        return 0
    fi
    
    # Check each milestone completion status
    while IFS= read -r -d '' milestone_dir; do
        local milestone_meta=$(find "$milestone_dir" -name "*milestone*meta*.md" | head -1)
        if [[ -f "$milestone_meta" ]]; then
            local milestone_status=$(grep "^status:" "$milestone_meta" | cut -d':' -f2 | xargs || echo "active")
            if [[ "$milestone_status" == "completed" ]]; then
                ((completed_milestones++))
            fi
        fi
    done < <(find ".simone/02_REQUIREMENTS" -name "M*" -type d -print0)
    
    echo "📊 Project progress: $completed_milestones/$total_milestones milestones completed"
    
    # Update project status if all milestones completed
    if [[ $completed_milestones -eq $total_milestones ]]; then
        echo "🎉 ALL MILESTONES COMPLETED - PROJECT COMPLETE!"
        update_project_status "completed"
        generate_project_completion_report
        return 0
    else
        # Update project progress
        local progress_percent=$(( (completed_milestones * 100) / total_milestones ))
        update_project_progress $progress_percent
        return 1
    fi
}

# Update project status in manifest
update_project_status() {
    local new_status="$1"
    local manifest_file=".simone/00_PROJECT_MANIFEST.md"
    
    if [[ ! -f "$manifest_file" ]]; then
        echo "❌ Project manifest not found: $manifest_file"
        return 1
    fi
    
    # Begin transaction
    local transaction_id=$(begin_update_transaction "project_status_update")
    
    # Update project status in manifest
    if grep -q "^project_status:" "$manifest_file"; then
        sed -i.bak "s/^project_status:.*/project_status: $new_status/" "$manifest_file"
    else
        # Add project status section to frontmatter
        sed -i.bak "s/^---$/project_status: $new_status\n---/" "$manifest_file"
    fi
    
    # Update completion date
    local current_date=$(date "+%Y-%m-%d %H:%M")
    if grep -q "^project_completion_date:" "$manifest_file"; then
        sed -i.bak "s/^project_completion_date:.*/project_completion_date: $current_date/" "$manifest_file"
    else
        sed -i.bak "s/^---$/project_completion_date: $current_date\n---/" "$manifest_file"
    fi
    
    # Commit transaction
    commit_transaction "$transaction_id" "Updated project status to $new_status"
    
    echo "✅ Project status updated to: $new_status"
}

# Update project progress percentage
update_project_progress() {
    local progress_percent="$1"
    local manifest_file=".simone/00_PROJECT_MANIFEST.md"
    
    if [[ ! -f "$manifest_file" ]]; then
        return 1
    fi
    
    # Update progress in manifest
    if grep -q "^project_progress:" "$manifest_file"; then
        sed -i.bak "s/^project_progress:.*/project_progress: ${progress_percent}%/" "$manifest_file"
    else
        sed -i.bak "s/^---$/project_progress: ${progress_percent}%\n---/" "$manifest_file"
    fi
    
    echo "📊 Project progress updated to: ${progress_percent}%"
}

# Check hierarchical completion for a specific task or all items
check_hierarchical_completion() {
    local task_id="${1:-}"
    
    if [[ -n "$task_id" ]]; then
        echo "🔍 Checking hierarchical completion for task: $task_id"
        
        # Find task file
        local task_file=$(find ".simone" -name "*$task_id*.md" -not -name "*meta*" | head -1)
        if [[ -z "$task_file" ]]; then
            echo "❌ Task file not found for: $task_id"
            return 1
        fi
        
        # Find sprint directory
        local sprint_dir=$(dirname "$task_file")
        if [[ "$sprint_dir" == *"03_SPRINTS"* ]]; then
            check_sprint_completion "$sprint_dir"
        else
            echo "ℹ️ Task is not in a sprint (general task)"
        fi
    else
        echo "🔍 Checking all hierarchical completion"
        
        # Check all sprints
        while IFS= read -r -d '' sprint_dir; do
            check_sprint_completion "$sprint_dir"
        done < <(find ".simone/03_SPRINTS" -type d -mindepth 1 -print0)
        
        # Check project completion
        check_project_completion
    fi
}

# Synchronize all metadata across the hierarchy
sync_all_metadata() {
    echo "🔄 Synchronizing all metadata across project hierarchy"
    
    # Validate all completion requirements
    echo "\n📋 Step 1: Validating completion requirements"
    local validation_errors=0
    
    while IFS= read -r -d '' task_file; do
        local task_status=$(grep "^status:" "$task_file" | cut -d':' -f2 | xargs || echo "pending")
        if [[ "$task_status" == "completed" ]]; then
            if ! validate_completion_requirements "$task_file"; then
                echo "⚠️ Completion validation failed for: $(basename "$task_file")"
                ((validation_errors++))
            fi
        fi
    done < <(find ".simone" -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -print0)
    
    if [[ $validation_errors -gt 0 ]]; then
        echo "⚠️ Found $validation_errors completion validation issues"
    fi
    
    # Sync sprint progress
    echo "\n📋 Step 2: Synchronizing sprint progress"
    while IFS= read -r -d '' sprint_dir; do
        echo "🔄 Syncing: $(basename "$sprint_dir")"
        check_sprint_completion "$sprint_dir"
    done < <(find ".simone/03_SPRINTS" -type d -mindepth 1 -print0)
    
    # Sync milestone progress
    echo "\n📋 Step 3: Synchronizing milestone progress"
    while IFS= read -r -d '' milestone_dir; do
        local milestone_id=$(basename "$milestone_dir" | grep -o "M[0-9]\+")
        if [[ -n "$milestone_id" ]]; then
            echo "🔄 Syncing: $milestone_id"
            check_milestone_completion "$milestone_id"
        fi
    done < <(find ".simone/02_REQUIREMENTS" -name "M*" -type d -print0)
    
    # Sync project status
    echo "\n📋 Step 4: Synchronizing project status"
    check_project_completion
    
    echo "\n✅ Metadata synchronization completed"
}

# Generate comprehensive completion dashboard
generate_completion_dashboard() {
    echo "## 📊 Completion Status Dashboard"
    echo "**Generated**: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    
    # Project Overview
    local total_milestones=$(find ".simone/02_REQUIREMENTS" -name "M*" -type d | wc -l)
    local completed_milestones=0
    local total_sprints=$(find ".simone/03_SPRINTS" -type d -mindepth 1 | wc -l)
    local completed_sprints=0
    local total_tasks=0
    local completed_tasks=0
    
    # Count completed milestones
    while IFS= read -r -d '' milestone_dir; do
        local milestone_meta=$(find "$milestone_dir" -name "*milestone*meta*.md" | head -1)
        if [[ -f "$milestone_meta" ]]; then
            local status=$(grep "^status:" "$milestone_meta" | cut -d':' -f2 | xargs || echo "active")
            if [[ "$status" == "completed" ]]; then
                ((completed_milestones++))
            fi
        fi
    done < <(find ".simone/02_REQUIREMENTS" -name "M*" -type d -print0)
    
    # Count completed sprints
    while IFS= read -r -d '' sprint_dir; do
        local sprint_meta=$(find "$sprint_dir" -name "*sprint*meta*.md" | head -1)
        if [[ -f "$sprint_meta" ]]; then
            local status=$(grep "^status:" "$sprint_meta" | cut -d':' -f2 | xargs || echo "active")
            if [[ "$status" == "completed" ]]; then
                ((completed_sprints++))
            fi
        fi
    done < <(find ".simone/03_SPRINTS" -type d -mindepth 1 -print0)
    
    # Count completed tasks
    while IFS= read -r -d '' task_file; do
        ((total_tasks++))
        local status=$(grep "^status:" "$task_file" | cut -d':' -f2 | xargs || echo "pending")
        if [[ "$status" == "completed" ]]; then
            ((completed_tasks++))
        fi
    done < <(find ".simone" -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -not -name "*meta*" -print0)
    
    # Calculate percentages
    local project_progress=0
    local sprint_progress=0
    local task_progress=0
    
    if [[ $total_milestones -gt 0 ]]; then
        project_progress=$(( (completed_milestones * 100) / total_milestones ))
    fi
    
    if [[ $total_sprints -gt 0 ]]; then
        sprint_progress=$(( (completed_sprints * 100) / total_sprints ))
    fi
    
    if [[ $total_tasks -gt 0 ]]; then
        task_progress=$(( (completed_tasks * 100) / total_tasks ))
    fi
    
    echo "### 🎯 Project Overview"
    echo "- **Project Progress**: $project_progress% ($completed_milestones/$total_milestones milestones)"
    echo "- **Sprint Progress**: $sprint_progress% ($completed_sprints/$total_sprints sprints)"
    echo "- **Task Progress**: $task_progress% ($completed_tasks/$total_tasks tasks)"
    echo ""
    
    # Detailed breakdown
    echo "### 📋 Detailed Status"
    echo ""
    
    # List active milestones
    echo "#### 🎯 Active Milestones"
    local active_milestones=0
    while IFS= read -r -d '' milestone_dir; do
        local milestone_meta=$(find "$milestone_dir" -name "*milestone*meta*.md" | head -1)
        if [[ -f "$milestone_meta" ]]; then
            local status=$(grep "^status:" "$milestone_meta" | cut -d':' -f2 | xargs || echo "active")
            if [[ "$status" != "completed" ]]; then
                local milestone_id=$(basename "$milestone_dir")
                local progress=$(grep "^progress:" "$milestone_meta" | cut -d':' -f2 | xargs || echo "0%")
                echo "- **$milestone_id**: $status ($progress)"
                ((active_milestones++))
            fi
        fi
    done < <(find ".simone/02_REQUIREMENTS" -name "M*" -type d -print0)
    
    if [[ $active_milestones -eq 0 ]]; then
        echo "🎉 All milestones completed!"
    fi
    echo ""
    
    # List active sprints
    echo "#### 🏃 Active Sprints"
    local active_sprints=0
    while IFS= read -r -d '' sprint_dir; do
        local sprint_meta=$(find "$sprint_dir" -name "*sprint*meta*.md" | head -1)
        if [[ -f "$sprint_meta" ]]; then
            local status=$(grep "^status:" "$sprint_meta" | cut -d':' -f2 | xargs || echo "active")
            if [[ "$status" != "completed" ]]; then
                local sprint_id=$(basename "$sprint_dir")
                local progress=$(grep "^progress:" "$sprint_meta" | cut -d':' -f2 | xargs || echo "0%")
                echo "- **$sprint_id**: $status ($progress)"
                ((active_sprints++))
            fi
        fi
    done < <(find ".simone/03_SPRINTS" -type d -mindepth 1 -print0)
    
    if [[ $active_sprints -eq 0 ]]; then
        echo "🎉 All sprints completed!"
    fi
    echo ""
    
    # Show completion forecast
    echo "### 📈 Completion Forecast"
    if [[ $project_progress -eq 100 ]]; then
        echo "🎉 **PROJECT COMPLETED!**"
    elif [[ $project_progress -ge 80 ]]; then
        echo "🚀 Project nearing completion ($project_progress%)"
    elif [[ $project_progress -ge 50 ]]; then
        echo "⚡ Project making good progress ($project_progress%)"
    elif [[ $project_progress -ge 20 ]]; then
        echo "📚 Project in active development ($project_progress%)"
    else
        echo "🌱 Project in early stages ($project_progress%)"
    fi
    
    echo ""
    echo "---"
    echo "*Use \`metadata-manager.sh sync_all\` to refresh all completion status*"
}

# Generate project completion report
generate_project_completion_report() {
    local completion_date=$(date '+%Y-%m-%d %H:%M:%S')
    local report_file=".simone/10_STATE_OF_PROJECT/project_completion_${completion_date//:/-}.md"
    
    mkdir -p ".simone/10_STATE_OF_PROJECT"
    
    cat > "$report_file" <<EOF
# Project Completion Report

**Project Completed**: $completion_date

## Summary

🎉 **ALL PROJECT MILESTONES HAVE BEEN COMPLETED!**

This report documents the successful completion of all project objectives and milestones.

## Completion Statistics

EOF
    
    # Add completion dashboard to report
    generate_completion_dashboard >> "$report_file"
    
    echo "\n## Next Steps\n" >> "$report_file"
    echo "- [ ] Conduct project retrospective" >> "$report_file"
    echo "- [ ] Archive project documentation" >> "$report_file"
    echo "- [ ] Plan maintenance and support phase" >> "$report_file"
    echo "- [ ] Document lessons learned" >> "$report_file"
    
    echo "📄 Project completion report generated: $report_file"
}

# Export new functions for use in other scripts
export -f validate_completion_requirements
export -f check_sprint_completion
export -f check_milestone_completion
export -f check_project_completion
export -f check_hierarchical_completion
export -f sync_all_metadata
export -f generate_completion_dashboard

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
        "check_completion")
            shift
            check_hierarchical_completion "$@"
            ;;
        "sync_all")
            sync_all_metadata
            ;;
        "completion_dashboard")
            generate_completion_dashboard
            ;;
        *)
            echo "Usage: $0 {update_task|validate|init|check_completion|sync_all|completion_dashboard}"
            echo "  update_task <task_id> <status> [effort_hours] [reason]"
            echo "  validate - Check metadata consistency"
            echo "  init - Initialize metadata manager"
            echo "  check_completion [task_id] - Check and update hierarchical completion"
            echo "  sync_all - Synchronize all metadata across hierarchy"
            echo "  completion_dashboard - Show completion status dashboard"
            exit 1
            ;;
    esac
fi