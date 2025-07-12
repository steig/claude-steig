#!/usr/bin/env bash
# Command Validator - Ensures Simone workflow commands properly execute all steps
# Provides validation hooks for command execution

set -euo pipefail

# Source dependencies
source "$(dirname "${BASH_SOURCE[0]}")/metadata-manager.sh"

# Validation configuration
VALIDATION_LOG=".simone/.cache/validation.log"
COMMAND_STATE_DIR=".simone/.cache/command_state"

# Initialize validator
init_validator() {
    mkdir -p "$(dirname "$VALIDATION_LOG")" "$COMMAND_STATE_DIR"
    init_metadata_manager
}

# Start command execution tracking
start_command_execution() {
    local command_name="$1"
    local command_args="${2:-}"
    local execution_id="$(date +%Y%m%d_%H%M%S)_$$"
    
    local state_file="$COMMAND_STATE_DIR/${command_name}_${execution_id}.json"
    
    cat > "$state_file" <<EOF
{
    "command": "$command_name",
    "args": "$command_args",
    "execution_id": "$execution_id",
    "started_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "steps_completed": [],
    "files_modified": [],
    "transaction_id": null,
    "status": "running"
}
EOF
    
    echo "$execution_id"
    log_validation "COMMAND_START" "$command_name" "$execution_id"
}

# Mark step as completed
complete_step() {
    local execution_id="$1"
    local step_number="$2"
    local step_description="$3"
    
    local state_file=$(find "$COMMAND_STATE_DIR" -name "*${execution_id}.json" | head -1)
    
    if [[ -f "$state_file" ]]; then
        # Update JSON with completed step
        local temp_file="$COMMAND_STATE_DIR/temp_${execution_id}.json"
        jq --arg step "$step_number" --arg desc "$step_description" \
           '.steps_completed += [{"step": $step, "description": $desc, "completed_at": now}]' \
           "$state_file" > "$temp_file" && mv "$temp_file" "$state_file"
        
        log_validation "STEP_COMPLETE" "$step_number: $step_description" "$execution_id"
    fi
}

# Record file modification
record_file_modification() {
    local execution_id="$1"
    local file_path="$2"
    local operation="$3"
    
    local state_file=$(find "$COMMAND_STATE_DIR" -name "*${execution_id}.json" | head -1)
    
    if [[ -f "$state_file" ]]; then
        local temp_file="$COMMAND_STATE_DIR/temp_${execution_id}.json"
        jq --arg file "$file_path" --arg op "$operation" \
           '.files_modified += [{"file": $file, "operation": $op, "timestamp": now}]' \
           "$state_file" > "$temp_file" && mv "$temp_file" "$state_file"
        
        log_validation "FILE_MODIFIED" "$operation: $file_path" "$execution_id"
    fi
}

# Validate command completion
validate_command_completion() {
    local execution_id="$1"
    local expected_steps="$2"
    
    local state_file=$(find "$COMMAND_STATE_DIR" -name "*${execution_id}.json" | head -1)
    
    if [[ ! -f "$state_file" ]]; then
        echo "❌ Command state file not found for execution: $execution_id"
        return 1
    fi
    
    local completed_steps=$(jq '.steps_completed | length' "$state_file")
    local command_name=$(jq -r '.command' "$state_file")
    
    echo "🔍 Validating command completion: $command_name"
    echo "   Expected steps: $expected_steps"
    echo "   Completed steps: $completed_steps"
    
    if [[ "$completed_steps" -ge "$expected_steps" ]]; then
        # Mark command as completed
        local temp_file="$COMMAND_STATE_DIR/temp_${execution_id}.json"
        jq '.status = "completed" | .completed_at = now' "$state_file" > "$temp_file" && mv "$temp_file" "$state_file"
        
        # Validate all files were properly updated
        validate_file_modifications "$execution_id"
        
        log_validation "COMMAND_COMPLETE" "$command_name" "$execution_id"
        echo "✅ Command execution validated successfully"
        return 0
    else
        echo "❌ Command incomplete: $completed_steps/$expected_steps steps completed"
        log_validation "COMMAND_INCOMPLETE" "$command_name - $completed_steps/$expected_steps" "$execution_id"
        
        # Show missing steps
        show_missing_steps "$execution_id" "$expected_steps"
        return 1
    fi
}

# Validate file modifications occurred
validate_file_modifications() {
    local execution_id="$1"
    local state_file=$(find "$COMMAND_STATE_DIR" -name "*${execution_id}.json" | head -1)
    
    echo "🔍 Validating file modifications..."
    
    local modifications=$(jq -r '.files_modified[] | "\(.operation):\(.file)"' "$state_file" 2>/dev/null || echo "")
    
    if [[ -z "$modifications" ]]; then
        echo "⚠️ No file modifications recorded"
        return 0
    fi
    
    local failed_validations=0
    
    while IFS=':' read -r operation file_path; do
        case "$operation" in
            "CREATE"|"UPDATE")
                if [[ ! -f "$file_path" ]]; then
                    echo "❌ Expected file not found: $file_path"
                    ((failed_validations++))
                else
                    echo "✅ File exists: $file_path"
                fi
                ;;
            "DELETE")
                if [[ -f "$file_path" ]]; then
                    echo "❌ File should have been deleted: $file_path"
                    ((failed_validations++))
                else
                    echo "✅ File deleted: $file_path"
                fi
                ;;
        esac
    done <<< "$modifications"
    
    if [[ $failed_validations -eq 0 ]]; then
        echo "✅ All file modifications validated"
        return 0
    else
        echo "❌ $failed_validations file validation failures"
        return 1
    fi
}

