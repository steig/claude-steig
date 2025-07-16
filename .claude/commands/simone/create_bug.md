# Create Bug Report - Execute top to bottom

Creates a new bug report in `.simone/06_BUGS/` following comprehensive bug tracking standards with automatic task generation and GitHub integration.

## Create a TODO with EXACTLY these 11 Items

1. Parse bug arguments and determine bug ID
2. Load project context and bug tracking requirements
3. Verify bug doesn't duplicate existing reports
4. Research codebase for bug context and impact
5. Create bug report file using bug template
6. Fill in bug details with comprehensive information
7. Add technical analysis and reproduction guidance
8. Generate bug fix tasks automatically
9. Create GitHub issue with proper linking
10. Update project manifest with new bug
11. Perform final quality check and report

## DETAILS on every TODO item

### 1. Parse bug arguments and determine bug ID

The argument format is: `<Bug Title or Description>`

- If arguments are empty, prompt user for bug details interactively
- Generate sequential bug ID by examining existing bugs in `.simone/06_BUGS/`
- Find highest bug number (BUG###) and increment by 1
- Format: `BUG###_<Bug_Title_Snake_Case>.md`
- **IMPORTANT:** Bug IDs must be sequential with no gaps

### 2. Load project context and bug tracking requirements

**MCP INTEGRATION:** Use MCP servers to enhance bug report creation:
- **Sequential Thinking**: Structure bug analysis process systematically
- **GitHub**: Reference similar bugs and their resolutions
- **Context7**: Maintain context about project state and known issues
- **Serena**: Enhance codebase analysis for bug impact assessment

Use PARALLEL SUBAGENTS to READ and UNDERSTAND the project's context:

- READ `.simone/00_PROJECT_MANIFEST.md` - Get current project state
- READ `.simone/01_PROJECT_DOCS/ARCHITECTURE.md` - Understand system architecture
- SCAN `.simone/06_BUGS/` for existing bug patterns and categories
- READ latest files in `.simone/10_STATE_OF_PROJECT/` - Review current health
- SCAN `.simone/05_ARCHITECTURE_DECISIONS/` for relevant constraints
- **IMPORTANT:** Bug analysis must align with documented architecture

### 3. Verify bug doesn't duplicate existing reports

**SEARCH** comprehensively for potential duplicates:

- Check all files in `.simone/06_BUGS/` for similar symptoms
- Search for related issues in sprint tasks `.simone/03_SPRINTS/*/T*.md`
- Look for similar problems in completed general tasks
- Check if issue is already documented as known limitation
- **CRITICAL:** If duplicate found, mark as duplicate and reference original bug

### 4. Research codebase for bug context and impact

Based on the bug description, use PARALLEL SUBAGENTS to:

- SEARCH for code areas likely affected by the bug
- IDENTIFY key components, files, and functions involved
- FIND recent changes that might have introduced the bug (git history)
- LOCATE relevant test files and existing test coverage
- DISCOVER error handling patterns in affected areas
- MAP OUT integration points and dependencies
- ANALYZE potential security implications
- **DOCUMENT** all findings for inclusion in bug report

### 5. Create bug report file using bug template

**Create bugs directory if it doesn't exist:**
- Create `.simone/06_BUGS/` directory if not present
- This is a new directory for comprehensive bug tracking

**USE** the bug template in `.simone/99_TEMPLATES/bug_template.md` as base structure:

- Copy template structure exactly
- Place file in `.simone/06_BUGS/BUG###_<Title>.md`
- Include timestamp: Execute `date '+%Y-%m-%d %H:%M:%S'` for creation time
- **IMPORTANT:** Follow template structure precisely - no deviations

### 6. Fill in bug details with comprehensive information

**Template Population - Complete ALL YAML frontmatter fields:**

**YAML Frontmatter (CRITICAL - populate every field):**
- **bug_id**: "BUG###" (generated ID)
- **bug_title**: Clear, specific bug description
- **bug_type**: "bug" (always "bug")
- **severity**: Assess as: critical, high, medium, low based on impact
- **priority**: Assess as: critical, high, medium, low based on urgency
- **status**: "open"
- **created_date**: Current timestamp (YYYY-MM-DD)
- **updated_date**: Current timestamp (YYYY-MM-DD)
- **reporter**: "User" or specific reporter name
- **assignee**: "TBD" initially
- **milestone_id**: Current milestone or "N/A"
- **sprint_id**: "N/A" initially (will be assigned when scheduled)
- **component**: Affected component (frontend, backend, database, api, infrastructure)
- **environment**: Where bug occurs (production, staging, development, local)
- **browser**: Browser if web-related or "N/A"
- **os**: Operating system if relevant or "N/A"
- **version**: Product version where bug was found
- **tags**: Relevant tags like ["ui", "performance", "security"]
- **duplicate_of**: "N/A" unless this is a duplicate
- **related_bugs**: Array of related bug IDs or ["none"]
- **estimated_effort**: "TBD" initially
- **actual_effort**: "0" initially
- **github_issue**: "N/A" initially (will be populated after GitHub issue creation)
- **github_url**: "N/A" initially (will be populated after GitHub issue creation)

**Content Sections (populate thoroughly based on research):**
- **Bug Summary**: Clear description with expected vs actual behavior
- **Reproduction Details**: Step-by-step reproduction with prerequisites
- **Environment Information**: System details and configuration
- **Evidence & Documentation**: Error messages, logs, screenshots
- **Analysis & Investigation**: Root cause analysis and affected code areas
- **Fix Strategy**: Proposed solution and risk assessment
- **Implementation Plan**: Fix tasks and testing requirements

### 7. Add technical analysis and reproduction guidance

**Technical Analysis section:**

- Root cause hypothesis based on codebase research
- Specific files and functions likely involved (with line references)
- Integration points that might be affected
- Database queries or API calls involved
- Performance implications if applicable
- Security considerations if relevant

**Reproduction Guidance section:**

- Detailed step-by-step reproduction instructions
- Required test data or configuration
- Expected vs actual results at each step
- Browser developer tools usage if applicable
- Log files to check and what to look for
- Environment setup requirements

**IMPORTANT:** Base all technical analysis on actual codebase research, not assumptions.

### 8. Generate bug fix tasks automatically

**AUTOMATICALLY CREATE** bug fix tasks in the appropriate location:

- Determine if bug should be in current sprint or general tasks
- For **current sprint bugs**: Create task in current sprint folder
- For **general bugs**: Create task in `.simone/04_GENERAL_TASKS/`

**Task Creation Process:**
- Use `create_sprint_tasks` or `create_general_task` command approach
- Generate task ID following normal conventions (T### for general, or sprint sequence)
- Set task_type to "bug" in the generated task
- Link task to bug report with cross-references
- Include bug analysis and fix strategy in task description
- Set appropriate priority and complexity based on bug severity

**Task Template Population:**
- **Title**: "Fix BUG###: [Bug Title]"
- **Description**: Reference to bug report and fix requirements
- **Acceptance Criteria**: Based on bug verification requirements
- **Implementation Notes**: Technical guidance from bug analysis
- **Dependencies**: Any prerequisite tasks or investigations

### 9. Create GitHub issue with proper linking

**GitHub Issue Creation:**
- Use `gh issue create` command with bug report template
- Include bug ID reference and reproduction steps
- Add appropriate labels based on severity/component
- Link to local bug report file in issue description
- Set milestone if applicable

**GitHub CLI Commands:**
```bash
# Create issue using template
gh issue create --template bug_report.yml \
  --title "[BUG] {bug_title}" \
  --body "Related Bug Report: [BUG###](.simone/06_BUGS/BUG###_Title.md)

Reproduction Steps:
{reproduction_steps}

Environment: {environment}
Severity: {severity}
Component: {component}

For detailed analysis, see local bug report: .simone/06_BUGS/BUG###_Title.md"

# Add labels based on severity and component
gh issue edit {issue_number} --add-label "{severity},component/{component}"
```

**Cross-Reference Updates:**
- Add `github_issue: "{issue_number}"` to bug report YAML
- Add `github_url: "{issue_url}"` to bug report YAML
- Update bug report with GitHub issue URL in description
- Link GitHub issue in project manifest

### 10. Update project manifest with new bug

**UPDATE** `.simone/00_PROJECT_MANIFEST.md`:

- Add new section "## Open Bugs" if not present
- Add bug to bugs section: `- [ ] BUG###: [Bug Title] - Status: Open (Priority: [priority]) - [GitHub #{issue_number}]({github_url})`
- Maintain numerical ordering
- Link to bug file: `[BUG###](06_BUGS/BUG###_Title.md)`
- Update "Last Updated" timestamp
- **IMPORTANT:** Preserve all existing content

**UPDATE** bug statistics if tracking:
- Increment total bug count
- Update open bug count
- Update severity distribution

### 11. Perform final quality check and report

**QUALITY CHECK**:

- Bug report follows template completely
- All sections properly filled with researched information
- Technical analysis references actual codebase findings
- Bug ID is sequential and unique
- Manifest updated correctly
- Associated fix task created and properly linked
- GitHub issue created and properly cross-referenced
- No duplicate bug exists
- Severity and priority assessments are appropriate

**VERIFICATION**:
- Bug report file created in correct location
- Template structure maintained
- Cross-references between bug, task, and GitHub issue are correct
- Manifest links work properly
- All required fields populated
- GitHub issue accessible and properly labeled

**OUTPUT FORMAT**:

```markdown
🐛 **Created**: BUG###_<Title>.md
📋 **Type**: Bug Report
🚨 **Severity**: [severity] | **Priority**: [priority]
📍 **Component**: [component] | **Environment**: [environment]
🔗 **Fix Task**: [task_id] - [task_location]
📝 **GitHub Issue**: #{issue_number} - {github_url}
📚 **Analysis**: [key_findings_summary]
🧪 **Reproduction**: [reproduction_complexity]
⏭️ **Next Step**: Review bug details and run `/project:simone:fix_bug [BUG###]` to begin fix
```

## Bug Workflow Integration

**Automatic Task Generation Rules:**

1. **Critical/High Severity**: Always create task in current sprint
2. **Medium Severity**: Create in current sprint if capacity allows, otherwise general tasks
3. **Low Severity**: Create in general tasks unless explicitly requested for sprint

**Status Tracking Integration:**

- Bug status automatically updates when associated task status changes
- Task completion triggers bug status change to "testing"
- Bug verification completion triggers status change to "closed"

**GitHub Integration:**

- Automatic issue creation with comprehensive template
- Cross-referencing between local bug reports and GitHub issues
- Label management based on severity and component
- Milestone assignment when applicable

**Reporting Integration:**

- Bugs automatically included in project health reports
- Bug metrics tracked in project manifest
- Severity trends monitored in state of project snapshots
- GitHub integration provides external visibility and collaboration