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

# NEW: Auto-detect and resolve port conflicts
detect_port_conflicts() {
    local ports=(9000 8080 8081 8082 8083 8084)
    local conflicts=()
    
    log "Checking for port conflicts..."
    
    for port in "${ports[@]}"; do
        if netstat -tlpn 2>/dev/null | grep -q ":$port "; then
            conflicts+=($port)
            warn "Port $port is already in use"
        fi
    done
    
    if [[ ${#conflicts[@]} -gt 0 ]]; then
        warn "Found port conflicts: ${conflicts[*]}"
        echo
        echo "Options:"
        echo "1. Auto-find alternative ports"
        echo "2. Stop conflicting services"
        echo "3. Exit and resolve manually"
        read -p "Choose option (1-3): " -r choice
        
        case $choice in
            1)
                auto_assign_ports "${conflicts[@]}"
                ;;
            2)
                stop_conflicting_services "${conflicts[@]}"
                ;;
            3)
                error "Please resolve port conflicts manually and retry"
                exit 1
                ;;
        esac
    else
        log "No port conflicts detected"
    fi
}

# Auto-assign alternative ports
auto_assign_ports() {
    local conflicts=("$@")
    local port_map=""
    
    log "Auto-assigning alternative ports..."
    
    for port in "${conflicts[@]}"; do
        local new_port=$((port + 1000))
        while netstat -tlpn 2>/dev/null | grep -q ":$new_port "; do
            new_port=$((new_port + 1))
        done
        port_map+="$port->$new_port "
        log "Reassigning port $port to $new_port"
    done
    
    # Update docker-compose file with new ports
    if [[ -n "$port_map" ]]; then
        log "Updating docker-compose configuration..."
        # This would update the compose file with new ports
        warn "Manual port configuration required in docker-compose.mcp.yml"
        warn "Port mappings needed: $port_map"
    fi
}

# Stop conflicting services
stop_conflicting_services() {
    local conflicts=("$@")
    
    for port in "${conflicts[@]}"; do
        local pid=$(netstat -tlpn 2>/dev/null | grep ":$port " | awk '{print $7}' | cut -d'/' -f1)
        if [[ -n "$pid" && "$pid" != "-" ]]; then
            echo "Stop service on port $port (PID: $pid)? [y/N]"
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]]; then
                kill "$pid" 2>/dev/null && log "Stopped service on port $port" || warn "Failed to stop service on port $port"
            fi
        fi
    done
}

# Check if Docker and Docker Compose are installed with auto-fixes
check_dependencies() {
    log "Checking dependencies..."
    
    # Check Docker
    if ! command -v docker >/dev/null 2>&1; then
        error "Docker is not installed."
        echo
        echo "🔧 Auto-fix options:"
        echo "1. Install Docker automatically (requires sudo)"
        echo "2. Show manual installation instructions"
        echo "3. Exit"
        read -p "Choose option (1-3): " -r choice
        
        case $choice in
            1)
                install_docker_auto
                ;;
            2)
                show_docker_install_instructions
                exit 1
                ;;
            3)
                exit 1
                ;;
        esac
    fi
    
    # Check Docker daemon
    if ! docker ps >/dev/null 2>&1; then
        error "Docker daemon is not running."
        echo
        echo "🔧 Auto-fix options:"
        echo "1. Start Docker automatically"
        echo "2. Show manual start instructions"
        read -p "Choose option (1-2): " -r choice
        
        case $choice in
            1)
                start_docker_daemon
                ;;
            2)
                show_docker_start_instructions
                exit 1
                ;;
        esac
    fi
    
    # Check Docker Compose
    if ! command -v docker-compose >/dev/null 2>&1 && ! docker compose version >/dev/null 2>&1; then
        error "Docker Compose is not installed."
        echo
        echo "🔧 Auto-fix: Installing Docker Compose plugin..."
        install_docker_compose
    fi
    
    log "Dependencies check passed"
}

# Auto-install Docker (Linux only)
install_docker_auto() {
    log "Attempting to install Docker automatically..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker "$USER"
        log "Docker installed. Please log out and back in, then rerun this script."
        exit 0
    else
        error "Automatic Docker installation only supported on Linux"
        show_docker_install_instructions
        exit 1
    fi
}

# Show Docker installation instructions
show_docker_install_instructions() {
    echo
    echo "📖 Manual Docker Installation:"
    echo "Linux:   curl -fsSL https://get.docker.com | sh"
    echo "macOS:   brew install --cask docker"
    echo "Windows: Download from https://docker.com/products/docker-desktop"
}

# Start Docker daemon
start_docker_daemon() {
    log "Attempting to start Docker daemon..."
    
    if command -v systemctl >/dev/null 2>&1; then
        sudo systemctl start docker
        sudo systemctl enable docker
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open -a Docker
        log "Docker Desktop starting... Please wait for it to fully start."
        sleep 10
    else
        error "Please start Docker manually for your system"
        exit 1
    fi
}

# Show Docker start instructions
show_docker_start_instructions() {
    echo
    echo "📖 Manual Docker Start:"
    echo "Linux:   sudo systemctl start docker"
    echo "macOS:   Open Docker Desktop application"
    echo "Windows: Start Docker Desktop"
}

# Install Docker Compose
install_docker_compose() {
    if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
        log "Docker Compose (plugin) is already available"
        return
    fi
    
    log "Installing Docker Compose..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    else
        error "Please install Docker Compose manually for your system"
        exit 1
    fi
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