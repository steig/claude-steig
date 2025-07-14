# Create Pull Request - Automated PR Creation and Management

> ⚠️ **DEPRECATED**: This command has been superseded by `create_pr_auto` which provides comprehensive automation, AI-generated content, intelligent reviewer assignment, and quality validation. This command will be removed in v3.0.0.
>
> **Migration**: Use `/project:simone:create_pr_auto <task_id> --auto-assign --comprehensive` instead.

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise for intelligent PR creation and review preparation.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: Architecture-focused PR descriptions and system impact analysis
- `--persona-security`: Security-aware PR validation and compliance checklist
- `--persona-frontend`: Frontend-specific PR descriptions and UX impact assessment
- `--persona-backend`: Backend system PR analysis and API impact documentation
- `--persona-analyzer`: Code quality metrics and change impact analysis for PR
- `--persona-mentor`: Educational PR descriptions and best practices guidance
- `--persona-refactorer`: Refactoring-focused PR organization and improvement documentation
- `--persona-performance`: Performance impact analysis and optimization documentation
- `--persona-qa`: Testing-focused PR validation and quality assurance checklist

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning for PR structure and description decisions
- `--consensus`: Multi-model consensus for complex PR validation
- `--think-deep`: Extended analysis for complex changes and their implications

**USAGE EXAMPLES:**
- `/project:simone:create_pr T001 --persona-security` (Security-focused PR with compliance checklist)
- `/project:simone:create_pr T001 --persona-architect --introspect` (Architecture changes with transparency)
- `/project:simone:create_pr BUG123 --persona-analyzer --persona-qa` (Bug fix with quality focus)

Creates pull requests with auto-generated descriptions, checklists, and proper linking to tasks/bugs.

## Create a TODO with EXACTLY these 8 Items

1. Parse arguments and identify context (task/bug)
2. Analyze current branch and validate PR readiness
3. Gather task/bug information and requirements
4. Generate PR title and description from templates
5. Create acceptance criteria checklist
6. Push branch and create GitHub PR
7. Link PR to task/bug tracking
8. Provide PR management guidance

## DETAILS on every TODO item

### 1. Parse arguments and identify context (task/bug)

**Arguments Format:** `<TASK_ID/BUG_ID>` or auto-detect from branch

**Context Detection:**
- **From Arguments**: t##-s##, t###, or bug### format
- **From Branch Name**: Extract from current branch if no argument
  - `task/t01-s02` → t01-s02
  - `bug/bug001` → bug001
  - `hotfix/bug002` → bug002
- **Validation**: Ensure context exists and is valid

**Error Handling:**
- If no context found, list available tasks/bugs
- If on main/master branch, warn and exit
- If context doesn't match branch, ask user for clarification

### 2. Analyze current branch and validate PR readiness

**Branch Validation:**
- Verify on feature branch (not main/master)
- Check commits exist beyond base branch
- Ensure all changes are committed
- Verify branch is pushed to remote (if not, offer to push)

**PR Readiness Checks:**
- **Commits**: At least one commit beyond base branch
- **Clean State**: No uncommitted changes
- **Remote Sync**: Branch exists on remote or ready to push
- **Conflicts**: Check for merge conflicts with target branch

**Target Branch Detection:**
- **Default**: main/master
- **Hotfix Branches**: Can target main for immediate deployment
- **Feature Branches**: Target develop if Git Flow, otherwise main
- **User Override**: Allow user to specify target branch

### 3. Gather task/bug information and requirements

**MCP INTEGRATION:** Use MCP servers for enhanced PR creation:
- **Sequential Thinking**: Structure PR information gathering systematically
- **Work History**: Reference similar PRs and their outcomes
- **Context7**: Maintain context about task/bug relationships
- **Serena**: Enhance code analysis for PR description

**Task Information Gathering:**
- Read task/bug file completely
- Extract title, description, and acceptance criteria
- Identify type (feature, bug, refactor, etc.)
- Gather effort estimates and complexity
- Check completion status and remaining work

**Code Analysis:**
- Analyze changed files and their purposes
- Identify affected components and systems
- Check for breaking changes
- Assess security implications
- Review test coverage

### 4. Generate PR title and description from templates

**PR Title Generation:**
```
{type}({scope}): {description} ({TASK_ID/BUG_ID})
```

**Examples:**
- `feat(auth): implement user authentication (t01-s02)`
- `fix(login): resolve validation error (bug001)`
- `hotfix(security): patch authentication bypass (bug002)`

