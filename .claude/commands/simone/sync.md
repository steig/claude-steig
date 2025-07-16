# Sync - Branch Synchronization and Conflict Resolution

Manages branch synchronization, conflict resolution, and repository maintenance for smooth collaboration.

## Create a TODO with EXACTLY these 7 Items

1. Parse sync arguments and determine sync strategy
2. Analyze current branch state and conflicts
3. Fetch latest changes and assess merge conflicts
4. Resolve conflicts with intelligent merging
5. Update branch references and tracking
6. Validate post-sync state and tests
7. Provide sync summary and next steps guidance

## DETAILS on every TODO item

### 1. Parse sync arguments and determine sync strategy

**Arguments Format:** `[source_branch] [strategy] [options]`

**Examples:**
- `/project:simone:sync` (sync current branch with main)
- `/project:simone:sync main rebase` (rebase current branch on main)
- `/project:simone:sync develop merge --force`
- `/project:simone:sync origin/main --auto-resolve`

**Sync Strategies:**
- **merge**: Create merge commit (preserves branch history)
- **rebase**: Replay commits on target branch (linear history)
- **fast-forward**: Move branch pointer forward (if possible)
- **auto**: Choose best strategy based on branch state

**Sync Types:**
- **upstream**: Sync with upstream/origin (default)
- **peer**: Sync with peer developer branch
- **release**: Sync with release branch
- **hotfix**: Sync hotfix branch with main

### 2. Analyze current branch state and conflicts

**MCP INTEGRATION:** Use MCP servers for enhanced synchronization:
- **Sequential Thinking**: Structure conflict resolution systematically
- **GitHub**: Track sync patterns and resolution strategies
- **Context7**: Maintain context about code changes and conflicts
- **Serena**: Enhance conflict analysis and resolution suggestions

**Branch State Analysis:**
```markdown
## 🔍 Branch Analysis

### Current Branch: {current_branch}
- **Type**: {branch_type} (task/bug/hotfix/release)
- **Base**: {base_branch}
- **Commits Ahead**: {commits_ahead}
- **Commits Behind**: {commits_behind}
- **Last Sync**: {last_sync_date}

### Working Directory
- **Uncommitted Changes**: {uncommitted_files_count} files
- **Staged Changes**: {staged_files_count} files
- **Untracked Files**: {untracked_files_count} files
- **Status**: {working_directory_status}

### Upstream Status
- **Remote**: {remote_name}/{remote_branch}
- **Tracking**: {tracking_status}
- **Divergence**: {divergence_summary}
```

**Conflict Prediction:**
- Analyze overlapping file changes
- Identify potential merge conflicts
- Assess complexity of conflict resolution
- Estimate sync effort and risk

### 3. Fetch latest changes and assess merge conflicts

**Fetch Process:**
```bash
# Fetch latest changes from all remotes
git fetch --all --prune

# Update remote tracking branches
git remote update

# Analyze divergence
git rev-list --left-right --count HEAD...origin/main
```

**Conflict Analysis:**
```bash
# Perform merge analysis without actually merging
git merge-tree $(git merge-base HEAD origin/main) HEAD origin/main

# Identify conflicting files
git diff --name-only HEAD origin/main

# Analyze conflict complexity
git diff --stat HEAD origin/main
```

**Conflict Categorization:**
- **Content Conflicts**: Same lines modified differently
- **Rename Conflicts**: File renamed in both branches
- **Delete Conflicts**: File modified in one branch, deleted in another
- **Binary Conflicts**: Binary files with conflicts
- **Submodule Conflicts**: Git submodule conflicts

### 4. Resolve conflicts with intelligent merging

**Automatic Conflict Resolution:**
```bash
# Attempt automatic merge/rebase
if [ "$strategy" = "merge" ]; then
    git merge origin/main --no-commit
elif [ "$strategy" = "rebase" ]; then
    git rebase origin/main
fi

# Check for conflicts
if git status --porcelain | grep -q "^UU\|^AA\|^DD"; then
    echo "Conflicts detected - initiating resolution"
    resolve_conflicts_intelligently
fi
```

**Intelligent Conflict Resolution:**

**Code Conflicts:**
- **Whitespace**: Auto-resolve whitespace-only differences
- **Import Statements**: Merge import lists intelligently
- **Configuration**: Prefer feature branch configs for feature-specific settings
- **Documentation**: Merge documentation changes when non-conflicting

**Conflict Resolution Strategies:**
```markdown
## 🔧 Conflict Resolution Strategies

### Automatic Resolution
- **Whitespace conflicts**: Choose consistent formatting
- **Import order**: Merge and sort imports
- **Documentation**: Combine non-conflicting doc changes
- **Configuration**: Use strategy-based resolution

### Semi-Automatic Resolution
- **Function/method additions**: Merge both additions
- **Variable declarations**: Combine declarations
- **Test additions**: Merge test cases
- **Comment additions**: Preserve all comments

### Manual Resolution Required
- **Logic conflicts**: Same function modified differently
- **API changes**: Incompatible interface changes
- **Data structure conflicts**: Schema or model conflicts
- **Business logic**: Conflicting business rules
```

**Interactive Conflict Resolution:**
```markdown
## ⚠️ Manual Conflict Resolution Required

### Conflicts Found: {conflict_count}
{List conflicting files with descriptions}

### Resolution Guidance
For each conflict, choose one of:
1. **Accept Current**: Keep your branch's version
2. **Accept Incoming**: Use main branch's version  
3. **Merge Both**: Combine both changes
4. **Custom Resolution**: Manual edit required

### Tools Available
- **Git Mergetool**: `git mergetool`
- **VS Code**: Built-in merge conflict resolution
- **Manual Edit**: Direct file editing
```

