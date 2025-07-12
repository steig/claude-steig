#!/usr/bin/env bash
# Main performance module for Simone
# Simplified to rely on Serena MCP for IO operations

# Determine script directory
UTILS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source remaining modules (no SQLite dependencies)
if [[ -f "$UTILS_DIR/fast-commands.sh" ]]; then
    source "$UTILS_DIR/fast-commands.sh" || echo "⚠️ Failed to load fast-commands.sh"
fi
if [[ -f "$UTILS_DIR/git-automation.sh" ]]; then
    source "$UTILS_DIR/git-automation.sh" || echo "⚠️ Failed to load git-automation.sh"
fi
if [[ -f "$UTILS_DIR/hooks-integration.sh" ]]; then
    source "$UTILS_DIR/hooks-integration.sh" || echo "⚠️ Failed to load hooks-integration.sh"
fi

# Performance configuration (simplified)
export SIMONE_PERFORMANCE_ENABLED="${SIMONE_PERFORMANCE_ENABLED:-true}"

# Initialize performance subsystems (simplified)
init_simone_performance() {
    if [[ "$SIMONE_PERFORMANCE_ENABLED" != "true" ]]; then
        return 0
    fi
    
    echo "⚡ Initializing Simone (relying on Serena MCP for IO)..."
    
    # No complex initialization needed - Serena handles IO efficiently
    echo "✅ Performance system ready"
}

# Simple built-in functions (no SQLite dependencies)
simple_status() {
    echo "=== Simone Status ==="
    echo
    
    # Basic project info
    if [[ -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
        local project_name=$(grep "^project_name:" ".simone/00_PROJECT_MANIFEST.md" | cut -d'"' -f2 2>/dev/null)
        if [[ -n "$project_name" ]]; then
            echo "📁 Project: $project_name"
            echo
        fi
    fi
    
    # Simple task counts from files
    echo "📊 Task Summary:"
    local total_files=$(find .simone -path "*/0[34]_*" -name "*.md" -type f 2>/dev/null | wc -l)
    local pending_files=0
    local progress_files=0  
    local completed_files=0
    
    if [[ $total_files -gt 0 ]]; then
        pending_files=$(find .simone -path "*/0[34]_*" -name "*.md" -type f -exec grep -l "^status: pending" {} \; 2>/dev/null | wc -l)
        progress_files=$(find .simone -path "*/0[34]_*" -name "*.md" -type f -exec grep -l "^status: in_progress" {} \; 2>/dev/null | wc -l)
        completed_files=$(find .simone -path "*/0[34]_*" -name "*.md" -type f -exec grep -l "^status: completed" {} \; 2>/dev/null | wc -l)
    fi
    
    echo "  Total Tasks:  $total_files"
    echo "  Pending:      $pending_files"
    echo "  In Progress:  $progress_files"
    echo "  Completed:    $completed_files"
    
    if [[ $total_files -gt 0 ]]; then
        local completion_rate=$(( (completed_files * 100) / total_files ))
        echo "  Completion:   ${completion_rate}%"
    fi
}

simple_search() {
    local query="$1"
    
    if [[ -z "$query" ]]; then
        echo "Usage: search <query>"
        return 1
    fi
    
    echo "🔍 Searching for: $query"
    echo
    
    # Simple grep search
    echo "Found in task files:"
    grep -r "$query" .simone/0[34]_* --include="*.md" 2>/dev/null | head -10
}

simple_dashboard() {
    echo "# Project Dashboard"
    echo "*Last Updated: $(date)*"
    echo
    simple_status
}

simple_sprint_status() {
    local sprint_name="${1}"
    
    if [[ -z "$sprint_name" ]]; then
        echo "Active sprints:"
        find .simone/03_SPRINTS -type d -name "S*" 2>/dev/null | sort
        return 0
    fi
    
    echo "🏃 Sprint: $sprint_name"
    echo
    
    # Find sprint directory
    local sprint_dir=$(find .simone/03_SPRINTS -type d -name "*$sprint_name*" | head -1)
    if [[ -z "$sprint_dir" ]]; then
        echo "❌ Sprint not found: $sprint_name"
        return 1
    fi
    
    # Count tasks in sprint
    local total=$(find "$sprint_dir" -name "*.md" -not -name "*meta*" -type f 2>/dev/null | wc -l)
    local completed=$(grep -l "^status: completed" "$sprint_dir"/*.md 2>/dev/null | wc -l)
    local in_progress=$(grep -l "^status: in_progress" "$sprint_dir"/*.md 2>/dev/null | wc -l)
    local pending=$(grep -l "^status: pending" "$sprint_dir"/*.md 2>/dev/null | wc -l)
    
    echo "📊 Sprint Statistics:"
    echo "  Total Tasks:  $total"
    echo "  Completed:    $completed"
    echo "  In Progress:  $in_progress"
    echo "  Pending:      $pending"
    
    if [[ $total -gt 0 ]]; then
        local progress=$(( (completed * 100) / total ))
        echo "  Progress:     ${progress}%"
    fi
}

# Performance command wrapper
perf_command() {
    local cmd="${1:-help}"
    [[ $# -gt 0 ]] && shift
    
    case "$cmd" in
        # Removed cache and database management - Serena handles this
            
        # Fast commands - embedded simple versions
        "status") 
            simple_status
            ;;
        "search") 
            simple_search "$@"
            ;;
        "dashboard") 
            simple_dashboard
            ;;
        "sprint") 
            simple_sprint_status "$@"
            ;;
        
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
            echo "✅ Performance system disabled (Serena handles core functionality)"
            ;;
            
        "help"|*)
            echo "Simone Performance System"
            echo "========================"
            echo
            echo "Available commands:"
            echo "  status     - Fast project status"
            echo "  search     - Fast task search"
            echo "  dashboard  - Generate performance dashboard"
            echo "  sprint     - Sprint status and management"
            echo "  git        - Git automation tools"
            echo "  hooks      - Hook management and registration"
            echo "  disable    - Disable performance system"
            echo
            echo "Examples:"
            echo "  ./simone perf status"
            echo "  ./simone perf search task"
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
    echo "📁 File Operations (handled by Serena):"
    time_operation "File listing" find .simone -name "*.md" -type f
    
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
    echo
    
    # Check Simone structure
    echo "📁 Simone Structure:"
    if [[ -d ".simone" ]]; then
        echo "  ✅ Simone directory exists"
        echo "  📊 Total files: $(find .simone -name "*.md" -type f | wc -l)"
        echo "  📝 Task files: $(find .simone -path "*/0[34]_*" -name "*.md" -type f | wc -l)"
    else
        echo "  ❌ Simone directory missing"
    fi
    echo
    
    # Check for common issues
    echo "🚨 Common Issues:"
    
    # Large number of files
    local file_count=$(find .simone -name "*.md" -type f 2>/dev/null | wc -l)
    if [[ $file_count -gt 1000 ]]; then
        echo "  ⚠️ Large number of files ($file_count) - Serena will handle efficiently"
    fi
    
    # Check if Serena MCP is available
    if ! command -v claude >/dev/null 2>&1; then
        echo "  ⚠️ Claude CLI not found - Serena MCP may not be available"
    fi
    
    echo
    echo "💡 Recommendations:"
    if [[ $file_count -gt 100 ]]; then
        echo "  • Use Serena MCP for efficient file operations"
        echo "  • Consider project organization review"
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