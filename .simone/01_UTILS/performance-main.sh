#!/usr/bin/env bash
# Main performance module for Simone
# This is the entry point that loads all performance optimizations

# Determine script directory
UTILS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all performance modules
source "$UTILS_DIR/performance-optimizer.sh"
source "$UTILS_DIR/cache-manager.sh"
source "$UTILS_DIR/database-manager.sh"
source "$UTILS_DIR/fast-commands.sh"
source "$UTILS_DIR/git-automation.sh"
source "$UTILS_DIR/hooks-integration.sh"

# Performance configuration
export SIMONE_PERFORMANCE_ENABLED="${SIMONE_PERFORMANCE_ENABLED:-true}"
export SIMONE_AUTO_INDEX="${SIMONE_AUTO_INDEX:-false}"
export SIMONE_CACHE_WARMUP="${SIMONE_CACHE_WARMUP:-false}"

# Initialize performance subsystems
init_simone_performance() {
    if [[ "$SIMONE_PERFORMANCE_ENABLED" != "true" ]]; then
        return 0
    fi
    
    echo "⚡ Initializing Simone Performance System..."
    
    # Initialize core components
    init_performance  # From performance-optimizer.sh
    init_cache       # From cache-manager.sh
    init_database    # From database-manager.sh
    
    # Warm up cache if enabled
    if [[ "$SIMONE_CACHE_WARMUP" == "true" ]] && [[ ! -f "$SIMONE_CACHE_DIR/.warmed" ]]; then
        warmup_cache
        touch "$SIMONE_CACHE_DIR/.warmed"
    fi
    
    # Auto-index if database is empty
    if [[ "$SIMONE_AUTO_INDEX" == "true" ]]; then
        local task_count=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks;" 2>/dev/null || echo "0")
        if [[ "$task_count" -eq 0 ]]; then
            echo "📊 Building initial task index..."
            rebuild_database
        fi
    fi
    
    echo "✅ Performance system ready"
}

# Performance command wrapper
perf_command() {
    local cmd="${1:-help}"
    [[ $# -gt 0 ]] && shift
    
    case "$cmd" in
        # Cache management
        "cache")
            case "${1:-status}" in
                "stats") cache_stats ;;
                "clear") clear_cache_type "${2:-all}" ;;
                "warmup") warmup_cache ;;
                "export") export_cache "$2" ;;
                "import") import_cache "$2" ;;
                "monitor") monitor_cache "$2" ;;
                *) cache_stats ;;
            esac
            ;;
            
        # Database management
        "db"|"database")
            case "${1:-status}" in
                "rebuild") rebuild_database ;;
                "analyze") analyze_database ;;
                "optimize") optimize_database ;;
                "backup") backup_database ;;
                "export") export_database_json "$2" ;;
                "query") query_tasks "$2" ;;
                *) analyze_database ;;
            esac
            ;;
            
        # Fast commands
        "status") fast_status ;;
        "search") fast_search "$@" ;;
        "dashboard") fast_dashboard ;;
        "sprint") fast_sprint_status "$@" ;;
        
        # Performance diagnostics
        "benchmark")
            benchmark_simone
            ;;
            
        "diagnose")
            diagnose_performance
            ;;
            
        # Git automation
        "git")
            case "${1:-help}" in
                "batch") batch_git_add "$2" ;;
                "execute") execute_git_batch ;;
                "commit") generate_smart_commit "$2" ;;
                "optimize") optimize_branches ;;
                *) echo "Git commands: batch, execute, commit, optimize" ;;
            esac
            ;;
            
        # Hooks management
        "hooks")
            case "${1:-register}" in
                "register") register_hooks ;;
                "init") init_hooks ;;
                *) register_hooks ;;
            esac
            ;;
            
        # System management
        "disable")
            echo "🛑 Disabling Simone Performance System..."
            if [[ -f "$SIMONE_DB_FILE" ]]; then
                rm -f "$SIMONE_DB_FILE"
                echo "✅ Database file removed"
            fi
            if [[ -d ".simone/.cache" ]]; then
                rm -rf ".simone/.cache"
                echo "✅ Cache directory removed"
            fi
            echo "✅ Performance system disabled"
            ;;
            
        "help"|*)
            echo "Simone Performance System"
            echo "========================"
            echo
            echo "Available commands:"
            echo "  cache      - Cache management (stats, clear, warmup)"
            echo "  db         - Database management (rebuild, analyze, optimize)"
            echo "  status     - Fast project status"
            echo "  search     - Fast task search"
            echo "  dashboard  - Generate performance dashboard"
            echo "  sprint     - Sprint status and management"
            echo "  benchmark  - Run performance benchmarks"
            echo "  diagnose   - Diagnose performance issues"
            echo "  git        - Git automation tools"
            echo "  hooks      - Hook management and registration"
            echo "  disable    - Disable performance system and remove data"
            echo
            echo "Examples:"
            echo "  ./simone perf cache stats"
            echo "  ./simone perf diagnose"
            echo "  ./simone perf db rebuild"
            if [[ "$cmd" != "help" ]]; then
                echo
                echo "Unknown command: $cmd"
                return 1
            fi
            ;;
    esac
}

