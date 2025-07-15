# Ultra-Efficient Simone Workflow

## The 3-Command Development Cycle

```bash
# 1. PLAN (once per feature)
/project:simone:create_milestone "feature description" 

# 2. EXECUTE (repeat per task)  
/project:simone:do_task_auto T01_S01 --persona-auto --quality-strict

# 3. SHIP (when sprint done)
/project:simone:create_pr_auto T01_S01 --auto-assign --comprehensive
```

**That's it.** Everything else is automation.

## Streamlined Session Pattern

### Every Session (30 seconds):
```bash
/project:simone:prime    # Load context + MCP servers
```

### Weekly Planning (5 minutes):
```bash
/project:simone:create_milestone "next feature"  # AI generates everything
```

### Daily Work (per task):
```bash
/project:simone:do_task_auto T01_S01    # Handles: analysis, implementation, testing, commits, quality
```

## Maximum Automation Configuration

### 1. **Default to Automation**
- Use `do_task_auto` by default (not `do_task`)
- Let AI handle: commits, testing, quality gates, documentation
- Only intervene for: architectural decisions, complex business logic

### 2. **AI-Generated Everything**
```bash
# Let AI create tasks instead of manual writing
/project:simone:create_sprint_tasks    # Generates detailed tasks from milestones

# Let AI handle commits instead of manual git
# (handled automatically in do_task_auto)

# Let AI write PR descriptions 
/project:simone:create_pr_auto T01_S01
```

### 3. **Eliminate Manual Steps**
- **No manual task creation** → Use AI milestone breakdown
- **No manual commits** → Automated in task execution  
- **No manual PR writing** → Use `create_pr_auto`
- **No manual status updates** → Handled by automation

## Minimal Command Set (Use Only These)

### Planning Phase:
```bash
/project:simone:create_milestone "description"     # Once per feature
```

### Execution Phase:
```bash
/project:simone:do_task_auto T01_S01               # Per task
```

### Review Phase:
```bash
/project:simone:create_pr_auto T01_S01             # When ready to ship
```

### Health Checks:
```bash
/project:simone:troubleshoot                       # When things break
```

## Efficiency Rules

### 1. **Batch Everything**
```bash
# Instead of: multiple individual tasks
/project:simone:do_task_auto T01_S01
/project:simone:do_task_auto T02_S01  
/project:simone:do_task_auto T03_S01

# Do: process entire sprint
/project:simone:yolo S01    # Autonomous sprint execution
```

### 2. **Trust the Automation**
- Don't micro-manage commits
- Don't manually write task descriptions  
- Don't manually update status
- Let quality gates handle validation

### 3. **Intervention Points Only**
Manually handle only:
- **Architectural decisions** (ADRs)
- **Business requirements** (milestone descriptions)
- **Complex debugging** (when automation gets stuck)

## Ultra-Fast Setup (New Projects)

```bash
# 1. Install (30 seconds)
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash

# 2. Initialize (2 minutes)  
/project:simone:initialize

# 3. Start building (immediately)
/project:simone:create_milestone "your first feature"
```

## The "YOLO" Workflow

For maximum speed with acceptable risk:

```bash
# Full automation - AI does everything
/project:simone:yolo S01               # Executes entire sprint autonomously
/project:simone:yolo --safety-off     # Maximum speed, minimal human intervention
```

**Use when**: Routine features, bug fixes, refactoring
**Avoid when**: Critical systems, new architecture, unclear requirements

## Efficiency Metrics

Track these to optimize further:
- **Time from idea to PR**: Target < 2 hours for small features
- **Commands per feature**: Target < 5 manual commands  
- **Context switching**: Minimize by batching similar work

## The One-Minute Sprint

For small features:
```bash
/project:simone:create_milestone "small feature"     # 30 sec
/project:simone:yolo S01                             # 30 sec setup + AI execution
```

Total human time: **1 minute**
AI handles: planning, implementation, testing, documentation, commits, PR

## When NOT to Optimize

Keep manual control for:
- **System architecture changes**
- **Security-critical features** 
- **Performance-sensitive code**
- **External API integrations** (first time)
- **Complex business logic**

---

**Bottom Line**: Use AI for 90% of routine development work. Focus your human effort on the 10% that requires creativity, judgment, and domain expertise.