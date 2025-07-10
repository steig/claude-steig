# Safety Check Command

This command performs comprehensive safety checks before and during autonomous operations.

## Usage

This command is typically called by other commands (like YOLO) to ensure safe operation.

Check <$ARGUMENTS> for specific safety level:
- `--safe`: Maximum safety (default)
- `--balanced`: Moderate safety
- `--yolo`: Minimal safety (legacy mode)

## Pre-Flight Safety Checks

### 1. Git Status Verification
```bash
# Check git working directory
git status --porcelain
```

**STOP CONDITIONS:**
- Uncommitted changes in critical files (.env, alembic/, production configs)
- Untracked files that could be sensitive
- Merge conflicts detected

### 2. Test Baseline Validation
```bash
# Run test suite to establish baseline
```

**STOP CONDITIONS:**
- Test pass rate below 70% (--safe mode)
- Test pass rate below 50% (--balanced mode)
- Test suite not executable (all modes)

### 3. System Resource Check
```bash
# Check available resources
df -h .
free -h 2>/dev/null || vm_stat | head -10
```

**STOP CONDITIONS:**
- Disk space below 1GB
- Memory usage above 85%
- Load average above 8.0

### 4. Critical File Protection
```bash
# Check for critical files that should never be modified
find . -name ".env*" -o -name "alembic" -o -name "migrations" -o -name "production*" -o -name "secrets*"
```

**STOP CONDITIONS:**
- Any critical files detected in change set
- Database migration files about to be modified
- Production configuration files in scope

## During-Operation Safety Monitoring

### 1. Continuous Test Monitoring
- Run tests after each significant change
- Monitor test pass rate degradation
- Alert on quality regression

### 2. Resource Usage Tracking
- Monitor CPU, memory, disk usage
- Track execution time per task
- Alert on resource exhaustion

### 3. Change Impact Assessment
- Count files modified
- Assess scope of changes
- Track security-sensitive modifications

## Safety Thresholds by Mode

### --safe Mode (Maximum Safety)
```yaml
max_files_changed: 3
max_execution_time: 15  # minutes
min_test_pass_rate: 80
max_memory_usage: 70
require_user_approval: true
auto_rollback: true
```

### --balanced Mode (Moderate Safety)
```yaml
max_files_changed: 5
max_execution_time: 25  # minutes
min_test_pass_rate: 70
max_memory_usage: 80
require_user_approval: false
auto_rollback: true
```

### --yolo Mode (Minimal Safety)
```yaml
max_files_changed: 10
max_execution_time: 35  # minutes
min_test_pass_rate: 60
max_memory_usage: 85
require_user_approval: false
auto_rollback: false
```

## Emergency Stop Triggers

**IMMEDIATE STOP CONDITIONS (All Modes):**
- Security vulnerability detected
- Data loss risk identified
- System instability detected
- External service failures
- User intervention requested

## Safety Report Generation

Generate comprehensive safety report including:
- Current safety mode
- Checks performed
- Risks identified
- Mitigation actions taken
- Current system health
- Recommendations

## Safety Decision Logic

```bash
# Safety decision framework
if [[ $SAFETY_LEVEL == "safe" ]]; then
    # Maximum safety checks
    perform_comprehensive_checks
    require_user_approval_for_changes
    enable_automatic_rollback
elif [[ $SAFETY_LEVEL == "balanced" ]]; then
    # Moderate safety checks
    perform_standard_checks
    enable_automatic_rollback
    monitor_continuously
else
    # Minimal safety (yolo mode)
    perform_basic_checks
    log_all_actions
    continue_on_non_critical_errors
fi
```

## Integration with Other Commands

This safety check command is designed to be called by:
- `yolo.md` - Before and during autonomous execution
- `do_task.md` - Before individual task execution
- `commit.md` - Before committing changes
- `merge.md` - Before merging branches

## Error Handling

- **Critical errors**: Immediate stop, rollback if possible
- **Warning errors**: Log, continue with caution
- **Info errors**: Log only, continue normally

## User Notification

When safety checks fail:
1. **IMMEDIATE**: Stop all operations
2. **REPORT**: Clear explanation of safety issue
3. **OPTIONS**: Present user with choices (abort, override, modify)
4. **WAIT**: For user decision before proceeding

## Rollback Preparation

Before any operation:
1. **SNAPSHOT**: Current git state
2. **BACKUP**: Modified files
3. **LOG**: All planned changes
4. **PREPARE**: Rollback procedure