# Benchmark Simone operations
benchmark_simone() {
    echo "🏃 Benchmarking Simone Performance"
    echo "=================================="
    echo
    
    # Helper function for timing
    time_operation() {
        local name="$1"
        local start=$(date +%s.%N 2>/dev/null || date +%s)
        shift
        "$@" >/dev/null 2>&1
        local end=$(date +%s.%N 2>/dev/null || date +%s)
        
        if command -v bc >/dev/null 2>&1; then
            local duration=$(echo "scale=3; $end - $start" | bc)
        else
            local duration=$((end - start))
        fi
        
        printf "%-30s %8s seconds\n" "$name:" "$duration"
    }
    
    # Benchmark operations
    echo "📊 Core Operations:"
    time_operation "Status (cached)" fast_status
    time_operation "Task search" fast_search "test"
    time_operation "Dashboard generation" fast_dashboard
    
    echo
    echo "💾 Cache Operations:"
    time_operation "Template lookup" cache_template "task.md"
    time_operation "Cache stats" cache_stats
    
    echo
    echo "🗄️ Database Operations:"
    time_operation "Task count" count_tasks_by_status "all"
    time_operation "Task query" list_tasks_by_status "pending" 10
    
    echo
    echo "✅ Benchmark complete"
}

# Diagnose performance issues
diagnose_performance() {
    echo "🔍 Diagnosing Simone Performance"
    echo "================================"
    echo
    
    # Check if performance is enabled
    echo "⚙️ Configuration:"
    echo "  Performance Enabled: $SIMONE_PERFORMANCE_ENABLED"
    echo "  Auto Index: $SIMONE_AUTO_INDEX"
    echo "  Cache Warmup: $SIMONE_CACHE_WARMUP"
    echo
    
    # Check cache health
    echo "💾 Cache Health:"
    if [[ -d "$SIMONE_CACHE_DIR" ]]; then
        echo "  ✅ Cache directory exists"
        echo "  📊 Size: $(du -sh "$SIMONE_CACHE_DIR" 2>/dev/null | cut -f1)"
        echo "  📝 Items: $(find "$SIMONE_CACHE_DIR" -type f ! -name "*.ttl" | wc -l)"
    else
        echo "  ❌ Cache directory missing"
    fi
    echo
    
    # Check database health
    echo "🗄️ Database Health:"
    if [[ -f "$SIMONE_DB_FILE" ]]; then
        echo "  ✅ Database exists"
        echo "  📊 Size: $(du -h "$SIMONE_DB_FILE" 2>/dev/null | cut -f1)"
        local task_count=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM tasks;" 2>/dev/null || echo "0")
        echo "  📝 Tasks: $task_count"
        
        # Check indexes
        local index_count=$(sqlite3 "$SIMONE_DB_FILE" "SELECT COUNT(*) FROM sqlite_master WHERE type='index';" 2>/dev/null || echo "0")
        echo "  🔍 Indexes: $index_count"
    else
        echo "  ❌ Database missing"
    fi
    echo
    
    # Check for common issues
    echo "🚨 Common Issues:"
    
    # Large number of files
    local file_count=$(find .simone -name "*.md" -type f 2>/dev/null | wc -l)
    if [[ $file_count -gt 1000 ]]; then
        echo "  ⚠️ Large number of files ($file_count) - indexing recommended"
    fi
    
    # Missing SQLite
    if ! command -v sqlite3 >/dev/null 2>&1; then
        echo "  ❌ SQLite not installed - database features disabled"
    fi
    
    # Old cache
    if [[ -f "$SIMONE_CACHE_DIR/.warmed" ]]; then
        local cache_age=$(( ($(date +%s) - $(stat -f %m "$SIMONE_CACHE_DIR/.warmed" 2>/dev/null || stat -c %Y "$SIMONE_CACHE_DIR/.warmed" 2>/dev/null)) / 86400 ))
        if [[ $cache_age -gt 7 ]]; then
            echo "  ⚠️ Cache is $cache_age days old - consider rebuilding"
        fi
    fi
    
    echo
    echo "💡 Recommendations:"
    if [[ "$task_count" -eq 0 ]] && [[ $file_count -gt 0 ]]; then
        echo "  • Run 'perf_command db rebuild' to index tasks"
    fi
    if [[ ! -d "$SIMONE_CACHE_DIR" ]]; then
        echo "  • Run 'init_simone_performance' to initialize performance"
    fi
}

# Auto-initialize if sourced directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is being executed directly
    perf_command "$@"
else
    # Script is being sourced
    init_simone_performance
fi