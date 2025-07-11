# Merge Pull Request - Smart PR Merging with Task Integration

Intelligently merges pull requests with task/bug status updates and branch cleanup.

**CRITICAL FIX:** Task status updates and file renaming now occur BEFORE merge execution (step 4) and are staged to be included in the merge commit itself. This ensures all task metadata changes happen atomically with the code merge.

## Create a TODO with EXACTLY these 7 Items

1. Parse arguments and locate PR/task context
2. Validate PR readiness and approval status
3. Perform pre-merge validations and tests
4. Update task/bug status and prepare metadata changes
5. Execute merge with staged task metadata changes
6. Clean up branches and references
7. Provide post-merge guidance and next steps

## DETAILS on every TODO item

### 1. Parse arguments and locate PR/task context

**Arguments Format:** `<TASK_ID/BUG_ID/PR_URL>` or auto-detect from branch

**Context Detection Methods:**
- **Task/Bug ID**: t01-s02, t003, bug001 → Find associated PR
- **PR URL**: Full GitHub PR URL → Extract PR number
- **PR Number**: #123 → Use directly
- **Auto-detect**: Extract from current branch name
- **Branch Name**: Extract task/bug context from branch

**Validation:**
- Verify task/bug exists and is in appropriate status
- Confirm PR exists and is associated with task/bug
- Validate current user has merge permissions
- Check if PR is ready for merging

### 2. Validate PR readiness and approval status

**MCP INTEGRATION:** Use MCP servers for enhanced merge validation:
- **Sequential Thinking**: Structure merge validation systematically
- **Work History**: Track merge patterns and outcomes
- **Context7**: Maintain context about PR dependencies
- **Serena**: Enhance code analysis and quality validation

**PR Status Checks:**
- **Approval Status**: Required approvals obtained
- **CI/CD Status**: All checks passing
- **Conflict Status**: No merge conflicts with target branch
- **Draft Status**: PR is not in draft mode
- **Target Branch**: Merging to correct branch (main/master/develop)

**Quality Gates:**
- **Code Review**: Approved by required reviewers
- **Testing**: All automated tests passing
- **Documentation**: Required docs updated
- **Security**: Security scans completed (if applicable)
- **Performance**: Performance benchmarks met (if applicable)

**Task/Bug Validation:**
- **Acceptance Criteria**: All criteria marked complete
- **Implementation Status**: All subtasks finished
- **Quality Checklist**: All quality items verified
- **Dependencies**: All dependent tasks completed

### 3. Perform pre-merge validations and tests

**Branch Synchronization:**
- Ensure target branch is up-to-date
- Check for conflicts with latest changes
- Verify branch protection rules compliance
- Validate commit signatures (if required)

**Final Testing:**
```bash
# Pull latest changes
git fetch origin

# Check merge conflicts
git merge-tree base_sha head_sha target_sha

# Run final test suite
run_full_test_suite

# Validate build artifacts
verify_build_artifacts
```

**Quality Verification:**
- **Code Coverage**: Meets minimum requirements
- **Static Analysis**: No critical issues detected
- **Security Scan**: No vulnerabilities introduced
- **Performance Impact**: Within acceptable limits

**Compliance Checks:**
- **Commit Message Format**: Follows conventional commit format
- **Branch Naming**: Follows project conventions
- **File Changes**: Only expected files modified
- **Breaking Changes**: Properly documented and approved

### 4. Update task/bug status and prepare metadata changes

**CRITICAL:** All task status updates and file operations must be completed and staged BEFORE executing the merge. This ensures they are included in the merge commit.

**Task Status Updates:**
- Update task status from "review" to "completed"
- Add PR information to task metadata (prepare merge_commit placeholder)
- Update actual effort if not already recorded
- Mark all acceptance criteria as completed
- Log merge preparation in task Output Log

**Bug Status Updates:**
- Update bug status from "testing" to "closed"
- Record resolution details in bug report
- Update fix verification status
- Log deployment readiness in bug tracking

**Task File Operations:**
- **Rename task file**: Add TX prefix (e.g., `t01-s02-feature.md` → `TXt01-s02-feature.md`)
- **Update file content**: Apply all metadata changes
- **Cross-reference updates**: Prepare YAML frontmatter updates

**Staged Metadata Template:**
```yaml
# Task/Bug YAML frontmatter updates (staged before merge)
pull_request: "{pr_url}"
merge_commit: "PENDING_MERGE_SHA"  # Will be updated post-merge
merged_date: "{current_timestamp}"
deployment_status: "ready"
status: "completed"  # or "closed" for bugs
```

**Project Tracking Updates:**
- Update project manifest with completion status
- Prepare milestone closure if all tasks complete
- Update sprint velocity metrics
- Record completion in project health tracking

**Stage All Changes:**
```bash
# Stage all task metadata changes
git add .simone/
git add docs/ # if documentation updated
# DO NOT COMMIT YET - these will be included in merge commit
```

### 5. Execute merge with staged task metadata changes

**Pre-Merge Verification:**
- Ensure all task metadata changes are staged
- Verify task file has been renamed with TX prefix
- Confirm all status updates are ready
- Check that no uncommitted changes remain outside staging

**Merge Strategy Selection:**

**Squash and Merge (Recommended for Features):**
- Combines all commits into single commit
- Includes staged task metadata changes
- Clean, linear history
- Task status and file operations in same commit