**PR Description Template:**
```markdown
## Summary
{AI-generated summary based on task/bug and code changes}

## Related Work
- **Task/Bug**: [{TASK-ID/BUG-ID}]({link_to_task_file})
- **Type**: {task_type}
- **Complexity**: {complexity}
- **Estimated Effort**: {effort}h

## Changes Made
{AI-generated list of changes based on git diff analysis}

## Testing
{Testing approach based on task acceptance criteria}

## Breaking Changes
{Any breaking changes identified}

## Deployment Notes
{Any special deployment considerations}

## Screenshots/Evidence
{Placeholder for visual evidence if applicable}
```

### 5. Create acceptance criteria checklist

**Auto-Generated Checklist:**
Extract from task/bug acceptance criteria and convert to PR checklist:

```markdown
## Acceptance Criteria
{Each acceptance criterion becomes a checkbox}

## Definition of Done
- [ ] Code follows project standards
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] No breaking changes (or properly documented)
- [ ] Security review completed (if applicable)
- [ ] Performance impact assessed
- [ ] Accessibility requirements met (if applicable)

## Review Checklist
- [ ] Code review completed
- [ ] Tests reviewed and adequate
- [ ] Documentation reviewed
- [ ] Breaking changes approved
- [ ] Deployment plan reviewed
```

### 6. Push branch and create GitHub PR

**Branch Push Process:**
- Check if branch exists on remote
- If not, push with upstream: `git push -u origin <branch_name>`
- If exists, ensure it's up to date: `git push`

**GitHub PR Creation:**
```bash
gh pr create \
  --title "{generated_title}" \
  --body "$(cat <<'EOF'
{generated_description_with_checklists}
EOF
)" \
  --base {target_branch} \
  --head {current_branch}
```

**PR Configuration:**
- **Labels**: Auto-apply based on task type (feature, bug, hotfix)
- **Reviewers**: Add based on project configuration
- **Assignees**: Assign to task assignee
- **Projects**: Link to project boards if configured
- **Milestones**: Link to current milestone if applicable

### 7. Link PR to task/bug tracking

**Task/Bug Updates:**
- Add PR link to task/bug YAML frontmatter: `pull_request: "{pr_url}"`
- Update status: tasks to "review", bugs to "testing"
- Log PR creation in Output Log
- Update estimated vs actual effort if task complete

**Cross-Reference Updates:**
- Update project manifest with PR information
- Link related tasks/bugs if applicable
- Update sprint tracking with PR status

**Status Synchronization:**
- Task "completed" + PR created = Task "review"
- Bug "testing" + PR created = Bug "testing"
- PR merged = Update final status

### 8. Provide PR management guidance

**PR Information Display:**
```markdown
🔀 **Pull Request Created Successfully**

📋 **PR Details**:
- **URL**: {pr_url}
- **Title**: {pr_title}
- **Base**: {target_branch} ← **Head**: {current_branch}
- **Context**: {TASK-ID/BUG-ID}

📊 **Metrics**:
- **Files Changed**: {file_count}
- **Insertions**: +{insertions}
- **Deletions**: -{deletions}
- **Estimated Effort**: {effort}h

✅ **Next Steps**:
1. **Review**: Wait for code review from team members
2. **Testing**: Ensure all checks pass
3. **Updates**: Address any review feedback
4. **Merge**: Use `/project:simone:merge {TASK-ID/BUG-ID}` when approved

🔧 **PR Management Commands**:
- **Update PR**: Make additional commits and push
- **Review PR**: `/project:simone:review_pr {TASK-ID/BUG-ID}` (coming soon)
- **Merge PR**: `/project:simone:merge {TASK-ID/BUG-ID}` (coming soon)
- **Close PR**: Use GitHub UI if not needed
```

**Workflow Integration:**
- PR created from task → Update task tracking
- PR created from bug → Update bug tracking
- PR links maintained in project documentation
- Automated status updates based on PR state

## Advanced Features

### Draft PR Support
- Create draft PRs for work-in-progress
- Automatic promotion to ready when task complete
- Clear indication of draft status in descriptions

### Template Customization
- Project-specific PR templates
- Task-type specific sections
- Custom checklist items based on project needs

### Automated Checks Integration
- Reference CI/CD pipeline status
- Include test coverage requirements
- Security scanning results
- Performance benchmark requirements

### Multi-Repository Support
- Handle PRs across related repositories
- Cross-repository task tracking
- Coordinated release management

This command completes the Git workflow by providing seamless PR creation with full integration to the Simone task management system.