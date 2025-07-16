# Migration Guide

## From Current Simone to Hybrid Simone

### What Changes

**Current State:** Comprehensive framework with 47 commands across 13 directories
**New Approach:** Start with 5 essential commands, add features as needed

### Migration Options

#### Option 1: Auto-Migration (Recommended)

```bash
# Analyze your project
simone-migrate --analyze

# Example output:
# 📊 Project Statistics:
#   Total tasks:      47
#   Sprint tasks:     23
#   General tasks:    24
# 🎯 Recommendation: organize mode

# Apply migration
simone-migrate
# ✅ Migration complete!
```

#### Option 2: Keep Everything

```bash
simone-migrate --force-full
# Keeps all existing complexity
# Uses hybrid commands with full mode
```

#### Option 3: Fresh Start

```bash
# Backup old structure
mv .simone .simone-old

# Start fresh
simone init
simone enable organize  # If you want priorities

# Manually migrate important tasks
grep -h "^# " .simone-old/04_GENERAL_TASKS/*.md | while read title; do
  simone add "$title"
done
```

### What Happens to My Data?

**Tasks** → Migrated based on priority keywords
- "urgent", "critical" → `.simone/tasks/urgent/`
- "low priority", "someday" → `.simone/tasks/backlog/`
- Everything else → `.simone/tasks/normal/`

**Completed Tasks** → Organized by month
- `TX001_Task.md` → `.simone/done/2024-07/[id].md`

**Documentation** → Converted to notes
- ADRs, bugs, tech debt → `.simone/notes/[id].md`

**Sprints** → Preserved in team mode
- Latest sprint → `.simone/sprints/current/`

### Command Mapping

| Old Command | New Command |
|------------|------------|
| `/project:simone:create_task` | `simone add` |
| `/project:simone:do_task` | Still works! |
| `/project:simone:create_pr` | Enable full mode |
| Complex task creation | `simone add` (simple) |

### Benefits After Migration

1. **Faster Operations**
   - `simone add "task"` < 0.1 seconds
   - No validation overhead
   - No metadata requirements

2. **Simpler Structure**
   ```
   Before: 13 directories, 200+ files
   After:  3 directories, just your tasks
   ```

3. **Gradual Complexity**
   - Start with 5 commands
   - Add features as needed
   - Never forced to use complexity

### For Teams

If you're migrating a team project:

```bash
# Team lead runs migration
simone-migrate --force-team

# Team members pull changes
git pull

# Everyone's ready with team features
simone standup  # See team status
```

### Rollback Plan

Migration creates automatic backup:

```bash
# If something goes wrong
rm -rf .simone
mv .simone-backup-[timestamp] .simone

# You're back to original state
```

### FAQ

**Q: Will I lose any data?**
A: No. Migration creates a backup and preserves all content.

**Q: Can I still use all 47 commands?**
A: Yes, with `simone enable full`.

**Q: What if I don't like it?**
A: Use the backup to restore original structure.

**Q: Do Claude Code commands still work?**
A: Yes, they adapt to your current mode.

### Getting Help

```bash
# Check current mode
cat .simone/config

# See available commands
simone help

# Verify migration
simone list --all
```

---

The migration process is designed to be quick and reversible, with automatic backups ensuring data safety.