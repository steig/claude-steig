# Update Task Status - Metadata Management

Updates task status with comprehensive metadata tracking for Simone templates.

## Create a TODO with EXACTLY these 6 Items

1. Parse arguments and locate task file
2. Validate current status and transition
3. Update YAML frontmatter with comprehensive metadata
4. Update content sections based on status change
5. Update project manifest and related files
6. Log status change and report results

## DETAILS on every TODO item

### 1. Parse arguments and locate task file

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

### 3. Update YAML frontmatter with comprehensive metadata

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

### 5. Update project manifest and related files

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

### 6. Log status change and report results

**Comprehensive Logging:**
- Use **Work History** MCP if available to log status change
- Update any monitoring or tracking systems
- Log effort tracking and time estimates vs actual

**User Report:**
```
✅ **Status Updated**: {task_id} → {new_status}

📊 **Metadata Updated**:
- Status: {old_status} → {new_status}
- Updated: {timestamp}
- Effort: {estimated}h estimated / {actual}h actual
- Progress: {progress_percentage}%

🔄 **Changes Made**:
- YAML frontmatter updated with {count} fields
- {count} content sections updated
- Project manifest updated
- {additional_updates}

⏭️ **Next Steps**: {recommended_next_actions}
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