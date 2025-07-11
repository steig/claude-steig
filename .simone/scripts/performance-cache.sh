#!/bin/bash

# Performance Caching System for Simone Framework
# Provides intelligent caching for templates, context, and frequently accessed data

set -e

# Configuration
CACHE_DIR=".simone/.cache"
TEMPLATE_CACHE="$CACHE_DIR/templates"
CONTEXT_CACHE="$CACHE_DIR/context"
MAX_CACHE_AGE=3600  # 1 hour in seconds
PERF_LOG="$CACHE_DIR/performance.log"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging function
log_performance() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$PERF_LOG"
}

# Initialize cache directory structure
init_cache() {
    mkdir -p "$CACHE_DIR" "$TEMPLATE_CACHE" "$CONTEXT_CACHE"
    log_performance "Cache system initialized"
    echo -e "${GREEN}✓${NC} Cache system initialized"
}

# Cache template files for faster access
cache_templates() {
    local template_dir=".simone/99_TEMPLATES"
    local cache_time=$(date +%s)
    
    if [ ! -d "$template_dir" ]; then
        echo -e "${YELLOW}⚠${NC} Templates directory not found"
        return 1
    fi
    
    echo -e "${BLUE}[INFO]${NC} Caching templates for faster access..."
    
    # Cache all template files with metadata
    find "$template_dir" -name "*.md" -type f | while read -r template; do
        local cache_file="$TEMPLATE_CACHE/$(basename "$template")"
        local template_hash=$(md5sum "$template" | cut -d' ' -f1)
        
        # Create cache entry with metadata
        {
            echo "# CACHE_METADATA"
            echo "# SOURCE: $template"
            echo "# HASH: $template_hash"
            echo "# CACHED: $cache_time"
            echo "# ---"
            cat "$template"
        } > "$cache_file"
        
        log_performance "Template cached: $(basename "$template")"
    done
    
    echo -e "${GREEN}✓${NC} Templates cached successfully"
}

# Cache project context for faster command execution
cache_project_context() {
    local context_file="$CONTEXT_CACHE/project_context.md"
    local manifest_file=".simone/00_PROJECT_MANIFEST.md"
    
    echo -e "${BLUE}[INFO]${NC} Caching project context..."
    
    {
        echo "# PROJECT CONTEXT CACHE"
        echo "# Generated: $(date)"
        echo "# ---"
        echo ""
        
        # Include manifest if it exists
        if [ -f "$manifest_file" ]; then
            echo "## Project Manifest"
            cat "$manifest_file"
            echo ""
        fi
        
        # Include recent milestones
        if [ -d ".simone/02_REQUIREMENTS" ]; then
            echo "## Active Milestones"
            find ".simone/02_REQUIREMENTS" -name "*.md" -type f | head -5 | while read -r file; do
                echo "### $(basename "$file" .md)"
                head -10 "$file" | grep -E "^#|^-|^title:" || true
                echo ""
            done
        fi
        
        # Include current sprint status
        if [ -d ".simone/03_SPRINTS" ]; then
            echo "## Current Sprint Status"
            find ".simone/03_SPRINTS" -name "*.md" -type f | head -3 | while read -r file; do
                echo "### $(basename "$file" .md)"
                head -5 "$file" | grep -E "^#|^status:|^progress:" || true
                echo ""
            done
        fi
        
        # Include architectural decisions
        if [ -d ".simone/05_ARCHITECTURAL_DECISIONS" ]; then
            echo "## Key Architectural Decisions"
            find ".simone/05_ARCHITECTURAL_DECISIONS" -name "*.md" -type f | head -3 | while read -r file; do
                echo "### $(basename "$file" .md)"
                grep -E "^# |^## Decision|^## Status" "$file" | head -3 || true
                echo ""
            done
        fi
        
    } > "$context_file"
    
    log_performance "Project context cached"
    echo -e "${GREEN}✓${NC} Project context cached"
}

