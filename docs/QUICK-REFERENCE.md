# Quick Reference Card

## Essential Commands (90% of usage)

```bash
simone add "task"        # Create task
simone list              # Show tasks
simone done <id>         # Complete task
simone find "text"       # Search tasks
```

## Progressive Features

```bash
simone enable organize   # +priorities
simone enable team       # +assignments  
simone enable full       # +everything
```

## Organized Mode

```bash
simone add --urgent "fix prod"
simone add --backlog "refactor"
simone move <id> urgent
simone report
```

## Team Mode

```bash
simone add --assign @alice "review PR"
simone assign <id> @bob
simone standup
```

## File Structure

```
.simone/
├── tasks/       # Active work
│   ├── urgent/      (organize mode)
│   ├── normal/      (organize mode)
│   ├── backlog/     (organize mode)
│   └── @person/     (team mode)
├── done/        # Completed
│   └── 2024-07/     (organize mode)
└── notes/       # Knowledge
```

## Task File Format

```markdown
# Task title

Created: 2024-07-16 10:30
Priority: urgent        (if organize mode)
Assigned: @alice        (if team mode)

## Notes
Whatever you want here
```

## Common Workflows

### Daily
```bash
simone list             # What to do?
simone done <id>        # Mark complete
simone add "new thing"  # Add as you go
```

### Weekly Review
```bash
simone report           # Statistics
simone list --all       # Everything
ls .simone/done/$(date +%Y-%m)/  # What got done
```

### Quick Capture
```bash
alias t='simone add'
t "Call Bob about project"
t "Fix that weird bug"
t "Buy coffee"
```

## Tips

- Task IDs are just timestamps
- Everything is just markdown files
- Use `git` to track changes
- `grep` works on everything
- Start simple, add features later

---
*Full docs: [README](README.md) | [How It Works](HOW-IT-WORKS.md) | [Commands](COMMANDS.md) | [Examples](EXAMPLES.md) | [Troubleshooting](TROUBLESHOOTING.md)*