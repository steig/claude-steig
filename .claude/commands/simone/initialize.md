# Initialize Simone Framework

Initialize and set up the Simone project management framework for this project.

## Create a TODO with EXACTLY these 6 items

1. Verify Simone installation and understand framework
2. Identify project state (new or existing)
3. Check for real documentation and milestones
4. Generate or update project manifest
5. Provide framework guidance
6. List available commands and next steps

Follow each step in order and complete all tasks.

## DETAILS on every TODO item

### 1. Verify Simone installation and understand framework

- Verify `.simone/` directory exists with all required subdirectories
- Verify `.claude/commands/simone/` directory exists
- Read `.simone/CLAUDE.MD` to understand the framework structure
- Read `.simone/README.md` to understand Simone's purpose and workflow
- Check templates exist in `.simone/99_TEMPLATES/`
- Report any missing components

### 2. Identify project state (new or existing)

Check if this is a fresh setup or existing project by examining:

- `00_PROJECT_MANIFEST.md` - look for "Your Project Name" or other placeholders
- `01_PROJECT_DOCS/ARCHITECTURE.md` - check if it's the example file
- `02_REQUIREMENTS/M01_Backend_Setup/` - check if it's example content

**Determine**: Is this a new project using example files, or an existing project with real content?

### 3. Check for real documentation and milestones

**For new projects**, check if user has already created:

- Real ARCHITECTURE.md in `01_PROJECT_DOCS/` (not the example)
- At least one real milestone folder in `02_REQUIREMENTS/` (not M01_Backend_Setup)
- Any sprint folders in `03_SPRINTS/`

**For existing projects**:

- Skip to step 4 if manifest is already customized
- Otherwise check for real content as above

### 4. Generate or update project manifest

**If real documentation AND milestones exist:**

- Read template from `.simone/99_TEMPLATES/project_manifest_template.md`
- Extract information:
  - Project name from current directory or prompt user
  - Vision/overview from ARCHITECTURE.md introduction
  - Current milestone from newest folder in `02_REQUIREMENTS/`
  - Sprint info from `03_SPRINTS/` if any exist
- Generate new manifest using template
- Replace example manifest with generated version
- Use current timestamp (get system date first)

**If still using only examples:**

- Keep example manifest as-is
- Inform user that manifest will auto-generate after creating real content

### 5. Provide framework guidance

**For new users (using examples):**

- Explain Simone's context management approach
- Guide them through next steps:
  1. Create ARCHITECTURE.md with their project's technical approach
  2. Create first milestone folder with requirements
  3. Re-run initialize to generate manifest
- Offer to help create ARCHITECTURE.md if requested

**For existing users:**

- Summarize current project state from manifest
- Identify current milestone and sprint
- Check for any in-progress tasks
- Suggest next actions based on project state

### 6. List available commands and next steps

- List all commands found in `.claude/commands/simone/`
- Explain command pattern: `/project:simone:<command>`
- Recommend next commands based on project state:
  - New projects: `plan_milestone` after creating requirements
  - Existing projects: `do_task` or `project_review`
- Remind that Simone guides the workflow from here
