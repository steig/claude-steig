# Technical Details

## Architecture Overview

Simone uses a file-based architecture where each task is a standalone markdown file. This design provides several technical advantages:

- **Atomicity**: Each task is an independent file
- **Versioning**: Works naturally with Git and other VCS
- **Portability**: No proprietary formats or databases
- **Accessibility**: Can be read/edited with any text editor

## File Structure

### Task Files

Tasks use a simple markdown format:

```markdown
# Task Title

Created: YYYY-MM-DD HH:MM
[Priority: urgent]         # If organize mode enabled
[Assigned: @username]      # If team mode enabled

## Notes
Task details and updates
```

### Directory Organization

```
.simone/
├── tasks/
│   ├── [id].md           # Simple mode
│   ├── urgent/          # Organize mode
│   ├── normal/          # Organize mode
│   ├── backlog/         # Organize mode
│   └── @person/         # Team mode
├── done/
│   ├── [id].md          # Simple mode
│   └── YYYY-MM/        # Organize mode
├── notes/
│   └── [id].md
└── config              # Mode configuration
```

## ID Generation

Task IDs are Unix timestamps (seconds since epoch):
- Guaranteed unique within a second
- Naturally sortable
- No external dependencies
- Human-readable when converted

Example: `1720634421` = `2024-07-10 15:20:21 UTC`

## Search Implementation

The `find` command uses grep for searching:
- No indexing required
- Works with standard Unix tools
- Regex support included
- Fast for typical project sizes

## Mode System

Modes are implemented through:
1. Configuration file (`.simone/config`)
2. Feature detection functions
3. Progressive command availability

```bash
# Config file format
SIMONE_MODE=organize  # simple|organize|team|full
```

## Performance Characteristics

### Time Complexity
- Task creation: O(1)
- Task listing: O(n) where n = number of tasks
- Search: O(n*m) where m = average file size
- Completion: O(1) file move operation

### Space Complexity
- Each task: ~1KB typical
- Overhead: Minimal (directory structure only)
- No caching or indexing files

## Integration Points

### Git Integration
```bash
# Recommended .gitignore
.simone/.cache/     # If using full mode
.simone/done/       # Optional
```

### Claude Code Integration
The simple markdown format is optimized for AI parsing:
- Clear structure
- Minimal metadata
- Natural language content

### Export Formats

Data can be exported to:
- **JSON**: Structured data for APIs
- **CSV**: Spreadsheet compatibility
- **Markdown**: Documentation generation

## Limitations and Scaling

### Practical Limits
- Tested up to 10,000 tasks
- Performance degrades beyond 50,000 files
- Search becomes slow with very large tasks

### Mitigation Strategies
- Archive old completed tasks
- Use organize mode for better structure
- Consider full mode for enterprise scale

## Security Considerations

- No authentication built-in (relies on filesystem)
- No encryption (can use filesystem encryption)
- No network access required
- Tasks may contain sensitive information

## Compatibility

### Operating Systems
- Linux: Full support
- macOS: Full support  
- Windows: Requires WSL or Git Bash
- BSD: Should work (untested)

### Shell Requirements
- Bash 4.0+ (for associative arrays in full mode)
- Standard Unix tools: grep, find, sed, awk
- Optional: ripgrep for faster search

### File System Requirements
- Support for Unicode filenames
- Standard POSIX permissions
- No special attributes required

## Extension Points

### Custom Modes
New modes can be added by:
1. Extending the `has_feature()` function
2. Adding mode-specific commands
3. Updating the enable command

### Tool Integration
The file-based approach allows integration with:
- Text editors (VSCode, Vim, etc.)
- File synchronization (Dropbox, etc.)
- Backup systems
- Automation tools

## Debugging

### Common Issues
1. **Permission errors**: Check file ownership
2. **Path issues**: Ensure proper quoting
3. **Mode confusion**: Verify `.simone/config`

### Debug Mode
```bash
# Enable bash debugging
set -x
simone list
set +x
```

## Future Considerations

Areas for potential enhancement:
- Concurrent access handling
- Large-scale optimization
- Additional export formats
- Plugin system for extensions

These would be implemented only if they maintain the core principle of simplicity.