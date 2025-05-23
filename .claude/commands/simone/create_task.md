Create a new general task in the Simone framework.
Task Description: $ARGUMENTS

High-Level Instructions:
1.  Determine the next `last_general_task_id` from `.simone/00_PROJECT_MANIFEST.md`.
2.  Create the new task file in `.simone/04_GENERAL_TASKS/` (using `task_template.md`), inferring a suitable filename.
3.  Populate necessary frontmatter (`task_id`, `status: open`, `complexity`).
4.  Set the task's `## Description`. Add placeholder goals and acceptance criteria.
5.  Update `last_general_task_id` in `.simone/00_PROJECT_MANIFEST.md`.
6.  Confirm creation and provide the new task file path.
