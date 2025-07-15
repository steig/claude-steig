#!/bin/bash

# MCP Docker Management Script
# Manages Docker-based MCP server deployment for Simone Framework

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
COMPOSE_FILE="$PROJECT_ROOT/docker-compose.mcp.yml"
ENV_FILE="$PROJECT_ROOT/.env.mcp"
ENV_EXAMPLE="$PROJECT_ROOT/.env.mcp.example"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Check if Docker and Docker Compose are installed
check_dependencies() {
    log "Checking dependencies..."
    
    if ! command -v docker >/dev/null 2>&1; then
        error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose >/dev/null 2>&1 && ! docker compose version >/dev/null 2>&1; then
        error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    log "Dependencies check passed"
}

# Setup environment configuration
setup_environment() {
    log "Setting up environment configuration..."
    
    if [ ! -f "$ENV_FILE" ]; then
        if [ -f "$ENV_EXAMPLE" ]; then
            cp "$ENV_EXAMPLE" "$ENV_FILE"
            log "Created .env.mcp from example file"
            warn "Please review and update .env.mcp with your configuration"
        else
            error "Environment example file not found: $ENV_EXAMPLE"
            exit 1
        fi
    else
        log "Environment file already exists: $ENV_FILE"
    fi
}

# Build all MCP containers
build_containers() {
    log "Building MCP containers..."
    
    cd "$PROJECT_ROOT"
    
    if command -v docker-compose >/dev/null 2>&1; then
        docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" build
    else
        docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" build
    fi
    
    log "Container build completed"
}

# Start MCP services
start_services() {
    log "Starting MCP services..."
    
    cd "$PROJECT_ROOT"
    
    if command -v docker-compose >/dev/null 2>&1; then
        docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d
    else
        docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d
    fi
    
    log "MCP services started"
    show_status
}

# Stop MCP services
stop_services() {
    log "Stopping MCP services..."
    
    cd "$PROJECT_ROOT"
    
    if command -v docker-compose >/dev/null 2>&1; then
        docker-compose -f "$COMPOSE_FILE" stop
    else
        docker compose -f "$COMPOSE_FILE" stop
    fi
    
    log "MCP services stopped"
}

# Restart MCP services
restart_services() {
    log "Restarting MCP services..."
    stop_services
    start_services
}

# Show service status
show_status() {
    log "MCP Service Status:"
    
    cd "$PROJECT_ROOT"
    
    if command -v docker-compose >/dev/null 2>&1; then
        docker-compose -f "$COMPOSE_FILE" ps
    else
        docker compose -f "$COMPOSE_FILE" ps
    fi
    
    echo
    info "Gateway URL: http://localhost:9000"
    info "Service Status: http://localhost:9000/status"
    echo
    info "Individual Services:"
    info "  Serena:              http://localhost:8080"
    info "  Context7:            http://localhost:8081"
    info "  Playwright:          http://localhost:8082"
    info "  Work History:        http://localhost:8083"
    info "  Sequential Thinking: http://localhost:8084"
}

# Show service logs
show_logs() {
    local service="$1"
    
    cd "$PROJECT_ROOT"
    
    if [ -n "$service" ]; then
        log "Showing logs for service: $service"
        if command -v docker-compose >/dev/null 2>&1; then
            docker-compose -f "$COMPOSE_FILE" logs -f "$service"
        else
            docker compose -f "$COMPOSE_FILE" logs -f "$service"
        fi
    else
        log "Showing logs for all services:"
        if command -v docker-compose >/dev/null 2>&1; then
            docker-compose -f "$COMPOSE_FILE" logs -f
        else
            docker compose -f "$COMPOSE_FILE" logs -f
        fi
    fi
}

# Health check for all services
health_check() {
    log "Performing health check on all MCP services..."
    
    local gateway_url="http://localhost:9000"
    local services=(
        "serena:8080"
        "context7:8081"
        "playwright:8082"
        "work-history:8083"
        "sequential-thinking:8084"
        "gateway:9000"
    )
    
    echo
    for service_info in "${services[@]}"; do
        local service_name="${service_info%%:*}"
        local service_port="${service_info##*:}"
        local service_url="http://localhost:$service_port"
        
        if curl -f -s "$service_url/health" >/dev/null 2>&1; then
            echo -e "${GREEN}✓${NC} $service_name ($service_url)"
        else
            echo -e "${RED}✗${NC} $service_name ($service_url)"
        fi
    done
    
    echo
    if curl -f -s "$gateway_url/status" >/dev/null 2>&1; then
        log "Gateway status endpoint accessible"
        info "Full status: curl $gateway_url/status"
    else
        warn "Gateway status endpoint not accessible"
    fi
}

# Clean up containers and volumes
cleanup() {
    warn "This will remove all MCP containers and volumes. Are you sure? [y/N]"
    read -r response
    
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        log "Cleaning up MCP containers and volumes..."
        
        cd "$PROJECT_ROOT"
        
        if command -v docker-compose >/dev/null 2>&1; then
            docker-compose -f "$COMPOSE_FILE" down -v --remove-orphans
        else
            docker compose -f "$COMPOSE_FILE" down -v --remove-orphans
        fi
        
        log "Cleanup completed"
    else
        log "Cleanup cancelled"
    fi
}

# Update Claude Code configuration for Docker MCP
update_claude_config() {
    log "Updating Claude Code configuration for Docker MCP..."
    
    # Note: This would need to be implemented based on how Claude Code
    # should connect to containerized MCP servers
    warn "Claude Code configuration update not yet implemented"
    warn "You may need to manually configure Claude Code to use:"
    warn "  Gateway: http://localhost:9000"
    warn "  Or individual services on their respective ports"
}

# Show help
show_help() {
    echo "MCP Docker Management Script"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  setup        Setup environment and prepare for first run"
    echo "  build        Build all MCP containers"
    echo "  start        Start all MCP services"
    echo "  stop         Stop all MCP services"
    echo "  restart      Restart all MCP services"
    echo "  status       Show service status"
    echo "  logs [svc]   Show logs (optionally for specific service)"
    echo "  health       Perform health check on all services"
    echo "  cleanup      Remove containers and volumes"
    echo "  config       Update Claude Code configuration"
    echo "  help         Show this help message"
    echo ""
    echo "Services: serena, context7, playwright, work-history, sequential-thinking, mcp-gateway"
    echo ""
    echo "Multi-Project Usage:"
    echo "  One set of containers serves all projects"
    echo "  MCP servers detect project context from working directory"
    echo "  Just 'cd' to different projects and use same gateway"
    echo ""
    echo "Examples:"
    echo "  $0 setup              # First-time setup"
    echo "  $0 start              # Start all services"
    echo "  $0 health             # Check all service health"
    echo "  cd /project1 && curl http://localhost:9000/health"
    echo "  cd /project2 && curl http://localhost:9000/health"
}

# Main command processing
main() {
    case "${1:-help}" in
        "setup")
            check_dependencies
            setup_environment
            build_containers
            log "Setup completed. Run '$0 start' to start services."
            ;;
        "build")
            check_dependencies
            build_containers
            ;;
        "start")
            check_dependencies
            setup_environment
            start_services
            ;;
        "stop")
            stop_services
            ;;
        "restart")
            restart_services
            ;;
        "status")
            show_status
            ;;
        "logs")
            show_logs "$2"
            ;;
        "health")
            health_check
            ;;
        "cleanup")
            cleanup
            ;;
        "config")
            update_claude_config
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            error "Unknown command: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"