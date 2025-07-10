# Rollback Command

Safely rollback autonomous operations when things go wrong.

## Usage

This command can be called manually or automatically by safety systems.

Check <$ARGUMENTS> for rollback scope:
- `--task <task_id>`: Rollback specific task
- `--branch <branch_name>`: Rollback entire branch
- `--emergency`: Emergency rollback to last known good state
- `--auto`: Automatic rollback (called by safety system)

## Rollback Scope Detection

### 1. Determine Rollback Scope
```bash
# Check current git state
git status --porcelain
git log --oneline -10

# Identify rollback target
if [[ "$1" == "--task" ]]; then
    ROLLBACK_TARGET="task/$2"
elif [[ "$1" == "--branch" ]]; then
    ROLLBACK_TARGET="$2"
elif [[ "$1" == "--emergency" ]]; then
    ROLLBACK_TARGET=$(git reflog | grep "safe-state" | head -1 | cut -d' ' -f1)
else
    # Auto-detect rollback scope
    ROLLBACK_TARGET=$(git log --oneline -1 --grep="YOLO-START" | cut -d' ' -f1)
fi
```

### 2. Validate Rollback Target
```bash
# Ensure rollback target exists
if ! git rev-parse --verify "$ROLLBACK_TARGET" >/dev/null 2>&1; then
    echo "ERROR: Rollback target '$ROLLBACK_TARGET' not found"
    exit 1
fi
```

## Pre-Rollback Safety Checks

### 1. Backup Current State
```bash
# Create backup branch before rollback
BACKUP_BRANCH="backup-$(date +%Y%m%d-%H%M%S)"
git branch "$BACKUP_BRANCH"
echo "Created backup branch: $BACKUP_BRANCH"
```

### 2. Assess Rollback Impact
```bash
# Show what will be lost
echo "=== ROLLBACK IMPACT ASSESSMENT ==="
echo "Current HEAD: $(git rev-parse HEAD)"
echo "Rollback target: $ROLLBACK_TARGET"
echo ""
echo "Commits that will be lost:"
git log --oneline "$ROLLBACK_TARGET..HEAD"
echo ""
echo "Files that will be reverted:"
git diff --name-only "$ROLLBACK_TARGET..HEAD"
```

### 3. User Confirmation (if not auto rollback)
```bash
if [[ "$1" != "--auto" ]]; then
    echo ""
    echo "WARNING: This will permanently lose the above changes"
    echo "Backup created as: $BACKUP_BRANCH"
    echo ""
    read -p "Continue with rollback? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Rollback cancelled"
        exit 0
    fi
fi
```

## Rollback Execution

### 1. Clean Working Directory
```bash
# Stash any uncommitted changes
if [[ -n $(git status --porcelain) ]]; then
    git stash push -m "rollback-stash-$(date +%Y%m%d-%H%M%S)"
    echo "Stashed uncommitted changes"
fi
```

### 2. Execute Rollback
```bash
# Reset to target commit
git reset --hard "$ROLLBACK_TARGET"
echo "Rolled back to: $ROLLBACK_TARGET"

# Clean untracked files
git clean -fd
echo "Cleaned untracked files"
```

### 3. Verify Rollback Success
```bash
# Verify we're at the correct commit
CURRENT_COMMIT=$(git rev-parse HEAD)
if [[ "$CURRENT_COMMIT" == "$ROLLBACK_TARGET" ]]; then
    echo "✅ Rollback successful"
else
    echo "❌ Rollback failed - unexpected state"
    exit 1
fi
```

## Post-Rollback Actions

### 1. Run Safety Checks
```bash
# Verify system is stable after rollback
echo "=== POST-ROLLBACK VERIFICATION ==="

# Check git status
echo "Git status:"
git status --short

# Run test suite if available
if [[ -f "package.json" ]] && grep -q "test" package.json; then
    echo "Running test suite..."
    npm test
elif [[ -f "pyproject.toml" ]] || [[ -f "requirements.txt" ]]; then
    echo "Running test suite..."
    python -m pytest --tb=short
fi
```

### 2. Update Task Status
```bash
# Mark rolled-back tasks as failed
if [[ "$1" == "--task" ]]; then
    TASK_ID="$2"
    echo "Updating task status: $TASK_ID"
    # Update task status in Simone framework
    # This would integrate with update_task_status.md
fi
```

