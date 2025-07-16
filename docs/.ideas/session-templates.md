# Session Templates - Start Fast, Stay Focused

## Session Types

### 🌅 **Morning Session** (planning focused)
```bash
# 1. Load context (30 sec)
/project:simone:prime

# 2. Check project health (1 min)
/project:simone:status
/project:simone:troubleshoot

# 3. Plan day's work (2 min)
/project:simone:create_milestone "today's feature"
/project:simone:create_sprints_from_milestone

# Total: 3.5 minutes to full productivity
```

### ⚡ **Speed Session** (execution focused)
```bash
# 1. Load and go (30 sec)
/project:simone:prime

# 2. Execute immediately
/project:simone:do_task_auto T01_S01 --persona-auto --bypass-approval --quality-strict

# Total: 30 seconds to coding
```

### 🧹 **Cleanup Session** (maintenance focused)
```bash
# 1. Load context
/project:simone:prime

# 2. Health check and cleanup
/project:simone:sync_metadata
/project:simone:project_review
/project:simone:troubleshoot

# 3. Process debt
/project:simone:do_task_auto TD_001 --persona-refactorer --quality-strict
```

### 🚢 **Shipping Session** (delivery focused)
```bash
# 1. Load context
/project:simone:prime

# 2. Batch create PRs
/project:simone:create_pr_auto T01_S01 --auto-assign --comprehensive
/project:simone:create_pr_auto T02_S01 --auto-assign --comprehensive  
/project:simone:create_pr_auto T03_S01 --auto-assign --comprehensive

# 3. Sprint completion
/project:simone:complete_sprint S01
```

## Context-Specific Templates

### 🆕 **New Project Session**
```bash
# 1. Initialize everything (5 min)
/project:simone:initialize

# 2. Create foundation (10 min)
/project:simone:create_milestone "MVP foundation"
/project:simone:create_sprints_from_milestone
/project:simone:create_sprint_tasks

# 3. Start building (immediate)
/project:simone:do_task_auto T01_S01 --persona-architect --quality-strict
```

### 🔥 **Firefighting Session**
```bash
# 1. Quick load
/project:simone:prime

# 2. Investigate immediately
/project:simone:investigate "production issue"
/project:simone:analyze "affected systems"

# 3. Fix with maximum safety
/project:simone:do_task_auto HOTFIX_001 --persona-security --consensus --quality-strict
```

### 🎯 **Focus Session** (deep work)
```bash
# 1. Load and isolate
/project:simone:prime

# 2. Single task focus
/project:simone:do_task_auto T01_S01 --persona-architect --think-deep --quality-strict --introspect

# 3. No distractions - complete one thing well
```

## Efficiency Multipliers

### **Batch Operations**
```bash
# Instead of individual commands, batch similar work:
for task in T01_S01 T02_S01 T03_S01; do
  /project:simone:do_task_auto $task --persona-auto --bypass-approval
done
```

### **Parallel Development**
```bash
# Use YOLO for autonomous parallel work:
/project:simone:yolo S01 --balanced   # Handles multiple tasks automatically
```

### **Context Switching Minimization**
```bash
# Group by domain:
# Morning: All frontend tasks
# Afternoon: All backend tasks  
# Evening: All testing/QA tasks
```

## Session Success Metrics

Track these to optimize:
- **Time to first commit**: Target < 5 minutes
- **Commands per hour**: Target > 10 meaningful operations
- **Context switches**: Target < 3 per session
- **Automation ratio**: Target > 80% automated execution

## Pre-Session Checklist

- [ ] Coffee/energy level optimal
- [ ] Clear 1-3 hour time block  
- [ ] Notifications disabled
- [ ] Goal defined (which milestone/sprint)
- [ ] Complexity assessed (choose appropriate persona flags)

## Post-Session Checklist

- [ ] All tasks committed
- [ ] PRs created for completed work
- [ ] Status updated in task files
- [ ] Tomorrow's work identified
- [ ] Context preserved in documentation