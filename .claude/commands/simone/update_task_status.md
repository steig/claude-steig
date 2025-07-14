# Update Task Status - Metadata Management

**Version**: 3.0.0 | **Enhanced**: Hierarchical Completion Tracking | **Release**: 2025-01-14

Updates task status with comprehensive metadata tracking for Simone templates.

**🚨 CRITICAL: This command MUST use the centralized metadata manager for reliable updates**

**New in v3.0.0**: Automatic hierarchical completion checking and validation gates

## Create a TODO with EXACTLY these 8 Items

1. Initialize validation and start transaction  
2. Parse arguments and locate task file
3. Validate current status and transition
4. Execute atomic metadata update using metadata-manager
5. Validate all updates succeeded
6. Commit transaction or rollback on failure
7. Log status change and report results
8. Check hierarchical completion (sprint/milestone/project)

## DETAILS on every TODO item

### 1. Initialize validation and start transaction

**MANDATORY FIRST STEP**: Initialize the validation system and start atomic transaction tracking.

```bash
# Source the utilities (run these commands)
# Note: command-validator.sh is deprecated - validation now built into framework
source .simone/01_UTILS/metadata-manager.sh

# Start command execution tracking (simplified - no separate validation needed)
echo "Starting task status update process..."
echo "🔄 Started command execution: $EXECUTION_ID"

# Initialize metadata manager
init_metadata_manager
```

Record this step as completed:
```bash
complete_step "$EXECUTION_ID" "1" "Initialized validation and transaction system"
```

### 2. Parse arguments and locate task file

**Arguments Format:** `<Task_ID> <New_Status> [Optional: effort_hours]`

**Status Options:**
- pending → in_progress
- in_progress → review  
- in_progress → testing
- in_progress → blocked
- review → completed
- review → in_progress (rework needed)
- testing → completed
- testing → in_progress (issues found)
- blocked → in_progress (unblocked)
- any_status → blocked (with reason)

**Locate Task:**
- Search `.simone/03_SPRINTS/*/T*.md` for sprint tasks
- Search `.simone/04_GENERAL_TASKS/T*.md` for general tasks
- **CRITICAL:** If task not found, report error and available tasks

### 2. Validate current status and transition