```bash
# Execute merge with staged task metadata included
gh pr merge {pr_number} --squash --body "$(cat <<'EOF'
{type}({scope}): {title} ({TASK_ID/BUG_ID})

{consolidated_commit_message}

Completed acceptance criteria:
{acceptance_criteria_list}

Task status updated to completed and archived with TX prefix.

Co-authored-by: {contributors}
EOF
)"

# Update merge SHA in task metadata post-merge
MERGE_SHA=$(git rev-parse HEAD)
sed -i "s/PENDING_MERGE_SHA/$MERGE_SHA/g" .simone/03_SPRINTS/*/TX{TASK_ID}*.md
sed -i "s/PENDING_MERGE_SHA/$MERGE_SHA/g" .simone/04_GENERAL_TASKS/TX{TASK_ID}*.md
git add .simone/
git commit --amend --no-edit
```

**Merge Commit (For Complex Features):**
- Preserves individual commit history
- Includes staged metadata changes
- Shows development progression
- Task operations tracked in merge commit

**Rebase and Merge (For Clean History):**
- Replays commits onto target branch
- Includes staged task metadata
- Linear history without merge commits
- Task status changes preserved in sequence

**Strategy Selection Logic:**
- **Single commit**: Use squash merge with staged metadata
- **Logical commit sequence**: Use rebase merge with staged metadata
- **Collaborative feature**: Use merge commit with staged metadata
- **Hotfix**: Use squash merge for clean history with metadata

### 6. Clean up branches and references

**Branch Cleanup:**
- Delete remote feature branch: `git push origin --delete {branch_name}`
- Delete local branch if safe: `git branch -d {branch_name}`
- Clean up any related temporary branches
- Remove stale branch references

**Verify Task Updates (Already Completed in Step 4):**
- ✅ Task file already renamed with TX prefix
- ✅ Task status already updated to completed/closed
- ✅ Project manifest already updated
- ✅ All metadata changes included in merge commit

**Final Housekeeping:**
- Clean up any temporary files or artifacts
- Remove draft PRs or related issues
- Update related documentation links if needed
- Verify all tracking systems reflect completion

### 7. Provide post-merge guidance and next steps

**Merge Confirmation:**
```markdown
✅ **Pull Request Merged Successfully**

🔀 **Merge Details**:
- **PR**: #{pr_number} - {pr_title}
- **Strategy**: {merge_strategy}
- **Target**: {target_branch}
- **Commit**: {merge_sha}
- **Context**: {TASK_ID/BUG_ID}

📊 **Impact**:
- **Files Changed**: {files_changed}
- **Lines Added**: +{lines_added}
- **Lines Removed**: -{lines_removed}
- **Commits Included**: {commit_count}

✅ **Task/Bug Updates** (Included in Merge Commit):
- **Status**: {old_status} → completed/closed
- **File**: Renamed with TX prefix and archived
- **Effort**: {actual_effort}h (estimated: {estimated_effort}h)
- **Acceptance Criteria**: All completed ✓
- **Metadata**: All changes committed with merge

🧹 **Cleanup Completed**:
- Feature branch deleted
- Task status updated and archived (TX prefix)
- Project tracking updated
- All changes in single merge commit
- Documentation current

⏭️ **Next Steps**:

### Deployment
- **Staging**: Deploy to staging for validation
- **Production**: Ready for production deployment
- **Command**: `/project:simone:deploy {version}` when ready

### Follow-up Actions
- Monitor deployment for issues
- Gather user feedback on changes
- Update related documentation if needed
- Plan next iteration tasks

### Recommended Commands
- **Deploy**: `/project:simone:deploy` for immediate deployment
- **Release**: `/project:simone:version bump` if ready for release
- **Next Task**: `/project:simone:do_task` to start next work item
```

## Merge Strategy Guidelines

### When to Use Squash Merge
- **Feature Development**: Complete features in isolated branches
- **Bug Fixes**: Single-purpose bug fix branches
- **Clean History**: Want linear, readable commit history
- **Small Changes**: Few commits that serve single purpose

### When to Use Merge Commit
- **Collaborative Features**: Multiple developers working together
- **Complex Features**: Want to preserve development progression
- **Release Branches**: Merging release branches to main
- **Important Context**: Development history provides value

### When to Use Rebase Merge
- **Clean Workflow**: Team prefers linear history
- **Individual Development**: Single developer per branch
- **Meaningful Commits**: Each commit serves distinct purpose
- **No Collaboration**: No shared development on branch

## Quality Assurance Integration

### Pre-Merge Requirements
- [ ] Code review completed by required reviewers
- [ ] All CI/CD checks passing
- [ ] Documentation updated and reviewed
- [ ] Security implications assessed
- [ ] Performance impact evaluated

### Post-Merge Validation
- [ ] Merge successful and conflict-free
- [ ] Target branch builds successfully
- [ ] Task/bug status updated correctly
- [ ] Project tracking current
- [ ] Branch cleanup completed

### Rollback Preparation
- Document merge commit SHA for rollback
- Prepare revert procedures if needed
- Identify dependencies for rollback planning
- Set up monitoring for post-merge issues

## Advanced Features

### Automated Deployment Triggers
- Trigger deployment pipelines on merge
- Update deployment status in task tracking
- Coordinate with release management
- Handle environment-specific deployments

### Notification Integration
- Notify stakeholders of merge completion
- Update project management tools
- Send deployment readiness alerts
- Communicate to dependent teams

### Metrics Collection
- Track merge frequency and timing
- Measure code review effectiveness
- Monitor deployment success rates
- Analyze development velocity

This merge command provides intelligent, automated PR merging that maintains code quality, updates all related tracking systems, and ensures smooth integration with the complete Simone development workflow.