#!/bin/bash

# Simone Framework Link Checker
# Validates all internal and external links in documentation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOCS_DIR="docs"
CACHE_FILE="/tmp/simone-link-cache.txt"
TIMEOUT=10
USER_AGENT="Simone-Link-Checker/1.0"

# Counters
LINKS_CHECKED=0
LINKS_VALID=0
LINKS_BROKEN=0
LINKS_SKIPPED=0

# Arrays for tracking
declare -a BROKEN_LINKS
declare -a VALID_LINKS
declare -a SKIPPED_LINKS

# Utility functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((LINKS_VALID++))
    ((LINKS_CHECKED++))
    VALID_LINKS+=("$1")
}

fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((LINKS_BROKEN++))
    ((LINKS_CHECKED++))
    BROKEN_LINKS+=("$1")
}

skip() {
    echo -e "${YELLOW}[SKIP]${NC} $1"
    ((LINKS_SKIPPED++))
    SKIPPED_LINKS+=("$1")
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Check if running from project root
check_project_root() {
    if [[ ! -d "$DOCS_DIR" ]]; then
        echo -e "${RED}[ERROR]${NC} Documentation directory not found: $DOCS_DIR"
        echo -e "${RED}[ERROR]${NC} Please run this script from the project root directory"
        exit 1
    fi
    success "Found documentation directory: $DOCS_DIR"
}

# Initialize link cache
init_cache() {
    if [[ ! -f "$CACHE_FILE" ]]; then
        touch "$CACHE_FILE"
        log "Created link cache: $CACHE_FILE"
    else
        log "Using existing link cache: $CACHE_FILE"
    fi
}

# Check if URL is in cache and still valid
check_cache() {
    local url="$1"
    local cache_entry=$(grep "^$url|" "$CACHE_FILE" 2>/dev/null || true)
    
    if [[ -n "$cache_entry" ]]; then
        local cached_time=$(echo "$cache_entry" | cut -d'|' -f2)
        local cached_status=$(echo "$cache_entry" | cut -d'|' -f3)
        local current_time=$(date +%s)
        local age=$((current_time - cached_time))
        
        # Cache is valid for 1 hour (3600 seconds)
        if [[ $age -lt 3600 ]]; then
            echo "$cached_status"
            return 0
        fi
    fi
    
    return 1
}

# Add result to cache
cache_result() {
    local url="$1"
    local status="$2"
    local timestamp=$(date +%s)
    
    # Remove existing entry
    grep -v "^$url|" "$CACHE_FILE" > "${CACHE_FILE}.tmp" 2>/dev/null || true
    mv "${CACHE_FILE}.tmp" "$CACHE_FILE"
    
    # Add new entry
    echo "$url|$timestamp|$status" >> "$CACHE_FILE"
}

# Check if external URL is accessible
check_external_url() {
    local url="$1"
    local source_file="$2"
    
    # Check cache first
    local cached_status
    if cached_status=$(check_cache "$url"); then
        if [[ "$cached_status" == "valid" ]]; then
            success "External link (cached): $url"
            return 0
        else
            fail "External link (cached): $url → broken"
            return 1
        fi
    fi
    
    # Validate URL format
    if ! [[ "$url" =~ ^https?:// ]]; then
        fail "Invalid URL format: $url (in $source_file)"
        cache_result "$url" "invalid"
        return 1
    fi
    
    # Check URL accessibility
    local http_status
    http_status=$(curl -s -o /dev/null -w "%{http_code}" \
        --max-time "$TIMEOUT" \
        --user-agent "$USER_AGENT" \
        --location \
        "$url" 2>/dev/null || echo "000")
    
    case "$http_status" in
        200|301|302|303|307|308)
            success "External link: $url → $http_status"
            cache_result "$url" "valid"
            return 0
            ;;
        000)
            fail "External link: $url → timeout/network error (in $source_file)"
            cache_result "$url" "network_error"
            return 1
            ;;
        *)
            fail "External link: $url → HTTP $http_status (in $source_file)"
            cache_result "$url" "http_error_$http_status"
            return 1
            ;;
    esac
}

