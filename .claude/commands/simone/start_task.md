# Start Task - Create Branch and Set Up Task Environment

> ⚠️ **DEPRECATED**: This command functionality has been merged into `do_task` and `do_task_auto`. Branch creation and environment setup are now handled automatically during task execution. This command will be removed in v3.0.0.
>
> **Migration**: Use `/project:simone:do_task <task_id>` or `/project:simone:do_task_auto <task_id>` instead.

Creates a Git branch for a task and sets up the development environment without executing the task implementation.

## Create a TODO with EXACTLY these 6 Items

1. Parse task arguments and validate
2. Locate and analyze task file
3. Check current Git status and clean working directory
4. Create and switch to task branch
5. Update task metadata and status
6. Provide next steps guidance

## DETAILS on every TODO item

### 1. Parse task arguments and validate

**Arguments Format:** `<Task_ID>` (e.g., "t01-s02", "t003", "bug001")

**Validation Process:**
- Accept task IDs: T##_S##, T###, or BUG### formats
- If no argument provided, list available open tasks and prompt user
- Validate task exists and is not already completed
- Support both full task names and just IDs

**Task Type Detection:**
- **Sprint Tasks**: t##-s## pattern (e.g., t01-s02)
- **General Tasks**: T### pattern (e.g., T003)
- **Bug Tasks**: BUG### pattern (e.g., BUG001)

### 2. Locate and analyze task file

**MCP INTEGRATION:** Use MCP servers for enhanced task analysis:
- **Sequential Thinking**: Structure task analysis systematically
- **Context7**: Maintain context about project state and requirements
- **Work History**: Reference similar task setups and outcomes

**Task Location Process:**
- Search `.simone/03_SPRINTS/*/T*.md` for sprint tasks
- Search `.simone/04_GENERAL_TASKS/T*.md` for general tasks
- Search `.simone/06_BUGS/BUG*.md` for bug reports
- If task not found, provide helpful error with available tasks

**Task Analysis:**
- Read task metadata from YAML frontmatter
- Check current status (should be "pending" or "open")
- Identify task type, complexity, and estimated effort
- Check for dependencies and blockers
- Extract task title for branch naming

### 3. Check current Git status and clean working directory

**Git Status Validation:**
- Run `git status` to check for uncommitted changes
- Check current branch name
- Verify repository is in clean state

**Handling Uncommitted Changes:**
- If changes exist, pause and present options:
  - **Option 1**: Commit current changes first
  - **Option 2**: Stash changes and continue
  - **Option 3**: Abort task start
- Guide user through chosen option

**Branch Preparation:**
- If on feature branch, warn about potential issues
- Switch to main/master branch as starting point
- Pull latest changes: `git pull origin main`
- Verify clean working directory before proceeding

### 4. Create and switch to task branch

**Branch Naming Strategy:**

**For Sprint Tasks:**
```
task/t##-s##
```
Example: `task/t01-s02`

**For General Tasks:**
```
task/t###
```
Example: `task/t003`

**For Bug Tasks:**
```
bug/bug###
hotfix/bug###  # for critical/high severity
```
Examples: 
- `bug/bug001`
- `hotfix/bug002`

**Branch Creation Process:**
1. **Generate Branch Name**: Use task/milestone ID only (no title or description)
2. **Check Uniqueness**: If branch exists, append timestamp `-YYYYMMDD-HHMM`
3. **Create Branch**: `git checkout -b <branch_name>`
4. **Verify Creation**: `git branch --show-current`

**Severity-Based Branching (for bugs):**
- **Critical/High Severity**: Use `hotfix/` prefix for fast-track process
- **Medium/Low Severity**: Use `bug/` prefix for normal workflow

### 5. Update task metadata and status

**Task Metadata Updates:**
- Add `git_branch: "<branch_name>"` to task YAML frontmatter
- Update `updated_date` to current timestamp
- Set `assignee: "Claude"` if not already assigned
- Log branch creation in task Output Log

**Status Management:**
- **Option 1**: Keep status as "pending" (just branch creation)
- **Option 2**: Update status to "in_progress" (if user wants to start immediately)
- Ask user preference for status update

**Project Manifest Update:**
- Update `.simone/00_PROJECT_MANIFEST.md` if status changed
- Log task assignment and branch creation
- Update last modified timestamp

**Cross-Reference Updates:**
- For bug tasks: Update both bug report and associated task file
- Maintain consistency between related files
- Log all metadata changes with timestamps

### 6. Provide next steps guidance

**Workflow Guidance:**

```markdown
✅ **Task Setup Complete**: {TASK_ID}

🌿 **Branch Created**: {branch_name}
📋 **Task Type**: {task_type} | **Status**: {current_status}
🎯 **Complexity**: {complexity} | **Estimated**: {estimated_effort}h

📚 **Task Summary**: {brief_task_description}

⏭️ **Next Steps**:

**Option 1: Start Task Implementation**
- Run `/project:simone:do_task {TASK_ID}` to begin implementation
- This will set status to in_progress and execute the work

**Option 2: Review and Plan**
- Review task requirements in the task file
- Check dependencies and acceptance criteria
- Plan implementation approach

**Option 3: Manual Development**
- Begin development manually in your IDE
- Use `/project:simone:commit {TASK_ID}` when ready to commit
- Update task status with `/project:simone:update_task_status {TASK_ID} in_progress`

🔧 **Development Tips**:
- All changes will be isolated to your feature branch
- Use conventional commit messages referencing {TASK_ID}
- Run tests frequently during development
- Update task documentation as you progress

📁 **Relevant Files**:
- **Task File**: {task_file_path}
- **Requirements**: {relevant_requirements_files}
- **Architecture**: {relevant_architecture_docs}
```

**Error Recovery:**
- If branch creation failed, provide recovery steps
- If task file updates failed, guide user through manual updates
- If Git operations failed, provide troubleshooting guidance

## Integration Features

### Dependency Handling
- Check task dependencies before branch creation
- Warn if dependent tasks are not completed
- Option to create branch from dependency task's branch

### Sprint Integration
- Verify task belongs to current active sprint
- Check sprint capacity and velocity
- Update sprint tracking with new active task

### Parallel Development Support
- Allow multiple task branches simultaneously
- Track active branches in project manifest
- Provide guidance on managing multiple streams of work

### MCP Server Integration
- **Work History**: Log task start patterns and branch naming decisions
- **Sequential Thinking**: Structure task setup process systematically
- **Context7**: Maintain context about task relationships and project state
- **Serena**: Enhance task analysis and development environment setup

## Branch Management Best Practices

### Naming Conventions
- Always use prefixes: `task/`, `bug/`, `hotfix/`
- Include task/bug ID for traceability
- Use descriptive but concise names
- Follow slug format (kebab-case) for readability and URL compatibility

### Branch Lifecycle
- Branch created from latest main/master
- Work isolated to feature branch
- Regular commits with task references
- PR creation when ready for review
- Branch deletion after merge

### Multi-Task Scenarios
- One branch per task for isolation
- Dependencies handled through base branch selection
- Clear documentation of branch relationships
- Guidance on merge order for dependent tasks

This command provides a clean separation between task setup and task execution, allowing developers to prepare their environment and plan their approach before diving into implementation.