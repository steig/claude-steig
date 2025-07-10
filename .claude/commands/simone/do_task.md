# Process Simone Task based on $Argument

**IMPORTANT:** Follow from Top to Bottom - don't skip anything!

**CREATE A TODO LIST** with exactly these 9 items

1. Analyse scope from argument
2. Identify task file
3. Analyse the task
4. Create and switch to task branch
5. Set status to in_progress
6. Execute task work
7. Placeholder
8. Execute Code review
9. Finalize Task status

## 1 · Analyse scope from argument

<$ARGUMENTS> ⇒ Task ID, Sprint ID, or empty (select next open task in current sprint).

## 2 · Identify task file

Search .simone/03_SPRINTS/ and .simone/04_GENERAL_TASKS/.
If no open task matches, pause and ask the user how to proceed.

## 3 · Analyse the task

Read the task description. If anything is unclear, ask clarifying questions before continuing.

**MCP INTEGRATION:** Use available MCP servers to enhance task analysis:
- **Sequential Thinking**: Structure the task analysis and break down complex problems
- **Serena**: Enhance code analysis and project understanding
- **Context7**: Maintain context about project state and requirements
- **Work History**: Review similar past tasks and their outcomes

**CRITICAL CONTEXT VALIDATION:** Before executing any task spin up Parallel Subagents for these tasks:

1. **Sprint Context:** Confirm task belongs to current sprint scope
2. **Dependencies:** Check if any dependent tasks need to be completed first
3. **Requirements:** Read relevant requirements docs in `.simone/02_REQUIREMENTS/`
4. **Scope Verification:** Ensure task aligns with current sprint objectives

**IMPORTANT:** If task references functionality from future sprints or has unmet dependencies, pause and ask for clarification.

## 4 · Create and switch to task branch

**Git Branch Management:**

**Branch Creation Process:**
1. **Check Current Git Status:**
   - Run `git status` to check for uncommitted changes
   - If uncommitted changes exist, pause and ask user how to proceed
   - Options: commit changes, stash changes, or abort task start

2. **Ensure Clean Working Directory:**
   - If on feature branch, check if it should be merged first
   - Switch to main/master branch as starting point
   - Pull latest changes: `git pull origin main`

3. **Generate Branch Name:**
   - **For Sprint Tasks**: `task/t##-s##`
   - **For General Tasks**: `task/t###`
   - **Examples**: 
     - `task/t01-s02`
     - `task/t003`
   - Use task ID and milestone ID only (no title or description)

4. **Create and Switch Branch:**
   - Create branch: `git checkout -b <branch_name>`
   - Verify branch creation: `git branch --show-current`
   - **CRITICAL**: If branch already exists, append timestamp: `-YYYYMMDD-HHMM`

5. **Update Task Metadata:**
   - Add `git_branch: "<branch_name>"` to task YAML frontmatter
   - Log branch creation in Output Log: `[YYYY-MM-DD HH:MM] Created and switched to branch: <branch_name>`

**Error Handling:**
- If git commands fail, provide clear error messages
- If repository is not clean, guide user through resolution
- If branch creation fails, fall back to working on current branch but warn user

## 5 · Set status to in_progress

**Metadata Update:**
- Find out the current local timestamp (YYYY-MM-DD HH:MM)
- Update YAML frontmatter with comprehensive status change:
  - **status**: "in_progress"
  - **updated_date**: Current timestamp
  - **assignee**: "Claude" (if not already set)
  - Initialize **actual_effort**: "0" (if not already tracking)
- Update header status line: **Status**: in_progress
- Update ./simone/00_PROJECT_MANIFEST.md to set task in progress, updated time and current Sprint Status
- Log status change in Output Log: `[YYYY-MM-DD HH:MM] Task started - status changed to in_progress`

## 6 · Execute task work

**MCP INTEGRATION:** Leverage MCP servers during task execution:
- **Sequential Thinking**: Structure implementation approach step-by-step
- **Serena**: Get enhanced code analysis and suggestions
- **Work History**: Log all task execution details and outcomes
- **Context7**: Maintain context about implementation decisions

- Follow Description, Goal and Acceptance Criteria.
- Consult supporting docs in .simone/01_PROJECT_DOCS/ and .simone/02_REQUIREMENTS/.
- **Progress Tracking**: Iterate over subtasks with comprehensive metadata updates:
  1. Pick the next incomplete subtask.
  2. Implement the required changes, consulting docs as needed.
  3. Mark the subtask done with [x].
  4. Update **actual_effort** in YAML frontmatter (estimate time spent).
  5. Update **updated_date** in YAML frontmatter with current timestamp.
  6. Append detailed log entry to **## Output Log**: `[YYYY-MM-DD HH:MM]: <subtask_completed> - <implementation_notes>`
  7. If issues encountered, update **blocked_by** field if applicable.
  8. Use **Work History** to track implementation progress and decisions.
  9. **Update progress percentage** based on completed subtasks vs total.
  10. Repeat until all subtasks are complete.

## 7 · Implementation Quality Review

**Pre-Commit Quality Assessment:**

1. **Analyze Implementation Results:**
   - Review all files modified during task execution
   - Verify all subtasks marked as completed
   - Check implementation meets acceptance criteria
   - Identify any potential issues or improvements

