#!/usr/bin/env bash
# Cache management utilities for Simone
# Handles all caching operations including cleanup and monitoring

# Cache configuration
CACHE_ROOT="${SIMONE_CACHE_DIR:-.simone/.cache}"
CACHE_MAX_SIZE="${SIMONE_CACHE_MAX_SIZE:-100M}"  # Maximum cache size
CACHE_MAX_AGE="${SIMONE_CACHE_MAX_AGE:-7}"       # Days to keep cached items

# Initialize cache system
init_cache() {
    mkdir -p "$CACHE_ROOT"/{templates,queries,files,git}
    
    # Create cache metadata file
    if [[ ! -f "$CACHE_ROOT/metadata.json" ]]; then
        cat > "$CACHE_ROOT/metadata.json" <<EOF
{
    "version": "1.0",
    "created": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "last_cleanup": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
    fi
}

# Cache size management
check_cache_size() {
    local current_size=$(du -sh "$CACHE_ROOT" 2>/dev/null | cut -f1)
    echo "$current_size"
}

# Cache cleanup based on age and size
cleanup_cache() {
    local cleanup_count=0
    
    echo "🧹 Starting cache cleanup..."
    
    # Remove old cache files
    find "$CACHE_ROOT" -type f -name "*.ttl" -mtime +${CACHE_MAX_AGE} | while read ttl_file; do
        local cache_file="${ttl_file%.ttl}"
        rm -f "$ttl_file" "$cache_file"
        ((cleanup_count++))
    done
    
    # Remove orphaned files
    find "$CACHE_ROOT" -type f ! -name "*.ttl" ! -name "metadata.json" ! -name "*.db" | while read cache_file; do
        if [[ ! -f "${cache_file}.ttl" ]]; then
            rm -f "$cache_file"
            ((cleanup_count++))
        fi
    done
    
    # Update metadata
    local metadata_file="$CACHE_ROOT/metadata.json"
    if command -v jq >/dev/null 2>&1; then
        jq ".last_cleanup = \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"" "$metadata_file" > "${metadata_file}.tmp" && mv "${metadata_file}.tmp" "$metadata_file"
    fi
    
    echo "✅ Cleaned up $cleanup_count cached items"
}

# Advanced cache operations
cache_stats() {
    echo "📊 Cache Statistics"
    echo "=================="
    echo
    
    if [[ ! -d "$CACHE_ROOT" ]]; then
        echo "❌ Cache not initialized"
        return 1
    fi
    
    # Overall stats
    echo "📁 Cache Location: $CACHE_ROOT"
    echo "💾 Total Size: $(check_cache_size)"
    echo "📝 Total Items: $(find "$CACHE_ROOT" -type f ! -name "*.ttl" ! -name "*.json" ! -name "*.db" | wc -l)"
    echo
    
    # Category breakdown
    echo "📂 Cache Categories:"
    for dir in templates queries files git; do
        if [[ -d "$CACHE_ROOT/$dir" ]]; then
            local count=$(find "$CACHE_ROOT/$dir" -type f ! -name "*.ttl" | wc -l)
            local size=$(du -sh "$CACHE_ROOT/$dir" 2>/dev/null | cut -f1 || echo "0")
            printf "  %-12s %4d items (%s)\n" "$dir:" "$count" "$size"
        fi
    done
    echo
    
    # Hit rate calculation (if tracking)
    if [[ -f "$CACHE_ROOT/hit_stats.log" ]]; then
        local total_requests=$(wc -l < "$CACHE_ROOT/hit_stats.log")
        local cache_hits=$(grep "HIT" "$CACHE_ROOT/hit_stats.log" | wc -l)
        if [[ $total_requests -gt 0 ]]; then
            local hit_rate=$(( (cache_hits * 100) / total_requests ))
            echo "📈 Cache Performance:"
            echo "  Hit Rate: ${hit_rate}%"
            echo "  Total Requests: $total_requests"
            echo "  Cache Hits: $cache_hits"
            echo "  Cache Misses: $((total_requests - cache_hits))"
        fi
    fi
}

# Warm up cache with common operations
warmup_cache() {
    echo "🔥 Warming up cache..."
    
    init_cache
    
    # Pre-cache all templates
    if [[ -d ".simone/99_TEMPLATES" ]]; then
        for template in .simone/99_TEMPLATES/*.md; do
            if [[ -f "$template" ]]; then
                local template_name=$(basename "$template")
                cache_template "$template_name" >/dev/null 2>&1
            fi
        done
    fi
    
    # Pre-index all tasks (with timeout to prevent hanging)
    if command -v reindex_all_tasks >/dev/null 2>&1; then
        echo "📊 Building initial task index..."
        timeout 30s reindex_all_tasks >/dev/null 2>&1 || echo "⚠️ Task indexing timed out, will index lazily"
    fi
    
    # Cache project manifest data
    for field in name description version; do
        get_project_info "$field" >/dev/null 2>&1
    done
    
    echo "✅ Cache warmed up"
}

# Monitor cache performance
monitor_cache() {
    local duration="${1:-60}"  # Monitor for 60 seconds by default
    
    echo "📊 Monitoring cache for ${duration}s..."
    echo "Press Ctrl+C to stop"
    echo
    
    local start_time=$(date +%s)
    local end_time=$((start_time + duration))
    
    while [[ $(date +%s) -lt $end_time ]]; do
        clear
        echo "🔍 Cache Monitor - $(date)"
        echo "================================"
        echo
        
        # Current cache size
        echo "💾 Cache Size: $(check_cache_size)"
        
        # Recent cache activity
        if [[ -f "$CACHE_ROOT/hit_stats.log" ]]; then
            echo
            echo "📈 Recent Activity (last 10):"
            tail -10 "$CACHE_ROOT/hit_stats.log" | while read line; do
                echo "  $line"
            done
        fi
        
        # File system activity
        echo
        echo "🔄 File System Activity:"
        local active_files=$(lsof +D "$CACHE_ROOT" 2>/dev/null | wc -l || echo "0")
        echo "  Open Files: $active_files"
        
        sleep 2
    done
}

# Export cache for backup or sharing
export_cache() {
    local export_file="${1:-simone-cache-export.tar.gz}"
    
    echo "📦 Exporting cache to $export_file..."
    
    tar -czf "$export_file" -C "$(dirname "$CACHE_ROOT")" "$(basename "$CACHE_ROOT")" \
        --exclude="*.log" \
        --exclude="*.db-journal"
    
    echo "✅ Cache exported successfully"
    echo "   Size: $(du -h "$export_file" | cut -f1)"
}

# Import cache from export
import_cache() {
    local import_file="${1}"
    
    if [[ ! -f "$import_file" ]]; then
        echo "❌ Import file not found: $import_file"
        return 1
    fi
    
    echo "📥 Importing cache from $import_file..."
    
    # Backup existing cache
    if [[ -d "$CACHE_ROOT" ]]; then
        mv "$CACHE_ROOT" "${CACHE_ROOT}.backup.$(date +%s)"
    fi
    
    # Extract cache
    tar -xzf "$import_file" -C "$(dirname "$CACHE_ROOT")"
    
    echo "✅ Cache imported successfully"
}

# Clear specific cache types
clear_cache_type() {
    local cache_type="$1"
    
    case "$cache_type" in
        "templates")
            rm -rf "$CACHE_ROOT/templates"/*
            echo "✅ Cleared template cache"
            ;;
        "queries")
            rm -rf "$CACHE_ROOT/queries"/*
            echo "✅ Cleared query cache"
            ;;
        "files")
            rm -rf "$CACHE_ROOT/files"/*
            echo "✅ Cleared file cache"
            ;;
        "git")
            rm -rf "$CACHE_ROOT/git"/*
            echo "✅ Cleared git cache"
            ;;
        "all")
            rm -rf "$CACHE_ROOT"/*
            init_cache
            echo "✅ Cleared all caches"
            ;;
        *)
            echo "❌ Unknown cache type: $cache_type"
            echo "   Valid types: templates, queries, files, git, all"
            return 1
            ;;
    esac
}

# Track cache hit/miss for performance monitoring
track_cache_access() {
    local operation="$1"
    local key="$2"
    local result="$3"  # HIT or MISS
    
    if [[ "${SIMONE_CACHE_TRACKING:-true}" == "true" ]]; then
        echo "$(date +%s) $operation $key $result" >> "$CACHE_ROOT/hit_stats.log"
    fi
}