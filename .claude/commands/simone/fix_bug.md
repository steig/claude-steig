# Fix Bug - Bug-Specific Task Execution

Executes bug fix tasks with specialized bug tracking integration and comprehensive resolution workflow.

## Create a TODO with EXACTLY these 11 Items

1. Parse bug arguments and locate bug report
2. Analyze bug details and current status
3. Create or locate associated fix task
4. Create and switch to bug fix branch
5. Set bug status to in_progress
6. Execute bug fix implementation
7. Perform bug-specific testing
8. Update bug status to testing
9. Execute comprehensive bug verification
10. Update bug status to closed
11. Generate bug resolution report

## DETAILS on every TODO item

### 1. Parse bug arguments and locate bug report

**Arguments Format:** `<Bug_ID>` (e.g., "bug001" or "bug001-login-failure")

**Bug Location Process:**
- Search `.simone/06_BUGS/BUG*.md` for bug reports
- If bug ID provided without prefix, add "BUG" prefix automatically
- Support both full filename and just bug number
- **CRITICAL:** If bug not found, list available bugs and exit

**Validation:**
- Verify bug file exists and is readable
- Check bug status is not already "closed" or "wont_fix"
- Confirm bug is not marked as duplicate

### 2. Analyze bug details and current status

**MCP INTEGRATION:** Use MCP servers for enhanced bug analysis:
- **Sequential Thinking**: Structure bug fix approach systematically
- **GitHub**: Reference similar bug fixes and their outcomes
- **Context7**: Maintain context about bug investigation progress
- **Serena**: Enhance code analysis for bug root cause identification

**Bug Analysis Process:**
- READ bug report completely and extract key information
- ANALYZE severity, priority, and impact assessment
- REVIEW reproduction steps and environment details
- EXAMINE root cause analysis and proposed solutions
- CHECK for related bugs and dependencies
- ASSESS technical complexity and estimated effort

**Status Validation:**
- Verify current bug status allows progression to fixing
- Check if bug has blocking dependencies
- Confirm assignee information (assign to "Claude" if TBD)
- Validate environment and reproduction information completeness

### 3. Create or locate associated fix task

**Task Location Process:**
- SEARCH for existing task with bug reference in title or description
- Check current sprint tasks: `.simone/03_SPRINTS/*/T*.md`
- Check general tasks: `.simone/04_GENERAL_TASKS/T*.md`
- Look for pattern: "Fix BUG###" or references to bug ID

**Task Creation (if not found):**
- Determine appropriate location (current sprint vs general tasks)
- Generate sequential task ID following project conventions
- Use task template with bug-specific modifications
- Populate task with bug details and fix requirements

**Task Template Customization for Bugs:**
```yaml
task_type: "bug"
related_bug: "{BUG_ID}"
```

**Task Content Sections:**
- **Title**: "Fix {BUG_ID}: {Bug_Title}"
- **Description**: Reference bug report and reproduction steps
- **Requirements**: Based on bug impact and severity
- **Implementation Notes**: Technical guidance from bug analysis
- **Success Criteria**: Bug verification requirements
- **Testing Requirements**: Reproduction test + regression tests

### 4. Create and switch to bug fix branch

**Git Branch Management for Bug Fixes:**

**Branch Creation Process:**
1. **Check Current Git Status:**
   - Run `git status` to check for uncommitted changes
   - If uncommitted changes exist, pause and ask user how to proceed
   - Options: commit changes, stash changes, or abort bug fix start

2. **Ensure Clean Working Directory:**
   - If on feature branch, check if it should be merged first
   - Switch to main/master branch as starting point
   - Pull latest changes: `git pull origin main`

3. **Generate Bug Fix Branch Name:**
   - **For Regular Bugs**: `bug/bug###`
   - **For Critical/Hotfixes**: `hotfix/bug###`
   - **Examples**:
     - `bug/bug001`
     - `hotfix/bug002`
   - Use bug ID only (no title or description)

