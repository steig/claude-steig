# Simone Commands

## Core Commands (Always Available)

### `add` - Create a task
```bash
simone add "Fix login bug"
# Creates: .simone/tasks/1720634421.md

# Quick add (even shorter)
simone "Fix login bug"
```

### `list` - Show tasks
```bash
simone list
# 📋 Tasks:
#   [1720634421] Fix login bug
#   [1720634422] Add user dashboard

simone list --all  # Include organized folders
```

### `done` - Complete a task
```bash
simone done 1720634421
# ✅ Completed: Fix login bug
# Moved to: .simone/done/1720634421.md
```

### `note` - Save project knowledge
```bash
simone note "API key is in AWS secrets manager"
# 💡 Note saved
```

### `find` - Search everything
```bash
simone find "login"
# 🔍 Searching for: login
# 📄 tasks/1720634421.md
#    Fix login bug
```

## Organization Commands (After `enable organize`)

### `add --urgent` - High priority task
```bash
simone add --urgent "Server is down"
# Creates in: .simone/tasks/urgent/
```

### `add --backlog` - Low priority task
```bash
simone add --backlog "Refactor old code"
# Creates in: .simone/tasks/backlog/
```

### `move` - Change task priority
```bash
simone move 1720634421 urgent
# ✅ Moved task to urgent

simone move 1720634422 backlog
# ✅ Moved task to backlog
```

### `report` - Task statistics
```bash
simone report
# 📊 Task Report
# By Priority:
#   🔥 Urgent:  2
#   📋 Normal:  5  
#   📦 Backlog: 3
# Completed this month: 12
```

## Team Commands (After `enable team`)

### `add --assign` - Assigned task
```bash
simone add --assign @alice "Review pull request"
# Creates in: .simone/tasks/@alice/
```

### `assign` - Assign existing task
```bash
simone assign 1720634421 @bob
# ✅ Task assigned to @bob
```

### `standup` - Daily status
```bash
simone standup
# 🏃 Daily Standup - 2024-07-16
# @alice has 3 tasks:
#   - Review pull request
#   - Update documentation
#   - Fix test failures
# @bob has 1 task:
#   - Deploy to staging
# ⚠️  Unassigned urgent tasks: 2
```

## Progressive Features

### `enable` - Add capabilities
```bash
simone enable organize   # Add priorities
simone enable team       # Add assignments  
simone enable full       # Full framework
```

### `help` - Context-aware help
```bash
simone help
# Shows only commands for your current mode
```

## Full Mode Commands (After `enable full`)

When you enable full mode, you get 40+ commands including:

- Sprint management
- Milestone tracking
- Architecture decisions
- Bug tracking
- Quality gates
- And much more...

See the [original Simone docs](https://github.com/original/simone) for full mode.

## Special Patterns

### Quick Add (No Subcommand)
```bash
# These are equivalent:
simone add "Fix bug"
simone "Fix bug"
```

### Combining Flags
```bash
# Urgent + assigned
simone add --urgent --assign @alice "Production down"
```

### Batch Operations
```bash
# Find and process multiple tasks
simone find "bug" | grep -o '\[.*\]' | xargs -I {} simone done {}
```

## Claude Code Integration

In Claude Code, use these commands:

```bash
# Simple mode
/project:simone:quick_task "Fix bug"
/project:simone:do_task 1720634421

# With organization
/project:simone:urgent_task "Production issue"

# With team
/project:simone:assign_task 1720634421 @alice
```

## Examples by Scenario

### Solo Hacking
```bash
simone "Add login page"
simone "Connect to database"  
simone "Write tests"
simone list
simone done 1720634421
```

### Small Team
```bash
simone enable team
simone add --assign @frontend "Build UI"
simone add --assign @backend "Create API"
simone standup
```

### Busy Startup
```bash
simone enable organize
simone add --urgent "Fix customer bug"
simone add --backlog "Tech debt cleanup"
simone report
simone move 1720634423 urgent
```

---

**Pro tip:** Start with just `add`, `list`, and `done`. Learn other commands as needed.