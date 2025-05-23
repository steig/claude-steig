# Plan the next Sprint based on $Argument and create all necessary files

Follow these instructions from top to bottom.

## Create a TODO with EXACTLY these 9 items

1. Analyse input argument
2. Locate or choose milestone
3. Determine sprint ID & focus
4. Create sprint skeleton
5. Generate tasks
6. Refine complexity
7. Analyze Sprint for Project alignment
8. Update manifest
9. Report plan

---

## 1 · Analyse input argument

You are given additional Arguments: <$ARGUMENTS>

- Interpret the Arguments for Milestone IDs or Focus keywords.
- Think to understand the context.

## 2 · Locate or choose milestone

- Look up Milestones from `.simone/02_MILESTONES/`.
- If no Milestone ID is given, pick the latest active on. Check on `.simone/00_PROJECT_MANIFEST.md` for current progress status.
- If you fail to find a fitting Milestone, report back to the User.
- Ultrathink about Milestone requirements. This is our source of truth

## 3 · Determine sprint ID & focus

- Check Project Manifest and `.simone/03_SPRINTS/` to find the highest existing sprint number for the milestone, then increment (e.g. `S02` → `S03`).
- Sprint name: `<Sxx>_<milestone_short>-<focus_snake_case>-`.
- If no Focus is given analyze completed sprints for work that has already been done to find the focus for the next sprint.
- **IMPORTANT:** The Milestone requirements are our single source of truth for sprints. The focus can only be mapped on Milestone Requirements, not invent new things not in the scope of the Milestone.

## 4 · Create sprint skeleton

- Make folder `.simone/03_SPRINTS/<SPRINT_ID>/`.
- Use the Template from `.simone/99_TEMPLATES/sprint_meta_template.md` to create the Sprint Meta File.

## 5 · Generate tasks

- Scan milestone requirement docs and Specs and Architecture in `.simone/01_PROJECT_DOCS`.
- Compare against completed Sprints with the current Focus in mind.
- **IMPORTANT:** You must follow Milestone Requirements. Don't create new Ideas for the project.
- For each discrete deliverable:
  - create `T<nn>_<SPRINT_ID>_<slug>.md` from `task_template.md`.
  - **IMPORTANT:** include links to any critical structural docs (DB schema, dir layout, API spec) under a “Important References” dash list. Be extra detailled here. This is important context for the Task executor later.
  - write Description, Goal, Acceptance Criteria, and estimate Complexity (Low / Medium / High).

## 6 · Refine complexity

- If any task is **High** complexity, split it until each resulting task is Medium or lower.
- Ensure each task’s scope is tight and testable.

## 7 · Analyze Sprint for Project alignment

- Analyze the created sprint and tasks for alignment towards our Project.
- Take .simone/01_PROJECT_DOCS and .simone/02_REQUIREMENTS (Current Milestone) into account
- The Scope and Details of the Sprint **must** adhere to Project Specs and Milestone Requirements.
- Ultrathink about this
- Report the result of this Analysis to the User.
- If you find deviation, fix it immediately and report to the user.

## 8 · Update manifest

- Update `.simone/00_PROJECT_MANIFEST.md` to the new Sprint.

## 9 · Report plan

- **Sprint ID:** <new_id>
- **Focus:** <focus text>
- **Tasks:** dash list of `<ID> – title (Complexity)`
- **Complexity:** report maximum complexity and reason if a task is still high complexity.
- **Alignment:** one-sentence note on how the sprint advances the architecture.
- **Structural reminders:** dash list of the most critical docs each task must follow.