4. **Create and Switch Branch:**
   - For critical/high severity: `git checkout -b hotfix/bug###`
   - For medium/low severity: `git checkout -b bug/bug###`
   - Verify branch creation: `git branch --show-current`
   - **CRITICAL**: If branch already exists, append timestamp: `-YYYYMMDD-HHMM`

5. **Update Bug and Task Metadata:**
   - Add `git_branch: "<branch_name>"` to bug YAML frontmatter
   - Add same to associated task YAML frontmatter if exists
   - Log branch creation in bug's Status Log: `| [timestamp] | in_progress | Created branch <branch_name> | 0 |`

**Branch Type Selection:**
- **hotfix/**: Critical and high severity bugs that need immediate attention
- **bug/**: Medium and low severity bugs following normal workflow

**Error Handling:**
- If git commands fail, provide clear error messages and continue without branch
- If repository is not clean, guide user through resolution options
- If branch creation fails, warn user but continue with bug fix process

### 5. Set bug status to in_progress

**Bug Status Update:**
- Update bug YAML frontmatter: `status: "in_progress"`
- Update assignee: `assignee: "Claude"`
- Update timestamps: `updated_date: [current_timestamp]`
- Initialize work tracking: `actual_effort: "0"`

**Status Log Update:**
- Add entry to bug's Status Log table
- Format: `| [timestamp] | in_progress | Bug fix started | 0 |`

**Cross-Reference Updates:**
- Update associated task status to in_progress
- Update project manifest bug tracking section
- Log status change in task's Output Log

### 6. Execute bug fix implementation

**MCP INTEGRATION:** Leverage MCP servers during bug fixing:
- **Sequential Thinking**: Structure fix implementation step-by-step
- **Serena**: Get enhanced code analysis and fix suggestions
- **GitHub**: Log all bug fix activities and decisions
- **Context7**: Maintain context about fix implementation choices

**Implementation Process:**
- Follow bug report's proposed solution and implementation plan
- Consult fix strategy and alternative solutions from bug report
- Reference affected code areas identified in bug analysis
- Implement fix with consideration for:
  - Root cause elimination (not just symptom treatment)
  - Regression prevention
  - Performance impact
  - Security implications
  - Breaking change avoidance

**Progress Tracking:**
- Work through bug's Implementation Plan fix tasks
- Mark completed fix tasks with [x] in bug report
- Update actual_effort hours in both bug and task
- Log implementation notes in bug's Work Notes section
- Update task's Output Log with detailed progress

**Code Quality Requirements:**
- Follow established coding patterns from codebase
- Add appropriate error handling
- Include logging for debugging
- Update or add relevant documentation
- Ensure fix aligns with architecture decisions

### 7. Perform bug-specific testing

**Testing Strategy (based on bug report requirements):**

**Reproduction Testing:**
- Execute exact reproduction steps from bug report
- Verify bug no longer occurs with the fix
- Test edge cases mentioned in bug analysis
- Validate fix works across all affected environments

**Regression Testing:**
- Test related functionality to ensure no new issues
- Run existing automated tests if available
- Test integration points identified in bug analysis
- Verify performance hasn't degraded

**Test Documentation:**
- Update bug report's Testing Results section
- Document test cases executed and results
- Note any issues found during testing
- Update Testing Requirements checklist with [x]

**Quality Gates:**
- All reproduction steps must pass
- No new issues introduced
- Performance impact acceptable
- Security review passed (if applicable)

### 8. Update bug status to testing

**Status Transition:**
- Update bug status: `status: "testing"`
- Update timestamps: `updated_date: [current_timestamp]`
- Add Status Log entry: `| [timestamp] | testing | Fix implemented, ready for verification | [hours] |`

**Testing Phase Documentation:**
- Fill in bug report's Testing Results section
- Document testing approach and coverage
- Note any testing limitations or dependencies
- Update Verification Criteria checklist

**Stakeholder Communication:**
- Update bug's Stakeholder Updates section if needed
- Prepare summary of fix for user communication
- Document any deployment considerations

### 9. Execute comprehensive bug verification

**Verification Process:**

**Technical Verification:**
- Verify all Verification Criteria from bug report are met
- Confirm fix addresses root cause, not just symptoms
- Validate error messages and logging improvements
- Test fix robustness with various inputs

**User Experience Verification:**
- Test fix from user perspective
- Verify expected behavior is restored
- Check for any UX regressions
- Validate fix works in real-world scenarios

**Documentation Verification:**
- Ensure relevant documentation is updated
- Verify API documentation reflects any changes
- Check user-facing documentation for accuracy
- Update troubleshooting guides if applicable

**Deployment Verification:**
- Confirm fix is ready for deployment
- Document any deployment requirements
- Verify database migrations if needed
- Check configuration changes required

### 10. Update bug status to closed

**Final Status Update:**
- Update bug status: `status: "closed"`
- Update final effort: `actual_effort: [total_hours]`
- Update timestamps: `updated_date: [current_timestamp]`
- Complete Status Log: `| [timestamp] | closed | Bug fixed and verified | [total_hours] |`

**Resolution Documentation:**
- Fill in bug report's Resolution section
- Document Final Solution implemented
- Summarize Code Changes made
- Note Testing Results and verification
- Add Deployment Notes if relevant
- Capture Lessons Learned for future reference

**Quality Checklist Completion:**
- Mark all Quality Checklist items as [x] completed
- Ensure all sections of bug report are properly filled
- Verify cross-references between bug and task are updated

**Task Status Update:**
- Update associated task status to "completed"
- Rename task file with TX prefix if in general tasks
- Update task's final metadata and completion notes

### 11. Generate bug resolution report

**Comprehensive Report Generation:**

```markdown
🐛 **Bug Resolution Complete**: {BUG_ID}

📋 **Summary**: {one_line_summary_of_fix}

🔧 **Solution**: {brief_description_of_fix_implemented}

📊 **Effort**: {estimated_effort}h estimated vs {actual_effort}h actual

🧪 **Testing**: {testing_summary_and_coverage}

💾 **Code Changes**: 
- {file_1}: {change_description_1}
- {file_2}: {change_description_2}

🚀 **Deployment**: {deployment_requirements_or_none}

📚 **Documentation**: {documentation_updates_made}

🔍 **Root Cause**: {root_cause_summary}

✅ **Verification**: All verification criteria met

📈 **Impact**: {user_impact_and_business_value}

🔗 **Related**: {related_bugs_or_tasks_if_any}

⏭️ **Recommendations**: {follow_up_actions_or_preventive_measures}
```

**Project Updates:**
- Update project manifest to reflect bug closure
- Update bug statistics and metrics
- Add entry to project health tracking
- Note bug resolution in next project review

**Follow-up Actions:**
- Suggest related improvements or preventive measures
- Identify patterns for process improvement
- Recommend additional testing or monitoring
- Note knowledge sharing opportunities

**Next Steps Suggestions:**
- 🛠️ Use /project:simone:commit `BUG_ID` to commit the bug fix changes
- 🔀 Use /project:simone:create_pr `BUG_ID` to create a pull request for review (coming soon)
- 🚀 Consider /project:simone:deploy if this is a critical hotfix requiring immediate deployment

## Bug-Specific Workflow Integration

**Status Synchronization:**
- Bug status automatically syncs with associated task status
- Task completion triggers bug testing phase
- Bug closure completes associated task

**Metrics Tracking:**
- Bug resolution time tracking
- Effort estimation accuracy
- Bug severity vs actual impact correlation
- Fix quality metrics (regression rate)

**Process Improvements:**
- Capture lessons learned for similar bugs
- Identify root cause patterns
- Improve reproduction and testing procedures
- Enhance bug prevention strategies

**Communication Integration:**
- Automatic stakeholder updates based on status changes
- User communication templates for bug resolution
- Developer knowledge sharing about fix approaches
- Project manager reporting integration