# Process Simone Task based on $Argument

**IMPORTANT:** Follow from Top to Bottom - don't skip anything!

**CREATE A TODO LIST** with exactly these 8 items

1. Analyse scope from argument
2. Identify task file
3. Analyse the task
4. Set status to in_progress
5. Execute task work
6. Placeholder
7. Execute Code review
8. Finalize Task status

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

## 4 · Set status to in_progress

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

## 5 · Execute task work

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

## 6 · Placeholder

Placeholder - just move on to the next step

## 7 · Execute Code Review

Follow these steps for a Code Review (in order)

- include @.claude/commands/simone/code_review.md and use the Task ID as Scope.
- Follow the instructions in the file to run a code review in **PARALLEL SUBAGENTS**
- When done continue acting on the results accordingly
- Understand and think about the results
- on **FAIL**
  - thoroughly understand the problem
  - extend the Current Task with the Subtasks identified by the review
  - go back to "5 · Execute task work"
- on **PASS**
  - move on to next step

## 8 · Finalize task status

**MCP INTEGRATION:** Complete task tracking:
- **Work History**: Log final task completion and outcomes
- **Context7**: Store task completion context for future reference

**Comprehensive Task Completion:**
1. **Update YAML Frontmatter:**
   - **status**: "completed" 
   - **updated_date**: Current timestamp
   - **actual_effort**: Final time spent (hours)
   - Ensure all **dependencies** are resolved
   - Clear any **blocked_by** entries if resolved
   
2. **Update Task Content:**
   - Mark all **Success Criteria** as [x] completed
   - Mark all **Acceptance Criteria** as [x] completed
   - Update **Progress** to 100%
   - Update header status line: **Status**: completed
   
3. **Final Documentation:**
   - Add completion entry to **Output Log**: `[YYYY-MM-DD HH:MM] Task completed successfully - all acceptance criteria met`
   - Fill in **Retrospective Notes** section with lessons learned
   - Update **Next Action** field to indicate completion
   
4. **File Management:**
   - Rename the Task file to TX prefix (TX[TASK_ID]...) for completed recognition
   - Update .simone/00_PROJECT_MANIFEST.md to reflect the new status
   
5. **Quality Verification:**
   - Verify all **Quality Checklist** items are addressed
   - Ensure **Review & Approval** section is complete if required

**Report** the comprehensive result to the user:

  ✅ **Result**: Task completed with full metadata tracking

  📊 **Metrics**: {estimated_effort}h estimated vs {actual_effort}h actual
  
  🔎 **Scope**: {task_description_summary}

  💬 **Summary**: One-paragraph recap of what was done or why blocked

  ⏭️ **Next steps**: Recommended follow-up actions

- **Suggestions** for the User:

  - 🛠️ Use /project:simone:commit `TASK_ID` to commit the changes to git
  - 🧹 Use /clear to clear the context before starting the next Task
