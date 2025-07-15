#!/bin/bash

# Multi-Project MCP Docker Manager
# Allows running multiple Simone projects simultaneously with isolated MCP containers

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
highlight() { echo -e "${CYAN}[HIGHLIGHT]${NC} $1"; }

# Project configuration
declare -A PROJECT_CONFIGS
PROJECT_CONFIGS[1]="9000:8080:8081:8082:8083:8084:172.20.0.0/16"
PROJECT_CONFIGS[2]="9010:8090:8091:8092:8093:8094:172.21.0.0/16"
PROJECT_CONFIGS[3]="9020:8100:8101:8102:8103:8104:172.22.0.0/16"

# Parse project configuration
get_project_config() {
    local project_num="$1"
    local config="${PROJECT_CONFIGS[$project_num]}"
    
    if [ -z "$config" ]; then
        error "Invalid project number: $project_num (must be 1, 2, or 3)"
        return 1
    fi
    
    echo "$config"
}

# Get specific port from project config
get_project_port() {
    local project_num="$1"
    local service="$2"
    local config="$(get_project_config "$project_num")"
    
    case "$service" in
        "gateway") echo "$(echo "$config" | cut -d: -f1)" ;;
        "serena") echo "$(echo "$config" | cut -d: -f2)" ;;
        "context7") echo "$(echo "$config" | cut -d: -f3)" ;;
        "playwright") echo "$(echo "$config" | cut -d: -f4)" ;;
        "work-history") echo "$(echo "$config" | cut -d: -f5)" ;;
        "sequential-thinking") echo "$(echo "$config" | cut -d: -f6)" ;;
        "subnet") echo "$(echo "$config" | cut -d: -f7)" ;;
        *) error "Unknown service: $service"; return 1 ;;
    esac
}

# Generate environment file for project
generate_project_env() {
    local project_num="$1"
    local project_path="$2"
    
    if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
        error "Project must be 1, 2, or 3"
        return 1
    fi
    
    if [ -z "$project_path" ]; then
        project_path="$(pwd)"
    fi
    
    # Resolve absolute path
    project_path="$(cd "$project_path" && pwd)"
    
    local env_file="$project_path/.env.mcp.project$project_num"
    
    cat > "$env_file" <<EOF
# MCP Environment for Project $project_num
# Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)
# Project Path: $project_path

# Project identification
PROJECT_NUM=$project_num
PROJECT_PATH=$project_path
PROJECT_ID=project$project_num

# Port allocation
GATEWAY_PORT=$(get_project_port "$project_num" "gateway")
SERENA_PORT=$(get_project_port "$project_num" "serena")
CONTEXT7_PORT=$(get_project_port "$project_num" "context7")
PLAYWRIGHT_PORT=$(get_project_port "$project_num" "playwright")
WORK_HISTORY_PORT=$(get_project_port "$project_num" "work-history")
SEQUENTIAL_THINKING_PORT=$(get_project_port "$project_num" "sequential-thinking")

# Network configuration
NETWORK_SUBNET=$(get_project_port "$project_num" "subnet")

# Service URLs (internal Docker network)
SERENA_URL=http://serena:8080
CONTEXT7_URL=http://context7:8081
PLAYWRIGHT_URL=http://playwright:8082
WORK_HISTORY_URL=http://work-history:8083
SEQUENTIAL_THINKING_URL=http://sequential-thinking:8084

# Optional configuration
HISTORY_RETENTION_DAYS=30
THINKING_MODE=structured
DISPLAY=:99
RESOLUTION=1920x1080x24

# Development/debug
DEBUG=false
LOG_LEVEL=info
RESTART_POLICY=unless-stopped
EOF

    log "Generated environment file: $env_file"
    return 0
}

# Setup project in directory
setup_project() {
    local project_num="$1"
    local target_dir="${2:-$(pwd)}"
    
    if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
        error "Project must be 1, 2, or 3"
        show_help
        return 1
    fi
    
    if [ ! -d "$target_dir" ]; then
        error "Directory does not exist: $target_dir"
        return 1
    fi
    
    # Check if directory has Simone structure
    if [ ! -d "$target_dir/.simone" ]; then
        warn "Directory does not appear to be a Simone project (no .simone folder)"
        echo "Continue anyway? [y/N]"
        read -r response
        if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            log "Setup cancelled"
            return 0
        fi
    fi
    
    # Generate project environment
    generate_project_env "$project_num" "$target_dir"
    
    local gateway_port="$(get_project_port "$project_num" "gateway")"
    
    log "Project $project_num setup completed in: $target_dir"
    log "  Environment: $target_dir/.env.mcp.project$project_num"
    log "  Gateway (when started): http://localhost:$gateway_port"
    log ""
    log "Next steps:"
    log "  cd $target_dir"
    log "  $0 start $project_num"
}

