# Troubleshooting

Common issues and how to fix them.

## Installation Issues

### "Command not found: simone"

The `simone` script isn't in your PATH.

**Fix:**
```bash
# Option 1: Use ./simone
./simone list

# Option 2: Add to PATH
export PATH="$PATH:$(pwd)"

# Option 3: Link to bin
ln -s $(pwd)/simone /usr/local/bin/simone
```

### "Permission denied"

The simone script isn't executable.

**Fix:**
```bash
chmod +x simone
```

### Installation fails

**Fix:**
```bash
# Manual install
git clone https://github.com/yourusername/simone
cd simone
cp simone-hybrid simone
chmod +x simone
```

## Usage Issues

### "Not in a Simone project"

You're not in a directory with `.simone/` folder.

**Fix:**
```bash
# Initialize new project
simone init

# Or cd to existing project
cd /path/to/your/project
```

### Tasks not showing up

Tasks might be in organized folders.

**Fix:**
```bash
# Show all tasks including organized
simone list --all

# Or check folders directly
ls .simone/tasks/*/
```

### Can't find old task

Task might be completed.

**Fix:**
```bash
# Search everywhere including done
simone find "task description"

# Or check done folder
ls .simone/done/
```

## Migration Issues

### "Migration failed"

The migration tool hit an error.

**Fix:**
```bash
# Your backup is safe
ls -la .simone-backup-*

# Restore and try different mode
rm -rf .simone
mv .simone-backup-[timestamp] .simone
simone-migrate --force-simple  # Try simpler mode
```

### Lost tasks after migration

Tasks were migrated but to different locations.

**Fix:**
```bash
# Find all markdown files
find .simone -name "*.md" -type f

# Or restore from backup
cp -r .simone-backup-*/* .simone/
```

## Feature Issues

### "Command not found" after enable

You enabled a feature but command doesn't work.

**Fix:**
```bash
# Check current mode
cat .simone/config

# Re-enable
simone enable organize  # or team/full

# Verify help shows new commands
simone help
```

### Wrong mode enabled

Enabled team but wanted organize.

**Fix:**
```bash
# Just change it
simone enable organize

# Structures are compatible, nothing lost
```

## Performance Issues

### Slow with many tasks

Thousands of files can slow down.

**Fix:**
```bash
# Archive old tasks
mkdir .simone/archive
mv .simone/done/2023-* .simone/archive/

# Or use full mode with better organization
simone enable full
```

### Search is slow

Large projects make grep slow.

**Fix:**
```bash
# Use more specific searches
simone find "error" | grep -i "login"  # Instead of broad search

# Or use ripgrep if available
alias simone-find='rg --type md'
simone-find "search term" .simone/
```

## Integration Issues

### Claude Code can't find tasks

Claude might be looking in wrong location.

**Fix:**
```bash
# Ensure you're in project root
pwd  # Should show project root with .simone/

# In Claude Code
/project:simone:list  # Should work now
```

### Git showing too many changes

`.simone/` folder might not be in gitignore.

**Fix:**
```bash
echo ".simone/.cache/" >> .gitignore
echo ".simone/done/" >> .gitignore  # Optional
git add .gitignore
git commit -m "Ignore simone cache"
```

## Data Recovery

### Accidentally deleted task

Check if it's just marked done.

**Fix:**
```bash
# Check done folder
ls .simone/done/

# To restore
mv .simone/done/[task-id].md .simone/tasks/
```

### Corrupted task file

Task file got messed up.

**Fix:**
```bash
# Tasks are just markdown, edit directly
vi .simone/tasks/[task-id].md

# Or recreate
simone add "Same task description"
rm .simone/tasks/[broken-task-id].md
```

### Lost everything

No backup and deleted .simone.

**Fix:**
```bash
# Check git
git status  # If tracked
git checkout .simone/

# Check system trash
# Mac: ~/.Trash
# Linux: ~/.local/share/Trash

# Last resort: grep disk for content
sudo grep -r "task description" / 2>/dev/null
```

## Common Mistakes

### Using full paths in commands
```bash
# Wrong
simone add /home/user/project/task

# Right  
simone add "task description"
```

### Trying to use complex features without enabling
```bash
# Wrong
simone add --urgent "Fix bug"  # Error if not enabled

# Right
simone enable organize
simone add --urgent "Fix bug"
```

### Editing task IDs
```bash
# Wrong - IDs are immutable
mv .simone/tasks/123.md .simone/tasks/better-name.md

# Right - IDs stay same, edit content
vi .simone/tasks/123.md  # Change title inside file
```

## Getting Help

### Built-in help
```bash
simone help
simone-migrate --help
```

### Check version and mode
```bash
cat .simone/config  # See current mode
ls -la simone  # Check if it's symlink
```

### Debug mode
```bash
# Run with bash debugging
bash -x simone list

# See what's happening
set -x
simone list
set +x
```

---

## Additional Support

If issues persist:
- Verify command syntax
- Try the basic version of the command
- Inspect files directly in `.simone/`
- Remember that tasks are standard markdown files that can be edited directly