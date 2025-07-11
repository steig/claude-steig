#!/bin/bash

# Performance Monitoring System for Simone Framework
# Tracks execution times, resource usage, and identifies bottlenecks

set -e

# Configuration
MONITOR_DIR=".simone/.cache/monitoring"
TIMING_LOG="$MONITOR_DIR/timing.log"
RESOURCE_LOG="$MONITOR_DIR/resources.log"
BOTTLENECK_LOG="$MONITOR_DIR/bottlenecks.log"
COMMAND_LOG="$MONITOR_DIR/commands.log"

# Performance thresholds (in seconds)
SLOW_COMMAND_THRESHOLD=5
VERY_SLOW_THRESHOLD=15

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Initialize monitoring system
init_monitoring() {
    mkdir -p "$MONITOR_DIR"
    echo "# Simone Performance Monitoring Log" > "$TIMING_LOG"
    echo "# Started: $(date)" >> "$TIMING_LOG"
    echo "# Format: timestamp|command|duration|status" >> "$TIMING_LOG"
    echo "" >> "$TIMING_LOG"
    
    echo -e "${GREEN}✓${NC} Performance monitoring initialized"
}

# Start timing a command
start_timer() {
    local command_name="$1"
    local start_time=$(date +%s.%N)
    
    echo "$start_time" > "$MONITOR_DIR/start_${command_name//\//_}.tmp"
    echo "[$(date '+%H:%M:%S')] Started: $command_name" >> "$COMMAND_LOG"
}

# End timing and log results
end_timer() {
    local command_name="$1"
    local status="${2:-success}"
    local end_time=$(date +%s.%N)
    local start_file="$MONITOR_DIR/start_${command_name//\//_}.tmp"
    
    if [ ! -f "$start_file" ]; then
        echo -e "${YELLOW}⚠${NC} No start time found for: $command_name"
        return 1
    fi
    
    local start_time=$(cat "$start_file")
    local duration=$(echo "$end_time - $start_time" | bc -l)
    local duration_formatted=$(printf "%.3f" "$duration")
    
    # Log the timing data
    echo "$(date '+%Y-%m-%d %H:%M:%S')|$command_name|$duration_formatted|$status" >> "$TIMING_LOG"
    
    # Check for performance issues
    if (( $(echo "$duration > $VERY_SLOW_THRESHOLD" | bc -l) )); then
        echo "$(date '+%Y-%m-%d %H:%M:%S')|VERY_SLOW|$command_name|${duration_formatted}s" >> "$BOTTLENECK_LOG"
        echo -e "${RED}🐌${NC} Very slow command detected: $command_name (${duration_formatted}s)"
    elif (( $(echo "$duration > $SLOW_COMMAND_THRESHOLD" | bc -l) )); then
        echo "$(date '+%Y-%m-%d %H:%M:%S')|SLOW|$command_name|${duration_formatted}s" >> "$BOTTLENECK_LOG"
        echo -e "${YELLOW}⚠${NC} Slow command: $command_name (${duration_formatted}s)"
    else
        echo -e "${GREEN}✓${NC} $command_name completed in ${duration_formatted}s"
    fi
    
    # Cleanup
    rm -f "$start_file"
    echo "[$(date '+%H:%M:%S')] Completed: $command_name ($duration_formatted s)" >> "$COMMAND_LOG"
}

