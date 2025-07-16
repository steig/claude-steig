# Simone Examples

Practical usage patterns for common development scenarios.

## Starting a New Project

```bash
# Day 1: Just start working
mkdir myproject && cd myproject
simone init
simone "Set up Git repository"
simone "Create basic project structure"
simone "Add README"

# Get to work
simone list
# [172063442] Set up Git repository
# [172063443] Create basic project structure  
# [172063444] Add README

# Complete as you go
git init
simone done 172063442

# Add more tasks as you think of them
simone "Add CI/CD pipeline"
simone "Set up testing framework"
```

## Team Onboarding

```bash
# Project lead sets up
simone enable team

# Create onboarding tasks
simone add --assign @newdev "Set up development environment"
simone add --assign @newdev "Read architecture docs"
simone add --assign @newdev "Run test suite locally"
simone add --assign @mentor "Pair with @newdev on first feature"

# Daily check-in
simone standup
# @newdev has 3 tasks:
#   - Set up development environment
#   - Read architecture docs
#   - Run test suite locally
```

## Production Emergency

```bash
# Enable organization if not already
simone enable organize

# Create urgent tasks
simone add --urgent "Website is down - investigate"
simone add --urgent "Rollback if needed"
simone add --urgent "Write incident report"

# Normal work goes to backlog
simone move 172063445 backlog  # That feature can wait

# Track progress
simone list
# 🔥 Urgent:
#   [172063446] Website is down - investigate
#   [172063447] Rollback if needed
#   [172063448] Write incident report

# After fixing
simone done 172063446
simone done 172063447
simone note "Root cause: Memory leak in auth service. Fixed in commit abc123"
simone done 172063448
```

## Sprint Planning (Team Mode)

```bash
# Review backlog
simone list
# 📦 Backlog:
#   [172063450] Refactor user service
#   [172063451] Add dark mode
#   [172063452] Optimize database queries

# Assign sprint work
simone move 172063451 normal
simone assign 172063451 @alice
simone move 172063452 normal  
simone assign 172063452 @bob

# Add new sprint tasks
simone add --assign @charlie "Implement user search"
simone add --urgent --assign @alice "Fix login regression"
```

## Claude Code Integration

```bash
# In terminal
simone add "Implement user authentication with JWT"

# In Claude Code
/project:simone:do_task 172063455

# Claude reads the task, implements it, then:
simone done 172063455

# Claude might create follow-up tasks
simone add "Add refresh token support"
simone add "Write auth integration tests"
```

## Weekly Review

```bash
# See what got done
ls .simone/done/2024-07/
# Shows all completed tasks this month

# Check team velocity
simone report
# 📊 Task Report
# By Priority:
#   🔥 Urgent:  0  (good!)
#   📋 Normal:  8
#   📦 Backlog: 15
# Completed this month: 23

# Find stuck tasks
simone find "Created: 2024-06" | grep -v done
# Old tasks that might be stuck
```

## Migration from Complex System

```bash
# Have existing complex Simone project?
cd old-project
simone-migrate --analyze

# 📊 Project Statistics:
#   Total tasks:      47
#   Sprint tasks:     23
#   Bug reports:      12
# 🎯 Recommendation: organize mode

simone-migrate
# Apply migration? (y/N) y
# ✅ Migration complete!

# Now it's simple
simone list
# 🔥 Urgent: 3
# 📋 Normal: 35
# 📦 Backlog: 9
```

## Common Patterns

### The "Parking Lot"
```bash
# During meetings, capture everything
simone "Investigate slow API response"
simone "Talk to Sarah about budget"
simone "Research new framework"

# After meeting, organize
simone move 172063456 backlog  # Not urgent
simone assign 172063457 @me
simone add --urgent "Fix bug Sarah mentioned"
```

### The "Brain Dump"
```bash
# Just get everything out of your head
for task in "Fix login" "Update docs" "Call client" "Debug test"; do
  simone "$task"
done

# Then prioritize
simone list
simone move 172063460 urgent  # Client call
```

### The "Context Switch"
```bash
# Save context before switching
simone note "Was debugging auth issue - check line 234 in auth.js"
simone add "Continue debugging auth issue tomorrow"

# When you come back
simone find "auth issue"
# Finds your note and task
```

## Advanced Usage

### Aliases for Speed
```bash
alias t='simone'
alias ta='simone add'
alias tl='simone list'
alias td='simone done'

# Now super fast
ta "Fix bug"
tl
td 172063465
```

### Integration with Other Tools
```bash
# Create task from git commit
git commit -m "Fix: Login error" && simone "Document login error fix"

# Create tasks from GitHub issues
gh issue list --json title --jq '.[].title' | xargs -I {} simone "{}"

# Daily task from calendar
cal -h | grep -E "^\s*$(date +%d)" && simone "Check calendar events"
```

### Task Templates
```bash
# Create a bug report template
echo "# Bug: 
Reported by: 
Steps to reproduce:
Expected:
Actual:" > bug_template.md

# Use it
cp bug_template.md .simone/tasks/$(date +%s).md && vi .simone/tasks/$(date +%s).md
```

---

Note: These examples demonstrate flexibility. Simone can be adapted to various workflow preferences.