# Start project services
start_project() {
    local project_num="$1"
    local project_path="${2:-$(pwd)}"
    
    if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
        error "Project must be 1, 2, or 3"
        return 1
    fi
    
    project_path="$(cd "$project_path" && pwd)"
    local env_file="$project_path/.env.mcp.project$project_num"
    
    if [ ! -f "$env_file" ]; then
        error "Project $project_num not set up in $project_path"
        log "Run: $0 setup $project_num $project_path"
        return 1
    fi
    
    # Check if project is already running
    local gateway_port="$(get_project_port "$project_num" "gateway")"
    if curl -f -s "http://localhost:$gateway_port/health" >/dev/null 2>&1; then
        warn "Project $project_num appears to already be running (port $gateway_port responding)"
        echo "Restart? [y/N]"
        read -r response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            stop_project "$project_num" "$project_path"
        else
            log "Start cancelled"
            return 0
        fi
    fi
    
    log "Starting MCP services for project $project_num..."
    log "  Project path: $project_path"
    log "  Environment: $env_file"
    
    cd "$PROJECT_ROOT"
    
    # Use project-specific compose with project environment
    if command -v docker-compose >/dev/null 2>&1; then
        docker-compose -f docker-compose.mcp-multi.yml --env-file "$env_file" up -d
    else
        docker compose -f docker-compose.mcp-multi.yml --env-file "$env_file" up -d
    fi
    
    # Wait a moment for services to start
    sleep 3
    
    # Verify services started
    if curl -f -s "http://localhost:$gateway_port/health" >/dev/null 2>&1; then
        log "✅ Project $project_num services started successfully"
        show_project_info "$project_num"
    else
        error "❌ Project $project_num services failed to start"
        log "Check logs: $0 logs $project_num"
        return 1
    fi
}

# Stop project services
stop_project() {
    local project_num="$1"
    local project_path="${2:-$(pwd)}"
    
    if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
        error "Project must be 1, 2, or 3"
        return 1
    fi
    
    project_path="$(cd "$project_path" && pwd)"
    local env_file="$project_path/.env.mcp.project$project_num"
    
    if [ ! -f "$env_file" ]; then
        warn "Project $project_num environment file not found: $env_file"
        warn "Services may still be running - check: $0 status"
        return 1
    fi
    
    log "Stopping MCP services for project $project_num..."
    
    cd "$PROJECT_ROOT"
    
    if command -v docker-compose >/dev/null 2>&1; then
        docker-compose -f docker-compose.mcp-multi.yml --env-file "$env_file" down
    else
        docker compose -f docker-compose.mcp-multi.yml --env-file "$env_file" down
    fi
    
    log "✅ Project $project_num services stopped"
}

# Show project information
show_project_info() {
    local project_num="$1"
    
    local gateway_port="$(get_project_port "$project_num" "gateway")"
    local serena_port="$(get_project_port "$project_num" "serena")"
    local context7_port="$(get_project_port "$project_num" "context7")"
    local playwright_port="$(get_project_port "$project_num" "playwright")"
    local work_history_port="$(get_project_port "$project_num" "work-history")"
    local seq_thinking_port="$(get_project_port "$project_num" "sequential-thinking")"
    
    echo ""
    highlight "🚀 Project $project_num Access Information:"
    echo ""
    echo "  🌐 Gateway (main):       http://localhost:$gateway_port"
    echo "  🔧 Serena:              http://localhost:$serena_port"
    echo "  🧠 Context7:            http://localhost:$context7_port"
    echo "  🎭 Playwright:          http://localhost:$playwright_port"
    echo "  📚 Work History:        http://localhost:$work_history_port"
    echo "  🤔 Sequential Thinking: http://localhost:$seq_thinking_port"
    echo ""
    echo "  📊 Health Check:        curl http://localhost:$gateway_port/health"
    echo "  📋 Service Status:      curl http://localhost:$gateway_port/status"
    echo ""
}

# Show status of specific project or all projects
show_status() {
    local project_num="$1"
    
    if [ -n "$project_num" ]; then
        # Show specific project
        if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
            error "Project must be 1, 2, or 3"
            return 1
        fi
        show_single_status "$project_num"
    else
        # Show all projects
        log "Multi-Project MCP Status:"
        echo ""
        for i in 1 2 3; do
            show_single_status "$i"
            echo ""
        done
    fi
}