# Monitor system resources
monitor_resources() {
    local label="${1:-system}"
    
    # Get current resource usage
    local cpu_usage=$(ps -A -o %cpu | awk '{cpu += $1} END {print cpu}')
    local memory_usage=$(ps -A -o %mem | awk '{mem += $1} END {print mem}')
    local disk_usage=$(df . | tail -1 | awk '{print $5}' | sed 's/%//')
    
    # Log resource data
    echo "$(date '+%Y-%m-%d %H:%M:%S')|$label|CPU:${cpu_usage}%|MEM:${memory_usage}%|DISK:${disk_usage}%" >> "$RESOURCE_LOG"
    
    # Check for resource alerts
    if (( $(echo "$cpu_usage > 80" | bc -l) )); then
        echo "$(date '+%Y-%m-%d %H:%M:%S')|HIGH_CPU|${cpu_usage}%" >> "$BOTTLENECK_LOG"
        echo -e "${RED}⚠${NC} High CPU usage detected: ${cpu_usage}%"
    fi
    
    if (( $(echo "$memory_usage > 80" | bc -l) )); then
        echo "$(date '+%Y-%m-%d %H:%M:%S')|HIGH_MEMORY|${memory_usage}%" >> "$BOTTLENECK_LOG"
        echo -e "${RED}⚠${NC} High memory usage detected: ${memory_usage}%"
    fi
}

# Analyze command performance patterns
analyze_performance() {
    echo -e "${BLUE}[INFO]${NC} Analyzing performance patterns..."
    
    if [ ! -f "$TIMING_LOG" ]; then
        echo -e "${YELLOW}⚠${NC} No timing data available"
        return 1
    fi
    
    echo "=== PERFORMANCE ANALYSIS ==="
    echo ""
    
    # Slowest commands
    echo "Slowest Commands (Top 10):"
    grep -v "^#" "$TIMING_LOG" | sort -t'|' -k3 -nr | head -10 | while IFS='|' read -r timestamp command duration status; do
        printf "  %-30s %8ss  [%s]\n" "$command" "$duration" "$status"
    done
    echo ""
    
    # Command frequency
    echo "Most Frequent Commands:"
    grep -v "^#" "$TIMING_LOG" | cut -d'|' -f2 | sort | uniq -c | sort -nr | head -10 | while read -r count command; do
        printf "  %-30s %8d times\n" "$command" "$count"
    done
    echo ""
    
    # Average execution times
    echo "Average Execution Times:"
    grep -v "^#" "$TIMING_LOG" | cut -d'|' -f2,3 | sort | awk -F'|' '
    {
        cmd = $1
        duration = $2
        count[cmd]++
        total[cmd] += duration
    }
    END {
        for (c in count) {
            avg = total[c] / count[c]
            printf "  %-30s %8.3fs (avg of %d runs)\n", c, avg, count[c]
        }
    }' | sort -k2 -nr | head -10
    echo ""
    
    # Bottleneck summary
    if [ -f "$BOTTLENECK_LOG" ]; then
        echo "Recent Bottlenecks:"
        tail -10 "$BOTTLENECK_LOG" | while IFS='|' read -r timestamp type details duration; do
            printf "  %-12s %-30s %s\n" "$type" "$details" "$duration"
        done
    fi
}

# Generate performance report
generate_report() {
    local report_file="$MONITOR_DIR/performance_report_$(date +%Y%m%d_%H%M).md"
    
    echo -e "${BLUE}[INFO]${NC} Generating performance report..."
    
    {
        echo "# Simone Performance Report"
        echo "Generated: $(date)"
        echo ""
        
        echo "## Summary Statistics"
        if [ -f "$TIMING_LOG" ]; then
            local total_commands=$(grep -v "^#" "$TIMING_LOG" | wc -l)
            local avg_duration=$(grep -v "^#" "$TIMING_LOG" | cut -d'|' -f3 | awk '{sum+=$1; count++} END {if(count>0) print sum/count; else print 0}')
            echo "- Total commands executed: $total_commands"
            echo "- Average execution time: $(printf "%.3f" "$avg_duration")s"
        fi
        
        if [ -f "$BOTTLENECK_LOG" ]; then
            local bottleneck_count=$(wc -l < "$BOTTLENECK_LOG")
            echo "- Performance issues detected: $bottleneck_count"
        fi
        echo ""
        
        echo "## Performance Recommendations"
        
        # Check for slow commands
        if [ -f "$TIMING_LOG" ]; then
            local slow_count=$(grep -v "^#" "$TIMING_LOG" | awk -F'|' -v threshold="$SLOW_COMMAND_THRESHOLD" '$3 > threshold' | wc -l)
            if [ "$slow_count" -gt 0 ]; then
                echo "- **$slow_count slow commands detected** - Consider optimization"
                echo "- Enable caching with: \`./scripts/performance-cache.sh refresh\`"
                echo "- Use parallel execution for applicable commands"
            else
                echo "- ✅ No significant performance issues detected"
            fi
        fi
        
        echo ""
        echo "## Detailed Analysis"
        
        # Include the analysis output
        analyze_performance
        
    } > "$report_file"
    
    echo -e "${GREEN}✓${NC} Report generated: $report_file"
}

