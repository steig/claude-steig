# Simone Documentation

Simone is a task management framework that starts simple and grows with your needs.

## Quick Start

```bash
# Install
curl -sSL https://raw.githubusercontent.com/yourusername/simone/main/install-simone.sh | bash

# Create a task
simone add "Fix login bug"

# List tasks  
simone list

# Complete a task
simone done 123456

# Basic workflow established
```

## Documentation

- [How It Works](HOW-IT-WORKS.md) - The core idea in 5 minutes
- [Commands](COMMANDS.md) - All commands with examples  
- [Examples](EXAMPLES.md) - Real-world usage patterns
- [Troubleshooting](TROUBLESHOOTING.md) - When things go wrong

## Core Philosophy

1. **Start simple** - 5 commands is all you need
2. **Grow as needed** - Enable features when you actually need them
3. **Files, not databases** - Everything is just markdown
4. **Performance over process** - Get work done, not manage work

## Progressive Complexity

```bash
# Day 1: Just tasks
simone add "Build feature"

# Week 2: Need priorities?
simone enable organize
simone add --urgent "Fix production bug"

# Month 2: Team grows?
simone enable team
simone add --assign @alice "Review PR"

# Year 1: Need full process?
simone enable full
# Now you have sprints, quality gates, etc.
```

## For Existing Simone Users

If you have an existing Simone project with all the complexity:

```bash
# Analyze and migrate to simpler structure
simone-migrate

# Or keep everything as-is
simone-migrate --force-full
```

## Key Benefits

- **Claude Code Integration** - Built to work perfectly with AI assistance
- **No Learning Curve** - If you can use `ls` and `cd`, you can use Simone
- **Grows With You** - From solo hacking to enterprise teams
- **Just Files** - No lock-in, no databases, just markdown

---

For detailed information, please refer to the documentation files listed above.