2. **Quality Validation:**
   - Run any applicable tests or validation scripts
   - Check code style and formatting compliance
   - Verify documentation is updated and accurate
   - Ensure no debugging code or temporary changes remain

3. **Implementation Summary:**
   - Generate summary of changes made
   - List files created/modified with purpose
   - Confirm all acceptance criteria addressed
   - Note any deviations from original plan

4. **Prepare for User Review:**
   - Compile comprehensive change overview
   - Prepare commit proposal for user approval
   - Ready PR creation plan for user review
   - Set up approval gates for next steps

## 8 · Execute Code Review

Follow these steps for a Code Review (in order)

- include @.claude/commands/simone/code_review.md and use the Task ID as Scope.
- Follow the instructions in the file to run a code review in **PARALLEL SUBAGENTS**
- When done continue acting on the results accordingly
- Understand and think about the results
- on **FAIL**
  - thoroughly understand the problem
  - extend the Current Task with the Subtasks identified by the review
  - go back to "6 · Execute task work"
- on **PASS**
  - move on to next step

## 9 · Guided Task Completion with Approval Gates

**MCP INTEGRATION:** Complete task tracking:
- **Work History**: Log final task completion and outcomes
- **Context7**: Store task completion context for future reference

**GUIDED WORKFLOW WITH USER CONTROL:**

### 9.1 · Review Implementation Results

**Display Implementation Summary:**
- **Task Context**: Show task ID, title, and original scope
- **Changed Files**: List all modified/created files with brief descriptions
- **Acceptance Criteria**: Confirm all criteria marked as complete
- **Quality Checklist**: Verify all quality items addressed
- **Time Tracking**: Compare estimated vs actual effort

### 9.2 · Approval Gate: Commit Review

**Present Commit Proposal to User:**

```markdown
## 📋 Ready to Commit Task Implementation

**Task**: {TASK_ID} - {task_title}
**Branch**: {current_branch}
**Status**: Implementation complete, ready for commit

**Files to be committed:**
{list_changed_files_with_descriptions}

**Proposed commit message:**
{conventional_commit_format_with_task_id}

**Quality verification:**
✅ All acceptance criteria met
✅ Code review passed
✅ Documentation updated
✅ Tests passing (if applicable)

**Approve commit? (y/n/modify)**
```

**Handle User Response:**
- **Yes**: Proceed to execute commit
- **No**: Allow user to make additional changes
- **Modify**: Let user adjust commit message or file selection
- **Skip**: Leave changes uncommitted for manual handling

### 9.3 · Execute Approved Commit

**If User Approved:**
1. **Auto-execute**: `/project:simone:commit {TASK_ID} yolo`
2. **Verify Success**: Confirm commit creation with SHA
3. **Update Task Metadata**: Add commit SHA to task YAML frontmatter
4. **Log Entry**: Add commit details to task Output Log

### 9.4 · Approval Gate: PR Creation Review

**Present PR Proposal to User:**

```markdown
## 🔀 Ready to Create Pull Request

**Current Status:**
✅ Changes committed to branch: {branch_name}
✅ Task implementation complete
✅ Ready for team review

**Proposed PR Details:**
**Title**: {pr_title_with_task_id}
**Target Branch**: {target_branch}
**Reviewers**: {auto_assigned_reviewers}
**Labels**: {suggested_labels}

**PR Description Preview:**
{auto_generated_pr_description}

**Create this PR? (y/n/modify/skip)**
```

**Handle User Response:**
- **Yes**: Create PR as proposed
- **No/Skip**: Leave branch ready for manual PR creation
- **Modify**: Adjust title, description, reviewers, or target branch

### 9.5 · Execute Approved PR Creation

**If User Approved:**
1. **Auto-execute**: `/project:simone:create_pr {TASK_ID}`
2. **Link PR**: Add PR URL to task metadata
3. **Update Status**: Change task status from "completed" to "review"
4. **Update Manifest**: Reflect PR creation in project tracking

### 9.6 · Final Workflow Summary

**COMPLETION REPORT:**

```markdown
✅ **Task Workflow Complete**: {TASK_ID}

🔧 **Implementation**: All acceptance criteria met
💾 **Committed**: {commit_sha} - Ready for integration  
🔀 **PR Created**: #{pr_number} - Awaiting team review
📋 **Status**: completed → review

⏭️ **Next Steps**:
- PR will be reviewed by assigned team members
- Address any review feedback if needed
- Use `/project:simone:merge {TASK_ID}` when approved
- Monitor PR for review comments and CI status

🎯 **Success Metrics**:
- Estimated: {estimated_effort}h
- Actual: {actual_effort}h  
- Efficiency: {efficiency_percentage}%

🧹 **Cleanup**: Use `/clear` to clear context before next task
```

**Benefits of This Approach:**
- 🛡️ **User Control**: Developer reviews each step before execution
- 🔍 **Quality Assurance**: Chance to verify implementation quality
- ✏️ **Flexibility**: Can modify commit messages, PR details, or scope
- 🎯 **Transparency**: Clear visibility into what's happening at each step
- 🚫 **Reversibility**: Can abort or modify at any checkpoint