# Show status of single project
show_single_status() {
    local project_num="$1"
    local gateway_port="$(get_project_port "$project_num" "gateway")"
    
    echo -n "  Project $project_num: "
    
    if curl -f -s "http://localhost:$gateway_port/health" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ RUNNING${NC}"
        echo "    Gateway: http://localhost:$gateway_port"
        
        # Try to get service status
        local status_json="$(curl -s "http://localhost:$gateway_port/status" 2>/dev/null || echo '{}')"
        if echo "$status_json" | jq -e . >/dev/null 2>&1; then
            local healthy_services="$(echo "$status_json" | jq -r '.services // {} | to_entries[] | select(.value.status == "healthy") | .key' 2>/dev/null | wc -l)"
            echo "    Services: $healthy_services/5 healthy"
        fi
    else
        echo -e "${RED}❌ STOPPED${NC}"
        echo "    Gateway: http://localhost:$gateway_port (not responding)"
    fi
}

# Show logs for project
show_logs() {
    local project_num="$1"
    local service="$2"
    local project_path="${3:-$(pwd)}"
    
    if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
        error "Project must be 1, 2, or 3"
        return 1
    fi
    
    project_path="$(cd "$project_path" && pwd)"
    local env_file="$project_path/.env.mcp.project$project_num"
    
    if [ ! -f "$env_file" ]; then
        error "Project $project_num environment file not found: $env_file"
        return 1
    fi
    
    log "Showing logs for project $project_num..."
    if [ -n "$service" ]; then
        log "Service: $service"
    fi
    
    cd "$PROJECT_ROOT"
    
    if [ -n "$service" ]; then
        if command -v docker-compose >/dev/null 2>&1; then
            docker-compose -f docker-compose.mcp-multi.yml --env-file "$env_file" logs -f "$service"
        else
            docker compose -f docker-compose.mcp-multi.yml --env-file "$env_file" logs -f "$service"
        fi
    else
        if command -v docker-compose >/dev/null 2>&1; then
            docker-compose -f docker-compose.mcp-multi.yml --env-file "$env_file" logs -f
        else
            docker compose -f docker-compose.mcp-multi.yml --env-file "$env_file" logs -f
        fi
    fi
}

# Clean up project (remove containers and volumes)
cleanup_project() {
    local project_num="$1"
    local project_path="${2:-$(pwd)}"
    
    if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
        error "Project must be 1, 2, or 3"
        return 1
    fi
    
    warn "⚠️  This will remove ALL containers and data volumes for project $project_num"
    warn "    All project data will be permanently lost!"
    echo ""
    echo "Type 'delete project $project_num' to confirm:"
    read -r confirmation
    
    if [ "$confirmation" != "delete project $project_num" ]; then
        log "Cleanup cancelled"
        return 0
    fi
    
    project_path="$(cd "$project_path" && pwd)"
    local env_file="$project_path/.env.mcp.project$project_num"
    
    if [ ! -f "$env_file" ]; then
        warn "Project $project_num environment file not found: $env_file"
        warn "Attempting cleanup anyway..."
    fi
    
    log "Cleaning up project $project_num..."
    
    cd "$PROJECT_ROOT"
    
    if [ -f "$env_file" ]; then
        if command -v docker-compose >/dev/null 2>&1; then
            docker-compose -f docker-compose.mcp-multi.yml --env-file "$env_file" down -v --remove-orphans
        else
            docker compose -f docker-compose.mcp-multi.yml --env-file "$env_file" down -v --remove-orphans
        fi
        
        # Remove environment file
        rm -f "$env_file"
        log "Removed environment file: $env_file"
    fi
    
    log "✅ Project $project_num cleanup completed"
}

# Health check for project
health_check() {
    local project_num="$1"
    
    if [[ ! "$project_num" =~ ^[1-3]$ ]]; then
        error "Project must be 1, 2, or 3"
        return 1
    fi
    
    local gateway_port="$(get_project_port "$project_num" "gateway")"
    
    log "Performing health check for project $project_num..."
    
    if ! curl -f -s "http://localhost:$gateway_port/health" >/dev/null 2>&1; then
        error "❌ Project $project_num gateway not responding"
        return 1
    fi
    
    # Get detailed status
    local status_json="$(curl -s "http://localhost:$gateway_port/status" 2>/dev/null)"
    
    if echo "$status_json" | jq -e . >/dev/null 2>&1; then
        log "✅ Project $project_num gateway is healthy"
        echo ""
        echo "Service Status:"
        echo "$status_json" | jq -r '.services // {} | to_entries[] | "  \(.key): \(.value.status // "unknown")"' 2>/dev/null || echo "  Unable to parse service status"
    else
        warn "⚠️  Gateway responding but status endpoint returned invalid JSON"
    fi
}

