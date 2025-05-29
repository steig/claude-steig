# Create Tasks for Sprint - Execute top to bottom

Create detailed tasks for an existing sprint with integrated implementation guidance.

## Create a TODO with EXACTLY these 8 Items

1. Identify target sprint and verify it exists
2. Load sprint context and related documentation
3. Check for existing ADRs and technical guidance
4. Analyze sprint deliverables for task breakdown
5. Create individual task files with implementation guidance
6. Link ADRs to relevant tasks
7. Update sprint meta with task references
8. Check quality of your work

Follow step by step and adhere closely to the following instructions for each step.

## DETAILS on every TODO item

### 1. Identify target sprint and verify it exists

Check: <$ARGUMENTS>

**REQUIRED:** Sprint ID must be provided (e.g., S02). If empty, ask user to specify which sprint to detail.

- VERIFY sprint directory exists in `.simone/03_SPRINTS/`
- CHECK sprint meta file exists (e.g., `S02_sprint_meta.md`)
- VERIFY sprint status is not already "completed"
- If tasks already exist, ask user if they want to recreate them or any other guidance

### 2. Load sprint context and related documentation

**REQUIRED READING** - Must completely read and understand:

- Sprint meta file (contains goals, deliverables, and context)
- Milestone requirements in `.simone/02_REQUIREMENTS/` that apply to this sprint
- Project manifest in `.simone/00_PROJECT_MANIFEST.md` for current project state
- Architecture documentation in `.simone/01_PROJECT_DOCS/ARCHITECTURE.md`

**CONTEXT UNDERSTANDING:**

- What are the sprint's specific deliverables?
- What milestone does this sprint serve?
- What are the technical constraints and patterns?
- What is the current project state?

**IMPORTANT:** Sprint tasks must align with documented sprint goals, not expand scope.

### 3. Check for existing ADRs and technical guidance

- SEARCH `.simone/05_ARCHITECTURE_DECISIONS/` for ADRs matching sprint ID (e.g., `ADR*_S02_*.md`)
- READ all found ADRs to understand technical decisions
- CHECK sprint meta for ADR references section
- NOTE which technical decisions will affect task implementation
- BUILD RELATIONSHIP in task and subtasks and make clear what to implement

**If conflict in Scope** Between ADR and Sprint goal, try to think about it and ask the user to resolve the conflict.

**If no ADRs found:** Proceed but note that tasks may need clarification during implementation.

### 4. Analyze sprint deliverables for task breakdown

Based on sprint goals and deliverables:

- BREAK DOWN high-level deliverables into concrete, implementable tasks
- ENSURE each task represents a coherent feature or component
- CONSIDER logical dependencies between tasks
- MAP tasks to relevant ADRs for technical guidance
- DEFER complexity assessment until after tasks are fully created with subtasks

### 5. Create individual task files with proper structure

For each identified task:

- ALL TASK FILES need to be created in the Sprint Directory (where the sprint meta file is)
- CREATE file with naming: `T<NN>_S<NN>_<Descriptive_Name>.md`
- USE sequential numbering starting from T01
- FOLLOW task template structure exactly

Use the task template in `.simone/99_TEMPLATES/task_template.md` as a template to create the task file.

**IMPORTANT:** Be specific in goals and acceptance criteria. Vague tasks lead to implementation drift.

### 6. Link ADRs to relevant tasks

For each task that relates to an ADR:

- ADD ADR reference in task's "Related Documentation" section
- SUMMARIZE relevant ADR decisions in task context
- ENSURE task implementation aligns with ADR guidance
- CREATE clear connection between architectural decision and implementation approach

### 7. Update sprint meta with task references

Update the sprint meta file:

- ADD "## Tasks" section if it doesn't exist
- LIST all created tasks with their IDs and brief descriptions
- MAINTAIN task order T01, T02, T03...
- PRESERVE all existing sprint meta content
- UPDATE last_updated timestamp

### 8. Check quality of your work

**Quality Verification:**

- [ ] All tasks follow naming convention T##_S##_Description.md
- [ ] Each task has clear, specific acceptance criteria
- [ ] Tasks map clearly to sprint deliverables
- [ ] ADR guidance is incorporated where relevant
- [ ] Task dependencies are identified and documented
- [ ] Sprint meta is updated with task references
- [ ] No task is overly broad (should be completable in one session)
- [ ] Technical approach aligns with project architecture

**Final Report:**

```
✅ **Sprint Detailed**: S## 
📋 **Tasks Created**: [Number] tasks (T01_S##, T02_S##, ...)
🎯 **Deliverables Covered**: [List key deliverables]
📚 **ADRs Integrated**: [List relevant ADRs if any]
⏭️ **Ready for Execution**: Use `do_task T##_S##` to begin implementation
```

## IMPORTANT GUIDELINES

- **Sprint scope is sacred** - Don't add tasks beyond documented sprint goals
- **ADRs provide implementation guidance** - Reference them in task details
- **Each task should be achievable in one Claude session** - Break down complex work
- **Acceptance criteria must be specific** - Avoid vague requirements
- **Dependencies matter** - Note when tasks must be done in specific order
- **Quality over quantity** - Better to have fewer, well-defined tasks