# Check if internal file path exists
check_internal_link() {
    local link="$1"
    local source_file="$2"
    local source_dir=$(dirname "$source_file")
    
    # Remove anchor fragments for file checking
    local file_path=$(echo "$link" | cut -d'#' -f1)
    
    # Resolve relative path
    local full_path
    if [[ "$file_path" =~ ^/ ]]; then
        # Absolute path from project root
        full_path="${file_path#/}"
    else
        # Relative path from source file directory
        full_path=$(realpath "$source_dir/$file_path" 2>/dev/null || echo "")
    fi
    
    # Check if file exists
    if [[ -f "$full_path" ]]; then
        success "Internal link: $link → $full_path"
        return 0
    else
        fail "Internal link: $link → file not found: $full_path (in $source_file)"
        return 1
    fi
}

# Extract links from markdown file
extract_links() {
    local file="$1"
    
    # Extract markdown links: [text](url)
    grep -oE '\[([^\]]*)\]\(([^)]+)\)' "$file" | sed 's/\[.*\](\([^)]*\)).*/\1/' || true
}

# Check all links in a file
check_file_links() {
    local file="$1"
    local filename=$(basename "$file")
    
    log "Checking links in: $filename"
    
    local links
    links=$(extract_links "$file")
    
    if [[ -z "$links" ]]; then
        log "No links found in $filename"
        return 0
    fi
    
    local file_link_count=0
    echo "$links" | while IFS= read -r link; do
        if [[ -z "$link" ]]; then
            continue
        fi
        
        ((file_link_count++))
        
        # Determine link type and check accordingly
        if [[ "$link" =~ ^https?:// ]]; then
            # External URL
            if [[ "$SKIP_EXTERNAL" == "true" ]]; then
                skip "External link (skipped): $link"
            else
                check_external_url "$link" "$file"
            fi
        elif [[ "$link" =~ ^mailto: ]]; then
            # Email link - basic validation
            local email=$(echo "$link" | sed 's/mailto://')
            if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                success "Email link: $link"
            else
                fail "Invalid email link: $link (in $file)"
            fi
        elif [[ "$link" =~ ^# ]]; then
            # Anchor link - check if anchor exists in same file
            local anchor=$(echo "$link" | sed 's/^#//')
            if grep -q "^#.*$anchor" "$file" || grep -q "id=\"$anchor\"" "$file"; then
                success "Anchor link: $link"
            else
                fail "Anchor link: $link → anchor not found (in $file)"
            fi
        else
            # Internal file link
            check_internal_link "$link" "$file"
        fi
    done
    
    log "Found $file_link_count links in $filename"
}

# Generate detailed report
generate_report() {
    echo
    log "=== LINK CHECKER REPORT ==="
    echo
    
    # Summary statistics
    echo -e "${BLUE}Link Statistics:${NC}"
    echo -e "  Total Links Checked: $LINKS_CHECKED"
    echo -e "  ${GREEN}Valid Links: $LINKS_VALID${NC}"
    echo -e "  ${RED}Broken Links: $LINKS_BROKEN${NC}"
    echo -e "  ${YELLOW}Skipped Links: $LINKS_SKIPPED${NC}"
    echo
    
    # Calculate success rate
    if [[ $LINKS_CHECKED -gt 0 ]]; then
        local success_rate=$((LINKS_VALID * 100 / LINKS_CHECKED))
        echo -e "${BLUE}Success Rate: ${success_rate}%${NC}"
        echo
    fi
    
    # List broken links if any
    if [[ ${#BROKEN_LINKS[@]} -gt 0 ]]; then
        echo -e "${RED}Broken Links Found:${NC}"
        for link in "${BROKEN_LINKS[@]}"; do
            echo -e "  ${RED}✗${NC} $link"
        done
        echo
    fi
    
    # Show cache statistics
    if [[ -f "$CACHE_FILE" ]]; then
        local cache_size=$(wc -l < "$CACHE_FILE")
        echo -e "${BLUE}Cache Statistics:${NC}"
        echo -e "  Cache File: $CACHE_FILE"
        echo -e "  Cached URLs: $cache_size"
        echo
    fi
    
    # Performance metrics
    echo -e "${BLUE}Performance:${NC}"
    echo -e "  Check Duration: ${SECONDS}s"
    if [[ $LINKS_CHECKED -gt 0 ]]; then
        local avg_time=$((SECONDS * 1000 / LINKS_CHECKED))
        echo -e "  Average per Link: ${avg_time}ms"
    fi
    echo
    
    # Return appropriate exit code
    if [[ $LINKS_BROKEN -gt 0 ]]; then
        echo -e "${RED}❌ Link validation failed with $LINKS_BROKEN broken links${NC}"
        return 1
    else
        echo -e "${GREEN}✅ All $LINKS_VALID links are valid${NC}"
        return 0
    fi
}

# Main execution
main() {
    echo -e "${BLUE}🔗 Simone Link Checker${NC}"
    echo -e "${BLUE}=====================${NC}"
    echo
    
    # Verify environment
    check_project_root
    init_cache
    
    # Find all markdown files
    local md_files
    mapfile -t md_files < <(find "$DOCS_DIR" -name "*.md" -type f | sort)
    
    if [[ ${#md_files[@]} -eq 0 ]]; then
        warn "No markdown files found in $DOCS_DIR"
        exit 0
    fi
    
    log "Found ${#md_files[@]} markdown files to check"
    echo
    
    # Check links in each file
    for file in "${md_files[@]}"; do
        check_file_links "$file"
    done
    
    # Generate final report
    generate_report
}

# Handle command line arguments
SKIP_EXTERNAL="false"

case "${1:-}" in
    --help|-h)
        echo "Simone Link Checker"
        echo
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --help, -h          Show this help message"
        echo "  --skip-external     Skip checking external URLs"
        echo "  --clear-cache       Clear the link cache before checking"
        echo "  --cache-only        Show cache statistics and exit"
        echo "  --timeout <seconds> Set timeout for external URLs (default: $TIMEOUT)"
        echo
        echo "Environment Variables:"
        echo "  DOCS_DIR           Directory to check (default: docs)"
        echo "  TIMEOUT            Timeout for external URLs (default: $TIMEOUT)"
        echo
        echo "Examples:"
        echo "  $0                      # Check all links"
        echo "  $0 --skip-external     # Check only internal links"
        echo "  $0 --timeout 30        # Use 30 second timeout"
        echo
        echo "Cache:"
        echo "  External URLs are cached for 1 hour to improve performance."
        echo "  Use --clear-cache to force re-checking all external URLs."
        exit 0
        ;;
    --skip-external)
        SKIP_EXTERNAL="true"
        log "Skipping external URL checks"
        ;;
    --clear-cache)
        if [[ -f "$CACHE_FILE" ]]; then
            rm "$CACHE_FILE"
            log "Link cache cleared"
        fi
        ;;
    --cache-only)
        if [[ -f "$CACHE_FILE" ]]; then
            local cache_size=$(wc -l < "$CACHE_FILE")
            echo "Link Cache Statistics:"
            echo "  File: $CACHE_FILE"
            echo "  Entries: $cache_size"
            echo "  Size: $(du -h "$CACHE_FILE" | cut -f1)"
            echo
            echo "Recent entries:"
            tail -10 "$CACHE_FILE" | while IFS='|' read -r url timestamp status; do
                local date_str=$(date -d "@$timestamp" 2>/dev/null || date -r "$timestamp" 2>/dev/null || echo "unknown")
                echo "  $status: $url ($date_str)"
            done
        else
            echo "No link cache found at $CACHE_FILE"
        fi
        exit 0
        ;;
    --timeout)
        if [[ -n "${2:-}" && "$2" =~ ^[0-9]+$ ]]; then
            TIMEOUT="$2"
            log "Using timeout: ${TIMEOUT}s"
            shift
        else
            echo "Error: --timeout requires a numeric value"
            exit 1
        fi
        ;;
    "")
        # No arguments - run normally
        ;;
    *)
        echo "Unknown option: $1. Use --help for usage information."
        exit 1
        ;;
esac

# Check for required tools
if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}[ERROR]${NC} curl is required but not installed"
    exit 1
fi

# Run main function
main