# Show comprehensive help
show_help() {
    cat << 'EOF'
Multi-Project MCP Docker Manager

OVERVIEW:
  Manages multiple Simone projects simultaneously with isolated Docker MCP containers.
  Each project gets its own ports, networks, and data volumes for complete isolation.

USAGE:
  ./scripts/mcp-multi.sh <command> <project_number> [options]

PROJECT NUMBERS:
  1, 2, 3  - Each project gets isolated ports and data

PORT ASSIGNMENTS:
  Project 1: Gateway 9000, Services 8080-8084, Network 172.20.0.0/16
  Project 2: Gateway 9010, Services 8090-8094, Network 172.21.0.0/16  
  Project 3: Gateway 9020, Services 8100-8104, Network 172.22.0.0/16

COMMANDS:

Setup and Management:
  setup <1-3> [path]     Setup project in directory (default: current)
  start <1-3> [path]     Start MCP services for project
  stop <1-3> [path]      Stop MCP services for project
  restart <1-3> [path]   Restart MCP services for project

Monitoring:
  status [1-3]           Show status (all projects if no number)
  health <1-3>           Detailed health check for project
  logs <1-3> [service]   Show logs (optionally for specific service)

Maintenance:
  cleanup <1-3> [path]   Remove containers and volumes (DESTRUCTIVE)
  help                   Show this help message

EXAMPLES:

  # Setup and start project 1 in current directory
  ./scripts/mcp-multi.sh setup 1
  ./scripts/mcp-multi.sh start 1

  # Setup project 2 in specific directory
  ./scripts/mcp-multi.sh setup 2 /path/to/my-project

  # Start project 2 from that directory
  cd /path/to/my-project
  ./scripts/mcp-multi.sh start 2

  # Check status of all projects
  ./scripts/mcp-multi.sh status

  # Check health of project 1
  ./scripts/mcp-multi.sh health 1

  # View logs for project 3, serena service only
  ./scripts/mcp-multi.sh logs 3 serena

WORKFLOW:

  1. Setup each project in its directory:
     cd /path/to/project1 && ./scripts/mcp-multi.sh setup 1
     cd /path/to/project2 && ./scripts/mcp-multi.sh setup 2

  2. Start projects (can run simultaneously):
     ./scripts/mcp-multi.sh start 1 /path/to/project1
     ./scripts/mcp-multi.sh start 2 /path/to/project2

  3. Access projects via different gateways:
     Project 1: http://localhost:9000
     Project 2: http://localhost:9010

  4. Configure Claude Code with project-specific endpoints:
     claude mcp add project1 -- http://localhost:9000
     claude mcp add project2 -- http://localhost:9010

NOTES:
  - Each project is completely isolated (ports, data, networks)
  - Projects can run simultaneously without conflicts
  - Data is persistent in Docker volumes
  - Environment files (.env.mcp.project<N>) store project configuration

EOF
}

# Main command processing
main() {
    local command="${1:-help}"
    local project_num="$2"
    local arg3="$3"
    
    case "$command" in
        "setup")
            if [ -z "$project_num" ]; then
                error "Usage: $0 setup <1-3> [directory]"
                return 1
            fi
            setup_project "$project_num" "$arg3"
            ;;
        "start")
            if [ -z "$project_num" ]; then
                error "Usage: $0 start <1-3> [directory]"
                return 1
            fi
            start_project "$project_num" "$arg3"
            ;;
        "stop")
            if [ -z "$project_num" ]; then
                error "Usage: $0 stop <1-3> [directory]"
                return 1
            fi
            stop_project "$project_num" "$arg3"
            ;;
        "restart")
            if [ -z "$project_num" ]; then
                error "Usage: $0 restart <1-3> [directory]"
                return 1
            fi
            stop_project "$project_num" "$arg3"
            sleep 2
            start_project "$project_num" "$arg3"
            ;;
        "status")
            show_status "$project_num"
            ;;
        "health")
            if [ -z "$project_num" ]; then
                error "Usage: $0 health <1-3>"
                return 1
            fi
            health_check "$project_num"
            ;;
        "logs")
            if [ -z "$project_num" ]; then
                error "Usage: $0 logs <1-3> [service] [directory]"
                return 1
            fi
            show_logs "$project_num" "$arg3" "$4"
            ;;
        "cleanup")
            if [ -z "$project_num" ]; then
                error "Usage: $0 cleanup <1-3> [directory]"
                return 1
            fi
            cleanup_project "$project_num" "$arg3"
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            error "Unknown command: $command"
            echo ""
            echo "Run '$0 help' for usage information"
            return 1
            ;;
    esac
}

# Check dependencies
check_dependencies() {
    if ! command -v docker >/dev/null 2>&1; then
        error "Docker is required but not installed"
        return 1
    fi
    
    if ! command -v jq >/dev/null 2>&1; then
        warn "jq is recommended for better status parsing"
    fi
    
    if ! docker info >/dev/null 2>&1; then
        error "Docker daemon is not running"
        return 1
    fi
}

# Run dependency check and main function
check_dependencies && main "$@"