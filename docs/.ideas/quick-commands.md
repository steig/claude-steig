# Quick Command Reference - Maximum Efficiency

## The Essential 4 Commands

```bash
# 1. Start every session
/project:simone:prime

# 2. Plan features (once)
/project:simone:create_milestone "feature description"

# 3. Execute tasks (daily)
/project:simone:do_task_auto T01_S01 --persona-auto --quality-strict

# 4. Ship code (when ready)
/project:simone:create_pr_auto T01_S01 --auto-assign --comprehensive
```

## Speed Flags for Maximum Automation

### do_task_auto Power Flags:
```bash
--bypass-approval     # Skip human gates for routine work
--quality-strict      # Enforce strictest standards  
--persona-auto        # Auto-select relevant personas
--uc                  # Ultra-compressed mode (70% token reduction)
```

### YOLO Mode for Sprint Automation:
```bash
/project:simone:yolo S01 --balanced    # Moderate safety (recommended)
/project:simone:yolo S01 --safe        # Maximum safety
/project:simone:yolo S01 --yolo        # Minimal safety (legacy)
```

### PR Auto-Creation Flags:
```bash
--auto-assign         # Auto-assign reviewers
--comprehensive       # Maximum detail
--ready-to-merge      # High-confidence automation
--draft              # Early feedback mode
```

## Efficiency Combinations

### Routine Feature Development:
```bash
/project:simone:do_task_auto T01_S01 --persona-auto --quality-strict --bypass-approval
```

### Security-Critical Work:
```bash
/project:simone:do_task_auto T01_S01 --persona-security --quality-strict --consensus
```

### Sprint Completion:
```bash
/project:simone:yolo S01 --balanced
```

### Emergency Hotfix:
```bash
/project:simone:do_task_auto T01_S01 --persona-security --bypass-approval --ready-to-merge
```

## Time Estimates

- **Single task automation**: 2-5 minutes human time
- **Sprint automation**: 10-15 minutes human time  
- **Milestone creation**: 30 seconds human time
- **PR creation**: 30 seconds human time

## Troubleshooting

```bash
/project:simone:troubleshoot          # When things break
/project:simone:sync_metadata         # Fix inconsistencies
/project:simone:status               # Check current state
```