# Show missing steps
show_missing_steps() {
    local execution_id="$1"
    local expected_steps="$2"
    local state_file=$(find "$COMMAND_STATE_DIR" -name "*${execution_id}.json" | head -1)
    
    echo "📋 Missing steps analysis:"
    
    local completed_steps=$(jq -r '.steps_completed[].step' "$state_file" | sort -n)
    
    for ((i=1; i<=expected_steps; i++)); do
        if ! echo "$completed_steps" | grep -q "^$i$"; then
            echo "   ❌ Step $i: Not completed"
        else
            local step_desc=$(jq -r ".steps_completed[] | select(.step == \"$i\") | .description" "$state_file")
            echo "   ✅ Step $i: $step_desc"
        fi
    done
}

# Validate specific command patterns
validate_task_update_command() {
    local execution_id="$1"
    local task_id="$2"
    local new_status="$3"
    
    echo "🔍 Validating task update command..."
    
    # Check task file was updated
    local task_file=""
    for search_path in ".simone/03_SPRINTS" ".simone/04_GENERAL_TASKS"; do
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
    
    # Validate status was updated
    local current_status=$(grep "^status:" "$task_file" | cut -d':' -f2- | xargs 2>/dev/null || echo "")
    if [[ "$current_status" != "$new_status" ]]; then
        echo "❌ Task status not updated correctly"
        echo "   Expected: $new_status"
        echo "   Actual: $current_status"
        return 1
    fi
    
    # Validate manifest was updated
    if ! grep -q "$task_id" ".simone/00_PROJECT_MANIFEST.md" 2>/dev/null; then
        echo "⚠️ Task not found in manifest"
    fi
    
    # Validate database was updated
    if [[ -f ".simone/.cache/tasks.db" ]]; then
        local db_status=$(sqlite3 ".simone/.cache/tasks.db" "SELECT status FROM tasks WHERE id LIKE '%$task_id%';" 2>/dev/null || echo "")
        if [[ "$db_status" != "$new_status" ]]; then
            echo "⚠️ Database not updated with new status"
        else
            echo "✅ Database updated correctly"
        fi
    fi
    
    echo "✅ Task update validation completed"
    return 0
}

# Log validation events
log_validation() {
    local event_type="$1"
    local details="$2"
    local execution_id="$3"
    
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    
    echo "[$timestamp] $event_type: $details (execution: $execution_id)" >> "$VALIDATION_LOG"
}

# Generate validation report
generate_validation_report() {
    local days="${1:-7}"
    
    echo "📊 Simone Command Validation Report (Last $days days)"
    echo "=================================================="
    echo
    
    local cutoff_date=$(date -d "$days days ago" +%Y-%m-%d 2>/dev/null || date -v -${days}d +%Y-%m-%d)
    
    # Command success rate
    local total_commands=$(grep "COMMAND_START" "$VALIDATION_LOG" | grep -c "$cutoff_date" || echo "0")
    local completed_commands=$(grep "COMMAND_COMPLETE" "$VALIDATION_LOG" | grep -c "$cutoff_date" || echo "0")
    
    if [[ $total_commands -gt 0 ]]; then
        local success_rate=$(( (completed_commands * 100) / total_commands ))
        echo "📈 Success Rate: $success_rate% ($completed_commands/$total_commands)"
    else
        echo "📈 Success Rate: No commands executed in the last $days days"
    fi
    
    # Most common issues
    echo
    echo "🔍 Common Issues:"
    grep "COMMAND_INCOMPLETE\|FILE_MODIFIED.*❌" "$VALIDATION_LOG" | tail -10 | while read -r line; do
        echo "   - $line"
    done
    
    # File modification summary
    echo
    echo "📁 File Modifications:"
    grep "FILE_MODIFIED" "$VALIDATION_LOG" | awk '{print $4}' | sort | uniq -c | sort -nr | head -5
}

# Cleanup old state files
cleanup_old_state() {
    local days="${1:-30}"
    
    echo "🧹 Cleaning up validation state older than $days days..."
    
    find "$COMMAND_STATE_DIR" -name "*.json" -mtime +$days -delete 2>/dev/null || true
    
    # Cleanup old log entries
    local cutoff_date=$(date -d "$days days ago" +%Y-%m-%d 2>/dev/null || date -v -${days}d +%Y-%m-%d)
    grep "$cutoff_date" "$VALIDATION_LOG" > "${VALIDATION_LOG}.tmp" && mv "${VALIDATION_LOG}.tmp" "$VALIDATION_LOG"
    
    echo "✅ Cleanup completed"
}

# Export functions
export -f start_command_execution
export -f complete_step
export -f record_file_modification
export -f validate_command_completion
export -f validate_task_update_command

# Main entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    case "${1:-}" in
        "init")
            init_validator
            ;;
        "report")
            generate_validation_report "${2:-7}"
            ;;
        "cleanup")
            cleanup_old_state "${2:-30}"
            ;;
        "validate_task")
            shift
            validate_task_update_command "$@"
            ;;
        *)
            echo "Usage: $0 {init|report|cleanup|validate_task}"
            echo "  init - Initialize validation system"
            echo "  report [days] - Generate validation report"
            echo "  cleanup [days] - Clean up old state files"
            echo "  validate_task <execution_id> <task_id> <status> - Validate task update"
            exit 1
            ;;
    esac
fi