# Real-time monitoring mode
monitor_realtime() {
    echo -e "${BLUE}[INFO]${NC} Starting real-time monitoring (Ctrl+C to stop)..."
    
    while true; do
        clear
        echo "=== SIMONE REAL-TIME PERFORMANCE MONITOR ==="
        echo "Time: $(date)"
        echo ""
        
        # Show recent commands
        echo "Recent Commands (Last 5):"
        if [ -f "$COMMAND_LOG" ]; then
            tail -5 "$COMMAND_LOG" | while read -r line; do
                echo "  $line"
            done
        fi
        echo ""
        
        # Show current resource usage
        echo "Current Resource Usage:"
        monitor_resources "realtime"
        echo ""
        
        # Show recent bottlenecks
        if [ -f "$BOTTLENECK_LOG" ]; then
            echo "Recent Issues:"
            tail -3 "$BOTTLENECK_LOG" | while IFS='|' read -r timestamp type details duration; do
                echo "  $timestamp - $type: $details $duration"
            done
        fi
        
        sleep 5
    done
}

# Clean old monitoring data
clean_monitoring() {
    local days_to_keep="${1:-7}"
    
    echo -e "${BLUE}[INFO]${NC} Cleaning monitoring data older than $days_to_keep days..."
    
    # Archive old logs
    find "$MONITOR_DIR" -name "*.log" -mtime +$days_to_keep -exec mv {} "$MONITOR_DIR/archive/" \; 2>/dev/null || true
    
    # Clean temporary files
    find "$MONITOR_DIR" -name "*.tmp" -mtime +1 -delete 2>/dev/null || true
    
    echo -e "${GREEN}✓${NC} Monitoring data cleaned"
}

# Main command handling
case "${1:-help}" in
    "init")
        init_monitoring
        ;;
    "start")
        start_timer "$2"
        ;;
    "end")
        end_timer "$2" "$3"
        ;;
    "resources")
        monitor_resources "$2"
        ;;
    "analyze")
        analyze_performance
        ;;
    "report")
        generate_report
        ;;
    "monitor")
        monitor_realtime
        ;;
    "clean")
        clean_monitoring "$2"
        ;;
    "help"|*)
        echo "Simone Performance Monitor"
        echo "Usage: $0 {init|start <cmd>|end <cmd> [status]|resources [label]|analyze|report|monitor|clean [days]}"
        echo ""
        echo "Commands:"
        echo "  init                    - Initialize monitoring system"
        echo "  start <command>         - Start timing a command"
        echo "  end <command> [status]  - End timing and log results"
        echo "  resources [label]       - Monitor current resource usage"
        echo "  analyze                 - Analyze performance patterns"
        echo "  report                  - Generate comprehensive performance report"
        echo "  monitor                 - Real-time monitoring mode"
        echo "  clean [days]            - Clean old monitoring data (default: 7 days)"
        echo ""
        echo "Integration with hooks:"
        echo "  PreToolUse:  ./scripts/performance-monitor.sh start \"\$TOOL_NAME\""
        echo "  PostToolUse: ./scripts/performance-monitor.sh end \"\$TOOL_NAME\""
        ;;
esac