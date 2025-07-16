# How Simone Works

## The Problem

Task management systems often increase in complexity over time:
- Jira: Started as bug tracker → Enterprise complexity nightmare  
- GitHub Issues: Started clean → Labels, milestones, projects, actions...
- Trello: Started as cards → Power-ups, Butler, automations...

This can lead to decreased productivity as users spend more time on process than on actual work.

## The Solution: Progressive Complexity

Simone stays simple until YOU decide you need more.

### Level 1: Simple Mode (Default)

```
.simone/
├── tasks/      # Your work
├── done/       # Completed work
└── notes/      # Things to remember
```

This basic structure requires no additional configuration or metadata.

### Level 2: Organize Mode

When you have too many tasks:

```bash
simone enable organize
```

Now you get:
```
.simone/
├── tasks/
│   ├── urgent/
│   ├── normal/
│   └── backlog/
├── done/
│   └── 2024-07/   # Monthly archives
└── notes/
```

### Level 3: Team Mode  

When multiple people join:

```bash
simone enable team
```

Adds:
- Task assignment (`@person`)
- Daily standups
- Sprint support

### Level 4: Full Mode

When you need "enterprise" features:

```bash
simone enable full
```

Gets you the complete original Simone with:
- Quality gates
- Architecture decision records
- Bug tracking
- Technical debt management
- 40+ Claude Code commands

## Under the Hood

### Tasks Are Just Files

A task is literally just a markdown file:

```markdown
# Fix login bug

Created: 2024-07-16 10:30
Priority: urgent
Assigned: @alice

## Notes
- Users report 404 on login
- Started investigating auth service
```

The format is flexible and requires no rigid schema or validation rules.

### IDs Are Just Timestamps

Task ID = Unix timestamp. Simple, unique, sortable.

```bash
1720634421.md = Task created at that second
```

### Search Is Just Grep

```bash
simone find "login"
# Literally runs: grep -r "login" .simone/
```

### Everything Is Scriptable

Since it's just files:
- `git` tracks changes
- `rsync` for backup  
- `grep` for search
- Any editor works

## Progressive Complexity in Action

**Solo Developer:**
```bash
simone add "Build API"
simone add "Write tests"  
simone list
# 2 tasks, 0 complexity
```

**Small Team:**
```bash
simone enable team
simone add --assign @bob "Review API design"
simone standup
# Shows who's doing what
```

**Growing Startup:**
```bash
simone enable organize
simone add --urgent "Fix customer bug"
simone report
# See task distribution
```

**Enterprise:**
```bash
simone enable full
# Now use all 40+ commands
# Create ADRs, manage sprints, track metrics
```

## Why This Works

1. **Familiarity** - It's just files and folders
2. **Flexibility** - Any tool that works with files works with Simone
3. **Portability** - Copy the folder, copy the project
4. **Simplicity** - Start with 5 commands, not 50
5. **Growth** - Complexity is opt-in, not forced

## Integration with Claude Code

Simone was built for AI-assisted development:

```bash
# In Claude Code
/project:simone:do_task T123

# Claude can:
# - Read task requirements
# - Implement solution
# - Update task status
# - Create new tasks
```

The simple file structure means Claude can understand your entire project state instantly.

## Migration Path

Have an existing complex Simone project?

```bash
simone-migrate --analyze
# Recommends: organize mode
# 47 tasks → 3 folders
# 200 files → 50 files
```

## The Anti-Patterns We Avoid

❌ **Metadata First** - We add fields only when needed
❌ **Process Theater** - No mandatory workflows
❌ **Tool Lock-in** - It's just markdown files
❌ **Upfront Decisions** - Start simple, evolve naturally
❌ **Feature Creep** - Complexity requires explicit opt-in

---

Simone provides a task management approach that begins with minimal complexity and can scale to meet enterprise needs based on user requirements.