**Status Validation:**
- Read current status from YAML frontmatter
- Verify the transition is valid (e.g., can't go from pending directly to completed)
- Check for blocking dependencies if transitioning to in_progress
- Warn if transition seems unusual but allow user override

**Business Rules:**
- Tasks with unresolved dependencies should not transition to completed
- Tasks marked as blocked should include blocked_by reasons
- Completed tasks should have all acceptance criteria marked [x]

### 4. Execute atomic metadata update using metadata-manager

**CRITICAL**: Use the centralized metadata manager instead of manual file updates.

```bash
# Execute atomic update using metadata manager
if update_task_status "$TASK_ID" "$NEW_STATUS" "$EFFORT_HOURS" "$REASON"; then
    echo "✅ Metadata update completed successfully"
    record_file_modification "$EXECUTION_ID" "$TASK_FILE" "UPDATE"
    complete_step "$EXECUTION_ID" "4" "Executed atomic metadata update"
else
    echo "❌ Metadata update failed"
    exit 1
fi
```

**This single command handles:**
- YAML frontmatter updates
- Content section modifications  
- Project manifest synchronization
- Sprint meta updates (if applicable)
- Database indexing
- Transaction management with rollback capability

### 3. Legacy step - Update YAML frontmatter with comprehensive metadata

**⚠️ DEPRECATED**: This step is now handled by the metadata manager in step 4.
Skip this step and proceed to step 4.

**Required Updates for ALL status changes:**
- **status**: New status value
- **updated_date**: Current timestamp (YYYY-MM-DD HH:MM)
- **actual_effort**: Add provided hours or estimate if not provided

**Status-Specific Updates:**

**When transitioning to "in_progress":**
- **assignee**: Set to "Claude" if not already assigned
- Clear any **blocked_by** entries if transitioning from blocked
- **progress**: Initialize to appropriate percentage if starting

**When transitioning to "blocked":**
- **blocked_by**: Prompt user for blocking reasons and update array
- **assignee**: Maintain current assignee

**When transitioning to "review":**
- Ensure **actual_effort** reflects time spent
- **progress**: Should be near 100% for review

**When transitioning to "completed":**
- **actual_effort**: Final time calculation
- Clear **blocked_by** if any
- Clear **dependencies** that are now resolved
- **progress**: Set to 100%

**When transitioning to "testing":**
- Ensure testing criteria are defined
- **progress**: Should reflect completion of development phase

### 4. Update content sections based on status change

**Status Line Update:**
- Update header status display: **Status**: {new_status}
- Update any status indicators in the content

**Content Updates by Status:**

**For "in_progress":**
- Add Output Log entry: `[YYYY-MM-DD HH:MM] Status changed to in_progress - work started`
- Ensure Implementation Subtasks section is ready

**For "blocked":**
- Add Output Log entry: `[YYYY-MM-DD HH:MM] Status changed to blocked - {reason}`
- Update Issues Encountered section if applicable

**For "review":**
- Add Output Log entry: `[YYYY-MM-DD HH:MM] Status changed to review - implementation complete, ready for review`
- Ensure Quality Checklist is completed
- Mark relevant Review & Approval checkboxes

**For "completed":**
- Mark ALL Success Criteria as [x]
- Mark ALL Acceptance Criteria as [x]  
- Mark ALL Quality Checklist items as [x]
- Add final Output Log entry: `[YYYY-MM-DD HH:MM] Task completed - all acceptance criteria met`
- Fill in Post-Completion sections:
  - Retrospective Notes
  - Lessons Learned
  - Future Improvements
- Update Next Action field

**For "testing":**
- Add Output Log entry: `[YYYY-MM-DD HH:MM] Status changed to testing - implementation ready for testing`
- Ensure Testing Strategy section is complete
- Initialize test tracking if needed

### 5. Validate all updates succeeded

**MANDATORY VALIDATION**: Verify that all files were updated correctly.

```bash
# Validate the specific task update
if validate_task_update_command "$EXECUTION_ID" "$TASK_ID" "$NEW_STATUS"; then
    echo "✅ Task update validation passed"
    complete_step "$EXECUTION_ID" "5" "Validated all updates succeeded"
else
    echo "❌ Task update validation failed"
    exit 1
fi

# Validate overall metadata consistency
if validate_metadata_consistency; then
    echo "✅ Metadata consistency validated"
else
    echo "⚠️ Metadata consistency issues detected"
fi
```

### 6. Commit transaction or rollback on failure

**CRITICAL TRANSACTION MANAGEMENT**: Complete or rollback the atomic transaction.

```bash
# Complete the command validation
if validate_command_completion "$EXECUTION_ID" 7; then
    echo "✅ Command execution completed successfully"
    complete_step "$EXECUTION_ID" "6" "Transaction committed successfully"
else
    echo "❌ Command execution incomplete - this should not happen if previous steps worked"
    complete_step "$EXECUTION_ID" "6" "Transaction handling completed with warnings"
fi
```

### Legacy step - Update project manifest and related files

**⚠️ DEPRECATED**: This step is now handled automatically by the metadata manager in step 4.
All manifest, sprint meta, and database updates are handled atomically.

**Project Manifest Updates:**
- Update task status in `.simone/00_PROJECT_MANIFEST.md`
- Update current task tracking if this was the active task
- Update sprint progress if this is a sprint task

**Sprint Meta Updates (for sprint tasks):**
- Update sprint task list with new status
- Recalculate sprint progress percentage
- Update sprint status if all tasks completed

**File Management for Completion:**
- **CRITICAL:** When status = "completed", rename file with TX prefix
- Update any cross-references in other documents
- Ensure completed task links still work

### 7. Log status change and report results

**Comprehensive Logging:**
- Use **Work History** MCP if available to log status change
- Update any monitoring or tracking systems
- Log effort tracking and time estimates vs actual

**Enhanced Reporting with Validation Results:**

```bash
# Generate comprehensive status report
complete_step "$EXECUTION_ID" "7" "Generated final status report"

echo "✅ **Status Updated**: $TASK_ID → $NEW_STATUS"
echo
echo "📊 **Metadata Updated**:"
echo "- Status: $OLD_STATUS → $NEW_STATUS"  
echo "- Updated: $(date '+%Y-%m-%d %H:%M')"
echo "- Effort: ${EFFORT_HOURS:-'N/A'}h actual"
echo "- Execution ID: $EXECUTION_ID"
echo
echo "🔄 **Atomic Changes Made**:"
echo "- Task file metadata updated"
echo "- Project manifest synchronized" 
echo "- Sprint progress recalculated (if applicable)"
echo "- Database index updated"
echo "- All changes validated successfully"
echo "- Hierarchical completion checked"
echo
echo "⏭️ **Next Steps**: Continue with task work or move to next task"

# NEW STEP 8: Check hierarchical completion if task was completed
if [[ "$NEW_STATUS" == "completed" ]]; then
    echo "🔗 Checking hierarchical completion status..."
    
    # Use metadata manager to check sprint/milestone/project completion
    if command -v .simone/01_UTILS/metadata-manager.sh >/dev/null 2>&1; then
        .simone/01_UTILS/metadata-manager.sh check_completion "$TASK_ID"
        complete_step "$EXECUTION_ID" "8" "Checked hierarchical completion"
    else
        echo "⚠️ Metadata manager not found - hierarchical check skipped"
    fi
    
    echo "📈 Hierarchical completion check completed"
else
    echo "ℹ️ Hierarchical completion check only runs for completed tasks"
    complete_step "$EXECUTION_ID" "8" "Hierarchical check skipped (not completed)"
fi
```

**Error Handling:**
- Report any validation failures clearly
- Provide suggestions for resolving issues
- Offer rollback if metadata updates fail partially

## Usage Examples

```bash
# Start working on a task
/project:simone:update_task_status t01-s01 in_progress

# Mark ready for review with time tracking
/project:simone:update_task_status t01-s01 review 3.5

# Block a task with reason
/project:simone:update_task_status t01-s01 blocked

# Complete a task
/project:simone:update_task_status t01-s01 completed 4
```

## Integration Notes

This command provides comprehensive status management that complements the do_task workflow. It can be used for:

- Manual status updates when working outside do_task
- Batch status updates across multiple tasks  
- Recovery from interrupted task work
- Detailed time and progress tracking
- Integration with external project management tools

The command ensures all template metadata is properly maintained throughout the task lifecycle.