# Simone Framework Utilities

This directory contains utility modules that support Simone framework operations.

## 🚀 Quick Start

The utility system is automatically initialized when you source any Simone command. To manually initialize:

```bash
source .simone/01_UTILS/performance-main.sh
```

## 📁 Module Structure

- **performance-main.sh** - Main entry point and command dispatcher
- **fast-commands.sh** - Optimized implementations of common commands
- **git-automation.sh** - Git operation batching and smart commits
- **hooks-integration.sh** - Claude Code hooks for automated workflows
- **metadata-manager.sh** - Project metadata management utilities
- **command-validator.sh** - Command validation and error checking

## ⚡ Utility Features

### 1. Task Management System
- File-based task queries with grep/find
- Basic search capabilities
- Task status tracking through files
- Simple file organization

### 2. Basic Caching
- Template caching system
- Simple result caching
- Configurable TTL (time-to-live)
- Automatic cache cleanup

### 3. Utility Commands
- `simple_status` - Project status display
- `simple_search` - Task search functionality
- `simple_sprint_status` - Sprint analytics
- `simple_dashboard` - Project dashboard generation

### 4. Batch Operations
- Git command batching
- Parallel file processing
- Bulk database updates

### 5. Git Automation
- Intelligent batch staging
- Smart commit message generation
- Post-commit cache updates
- Branch optimization

### 6. Claude Code Hooks
- Automatic quality checks on file changes
- Git staging automation
- Session cleanup and optimization
- Metadata validation

## 📊 Usage Examples

### Check Performance Status
```bash
./simone perf diagnose
```

### View Cache Statistics
```bash
./simone perf cache stats
```

### Rebuild Task Database
```bash
./simone perf db rebuild
```

### Run Performance Benchmark
```bash
./simone perf benchmark
```

### Clear All Caches
```bash
./simone perf cache clear all
```

### Git Automation
```bash
# Batch add files (automatically executes when batch is full)
./simone perf git batch file1.md
./simone perf git batch file2.md

# Execute pending git operations
./simone perf git execute

# Generate smart commit message
./simone perf git commit "Base commit message"

# Optimize branches
./simone perf git optimize
```

### Claude Code Hooks Setup
```bash
# Show hook configuration for .claude/settings.json
./simone perf hooks register

# Initialize hooks system
./simone perf hooks init
```

## ⚙️ Configuration

Set these environment variables to customize behavior:

```bash
export SIMONE_CACHE_TTL=300          # Cache TTL in seconds (default: 300)
export SIMONE_CACHE_DIR=.simone/.cache  # Cache directory
export SIMONE_DB_FILE=.simone/.cache/tasks.db  # Database location
export SIMONE_PERFORMANCE_ENABLED=true  # Enable/disable performance features
export SIMONE_AUTO_INDEX=true        # Auto-index tasks on startup
export SIMONE_CACHE_WARMUP=true     # Warm cache on initialization
```

## 🔧 Advanced Usage

### Custom Database Queries
```bash
./simone perf db query "SELECT * FROM tasks WHERE priority='high' AND status='pending'"
```

### Export Database
```bash
./simone perf db export tasks_backup.json
```

### Monitor Cache in Real-time
```bash
./simone perf cache monitor 60  # Monitor for 60 seconds
```

### Import/Export Cache
```bash
# Export cache for sharing
./simone perf cache export my_cache.tar.gz

# Import cache from export
./simone perf cache import my_cache.tar.gz
```

## 🚨 Troubleshooting

### Performance Not Working?
1. Check if SQLite is installed: `which sqlite3`
2. Run diagnostics: `./simone perf diagnose`
3. Rebuild database: `./simone perf db rebuild`
4. Clear cache: `./simone perf cache clear all`

### Database Corruption
```bash
# Backup and rebuild
./simone perf db backup
rm .simone/.cache/tasks.db
./simone perf db rebuild
```

### Cache Growing Too Large
```bash
# Check cache size
./simone perf cache stats

# Clean old entries
./simone perf cache clear old

# Set max cache size
export SIMONE_CACHE_MAX_SIZE=50M
```

## 📈 Available Functions

Basic utility functions available:
- **Status command**: Project status display
- **Task search**: File-based task search
- **Template operations**: Template management
- **Sprint analytics**: Basic sprint information

## 🔍 Implementation Details

### File Organization
- Task files with metadata
- Sprint and milestone structure
- File-based dependency tracking
- Simple search capabilities
- Basic history through git

### Cache Strategy
- Simple cache implementation
- Basic TTL support
- File-based caching
- Basic cache monitoring

### Utility Techniques
- Lazy loading of modules
- Basic file operations
- Simple template management
- File-based operations
- Sequential processing