# Clean expired cache entries
clean_cache() {
    local current_time=$(date +%s)
    local cleaned_count=0
    
    echo -e "${BLUE}[INFO]${NC} Cleaning expired cache entries..."
    
    # Clean template cache
    if [ -d "$TEMPLATE_CACHE" ]; then
        find "$TEMPLATE_CACHE" -name "*.md" -type f | while read -r cache_file; do
            local cache_time=$(grep "# CACHED:" "$cache_file" 2>/dev/null | cut -d' ' -f3)
            if [ -n "$cache_time" ] && [ $((current_time - cache_time)) -gt $MAX_CACHE_AGE ]; then
                rm -f "$cache_file"
                cleaned_count=$((cleaned_count + 1))
                log_performance "Expired cache removed: $(basename "$cache_file")"
            fi
        done
    fi
    
    # Clean context cache if old
    local context_file="$CONTEXT_CACHE/project_context.md"
    if [ -f "$context_file" ]; then
        local file_age=$(( current_time - $(stat -f %m "$context_file" 2>/dev/null || echo $current_time) ))
        if [ $file_age -gt $MAX_CACHE_AGE ]; then
            rm -f "$context_file"
            cleaned_count=$((cleaned_count + 1))
            log_performance "Expired context cache removed"
        fi
    fi
    
    echo -e "${GREEN}✓${NC} Cache cleanup completed ($cleaned_count items removed)"
}

# Get cached template with fallback
get_template() {
    local template_name="$1"
    local cache_file="$TEMPLATE_CACHE/$template_name"
    local original_file=".simone/99_TEMPLATES/$template_name"
    
    # Check if cached version exists and is valid
    if [ -f "$cache_file" ]; then
        local cached_hash=$(grep "# HASH:" "$cache_file" | cut -d' ' -f3)
        local original_hash=$(md5sum "$original_file" 2>/dev/null | cut -d' ' -f1)
        
        if [ "$cached_hash" = "$original_hash" ]; then
            log_performance "Template served from cache: $template_name"
            # Return content without cache metadata
            sed '1,/^# ---$/d' "$cache_file"
            return 0
        fi
    fi
    
    # Fallback to original file
    log_performance "Template served from source: $template_name"
    cat "$original_file"
}

# Performance statistics
show_stats() {
    echo -e "${BLUE}[INFO]${NC} Performance Cache Statistics"
    echo "=================================="
    
    if [ -f "$PERF_LOG" ]; then
        echo "Recent operations:"
        tail -10 "$PERF_LOG"
        echo ""
        
        echo "Cache usage summary:"
        grep "served from cache" "$PERF_LOG" | wc -l | xargs echo "Templates served from cache:"
        grep "served from source" "$PERF_LOG" | wc -l | xargs echo "Templates served from source:"
    fi
    
    if [ -d "$CACHE_DIR" ]; then
        echo "Cache size:"
        du -sh "$CACHE_DIR" 2>/dev/null || echo "0B"
    fi
}

# Main command handling
case "${1:-help}" in
    "init")
        init_cache
        ;;
    "templates")
        init_cache
        cache_templates
        ;;
    "context")
        init_cache
        cache_project_context
        ;;
    "clean")
        clean_cache
        ;;
    "get")
        get_template "$2"
        ;;
    "stats")
        show_stats
        ;;
    "refresh")
        init_cache
        cache_templates
        cache_project_context
        ;;
    "help"|*)
        echo "Simone Performance Cache System"
        echo "Usage: $0 {init|templates|context|clean|get <template>|stats|refresh}"
        echo ""
        echo "Commands:"
        echo "  init      - Initialize cache directory structure"
        echo "  templates - Cache all template files"
        echo "  context   - Cache project context for faster access"
        echo "  clean     - Remove expired cache entries"
        echo "  get       - Get cached template (fallback to source)"
        echo "  stats     - Show performance statistics"
        echo "  refresh   - Refresh all caches"
        ;;
esac