### 5. Update branch references and tracking

**Branch Reference Updates:**
```bash
# Update tracking branch
git branch -u origin/{current_branch}

# Update local branch references
git update-ref refs/heads/{current_branch} HEAD

# Clean up stale references
git remote prune origin

# Update submodules if present
git submodule update --init --recursive
```

**Metadata Updates:**
- Update task/bug files with sync information
- Record merge conflicts and resolutions
- Update YAML frontmatter with sync timestamp
- Log sync activity in task Output Log

**Project Integration:**
- Update task status if affected by sync
- Record sync events in project manifest
- Update sprint tracking with sync impacts
- Log conflict resolution decisions

### 6. Validate post-sync state and tests

**Repository Validation:**
```bash
# Verify repository integrity
git fsck --full

# Ensure branch is clean
git status --porcelain

# Validate commit history
git log --oneline -10

# Check remote tracking
git branch -vv
```

**Automated Testing:**
```bash
# Run quick validation tests
run_quick_test_suite

# Validate build integrity
verify_build_success

# Check code style compliance
run_linting_checks

# Validate configuration
verify_configuration_integrity
```

**Conflict Resolution Validation:**
- Verify all conflicts marked as resolved
- Ensure no conflict markers remain in code
- Validate syntax and compilation
- Run affected test suites

### 7. Provide sync summary and next steps guidance

**Sync Summary:**
```markdown
🔄 **Branch Sync Completed**

### 📊 Sync Details
- **Strategy**: {sync_strategy}
- **Source**: {source_branch}
- **Target**: {current_branch}
- **Duration**: {sync_duration}
- **Status**: ✅ Successful

### 📈 Changes Integrated
- **Commits Pulled**: {commits_pulled}
- **Files Modified**: {files_modified}
- **Lines Added**: +{lines_added}
- **Lines Removed**: -{lines_removed}

### 🔧 Conflicts Resolved
- **Total Conflicts**: {total_conflicts}
- **Auto-Resolved**: {auto_resolved_conflicts}
- **Manual Resolution**: {manual_resolved_conflicts}
- **Resolution Strategy**: {resolution_strategies_used}

### ✅ Validation Results
- **Build Status**: ✅ Successful
- **Tests**: ✅ {passing_tests}/{total_tests} passing
- **Linting**: ✅ No issues
- **Repository Integrity**: ✅ Verified

### ⏭️ Next Steps

#### Immediate Actions
- [ ] Review integrated changes
- [ ] Run full test suite
- [ ] Update task documentation if needed
- [ ] Continue development work

#### Recommended Commands
- **Continue Task**: `/project:simone:do_task {current_task}`
- **Commit Changes**: `/project:simone:commit {task_id}`
- **Create PR**: `/project:simone:create_pr {task_id}`

### 🔍 Review Recommendations
{If significant changes integrated}
- Review changes from {source_branch}
- Validate feature compatibility
- Check for breaking changes
- Update tests if necessary

### 🚨 Issues Detected
{If any issues found}
- ⚠️ {issue_description}
- **Resolution**: {recommended_action}
```

## Sync Strategies and Best Practices

### Merge Strategy
```markdown
### When to Use Merge
- **Collaborative branches**: Multiple developers
- **Feature branches**: Complete features
- **Preserve history**: Want to maintain branch history
- **Safe option**: Lower risk of history rewriting

### Merge Benefits
- Preserves complete development history
- Shows collaboration patterns
- Easy to revert merge commits
- Safe for shared branches
```

### Rebase Strategy
```markdown
### When to Use Rebase
- **Individual work**: Single developer branches
- **Clean history**: Linear commit history preferred
- **Small changes**: Few commits to replay
- **Feature branches**: Before merging to main

### Rebase Benefits
- Clean, linear history
- Easier to follow commit progression
- No merge commits cluttering history
- Better for code archaeology
```

### Auto Strategy Selection
```markdown
### Decision Matrix
- **No divergence**: Use fast-forward
- **Simple changes**: Use rebase for clean history
- **Complex changes**: Use merge for safety
- **Collaborative**: Always use merge
- **Hotfixes**: Use rebase for clean application
```

## Advanced Sync Features

### Intelligent Conflict Resolution
- **Semantic Merging**: Understand code structure for better merging
- **Machine Learning**: Learn from past conflict resolutions
- **Context Awareness**: Consider surrounding code for resolution
- **Pattern Recognition**: Identify common conflict patterns

### Collaborative Sync
- **Team Awareness**: Show other developers' sync status
- **Conflict Prediction**: Warn about potential conflicts
- **Coordination**: Schedule syncs to minimize conflicts
- **Communication**: Notify team of significant syncs

### Automated Sync Policies
- **Schedule**: Automatic daily/weekly syncs
- **Triggers**: Sync on specific events (PR creation, etc.)
- **Rules**: Branch-specific sync strategies
- **Integration**: CI/CD pipeline integration

### Conflict Prevention
- **Early Detection**: Identify conflicts before they happen
- **Communication**: Alert when changes overlap
- **Coordination**: Suggest collaboration on conflicting areas
- **Guidance**: Recommend development patterns to reduce conflicts

This comprehensive sync system ensures smooth collaboration, intelligent conflict resolution, and maintains code quality while integrating seamlessly with the Simone task management framework.