### 3. Generate Rollback Report
```bash
echo "=== ROLLBACK REPORT ===" > rollback-report.md
echo "Date: $(date)" >> rollback-report.md
echo "Rollback target: $ROLLBACK_TARGET" >> rollback-report.md
echo "Backup branch: $BACKUP_BRANCH" >> rollback-report.md
echo "Reason: ${ROLLBACK_REASON:-Manual rollback}" >> rollback-report.md
echo "" >> rollback-report.md
echo "Commits rolled back:" >> rollback-report.md
git log --oneline "$ROLLBACK_TARGET..HEAD" >> rollback-report.md
echo "" >> rollback-report.md
echo "Files affected:" >> rollback-report.md
git diff --name-only "$ROLLBACK_TARGET..HEAD" >> rollback-report.md

echo "Rollback report created: rollback-report.md"
```

## Recovery Options

### 1. Restore from Backup
```bash
# If user wants to restore the rolled-back changes
restore_from_backup() {
    echo "Available backup branches:"
    git branch | grep "backup-"
    
    read -p "Enter backup branch name to restore: " BACKUP_NAME
    if git rev-parse --verify "$BACKUP_NAME" >/dev/null 2>&1; then
        git checkout "$BACKUP_NAME"
        echo "Restored from backup: $BACKUP_NAME"
    else
        echo "Backup branch not found: $BACKUP_NAME"
    fi
}
```

### 2. Cherry-pick Specific Changes
```bash
# Allow user to selectively restore specific commits
cherry_pick_changes() {
    echo "Available commits to cherry-pick:"
    git log --oneline "$ROLLBACK_TARGET..$BACKUP_BRANCH"
    
    read -p "Enter commit hash to cherry-pick (or 'done'): " COMMIT_HASH
    while [[ "$COMMIT_HASH" != "done" ]]; do
        if git rev-parse --verify "$COMMIT_HASH" >/dev/null 2>&1; then
            git cherry-pick "$COMMIT_HASH"
            echo "Cherry-picked: $COMMIT_HASH"
        else
            echo "Invalid commit hash: $COMMIT_HASH"
        fi
        read -p "Enter next commit hash (or 'done'): " COMMIT_HASH
    done
}
```

## Integration with Safety System

### Automatic Rollback Triggers
```bash
# This function is called by safety_check.md when triggers are met
auto_rollback_trigger() {
    local TRIGGER_REASON="$1"
    local ROLLBACK_TARGET="$2"
    
    echo "=== AUTOMATIC ROLLBACK TRIGGERED ==="
    echo "Reason: $TRIGGER_REASON"
    echo "Target: $ROLLBACK_TARGET"
    
    # Set rollback reason for reporting
    export ROLLBACK_REASON="$TRIGGER_REASON"
    
    # Execute rollback
    ./rollback.md --auto
}
```

### Safe State Markers
```bash
# Mark safe states for rollback targets
mark_safe_state() {
    local STATE_NAME="$1"
    git tag "safe-state-$STATE_NAME-$(date +%Y%m%d-%H%M%S)"
    echo "Marked safe state: $STATE_NAME"
}
```

## Error Handling

### Rollback Failures
```bash
# Handle cases where rollback itself fails
handle_rollback_failure() {
    echo "❌ ROLLBACK FAILED - MANUAL INTERVENTION REQUIRED"
    echo ""
    echo "Current state:"
    git status
    echo ""
    echo "Possible recovery actions:"
    echo "1. git reset --hard HEAD"
    echo "2. git clean -fd"
    echo "3. git checkout main"
    echo "4. Contact support with this error report"
    
    # Create emergency report
    echo "=== EMERGENCY ROLLBACK FAILURE ===" > emergency-report.md
    echo "Date: $(date)" >> emergency-report.md
    echo "Failed rollback target: $ROLLBACK_TARGET" >> emergency-report.md
    echo "Git status:" >> emergency-report.md
    git status >> emergency-report.md
    echo "Git log:" >> emergency-report.md
    git log --oneline -10 >> emergency-report.md
}
```

## Cleanup

### Remove Old Backups
```bash
# Clean up old backup branches (keep last 5)
cleanup_old_backups() {
    echo "Cleaning up old backup branches..."
    git branch | grep "backup-" | sort -r | tail -n +6 | xargs -r git branch -D
    echo "Cleanup complete"
}
```

This rollback command provides comprehensive rollback capabilities with safety checks, user confirmation, and detailed reporting.