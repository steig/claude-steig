# Simone Framework Makefile
# Provides convenient shortcuts for common Docker and development tasks

.PHONY: help docker-setup docker-start docker-stop docker-status docker-health docker-logs docker-clean multi-setup multi-start multi-stop multi-status validate test docs

# Default target
help:
	@echo "Simone Framework - Available Commands:"
	@echo ""
	@echo "Single Project Docker Commands:"
	@echo "  docker-setup    Setup and configure Docker MCP environment"
	@echo "  docker-start    Start all MCP services"
	@echo "  docker-stop     Stop all MCP services"
	@echo "  docker-restart  Restart all MCP services"
	@echo "  docker-status   Show service status"
	@echo "  docker-health   Check health of all services"
	@echo "  docker-logs     Show logs for all services"
	@echo "  docker-clean    Clean up containers and volumes"
	@echo ""
	@echo "Multi-Project Docker Commands:"
	@echo "  multi-setup-1   Setup project 1 in current directory"
	@echo "  multi-setup-2   Setup project 2 in current directory"
	@echo "  multi-setup-3   Setup project 3 in current directory"
	@echo "  multi-start-1   Start project 1"
	@echo "  multi-start-2   Start project 2"
	@echo "  multi-start-3   Start project 3"
	@echo "  multi-status    Show status of all projects"
	@echo "  multi-stop-all  Stop all multi-projects"
	@echo ""
	@echo "Development Commands:"
	@echo "  test           Run tests"
	@echo "  docs           Generate documentation"
	@echo "  install        Install/upgrade Simone framework"
	@echo ""
	@echo "Examples:"
	@echo "  make docker-setup     # Single project setup"
	@echo "  make multi-setup-1    # Setup project 1"
	@echo "  make multi-start-1    # Start project 1"
	@echo "  make multi-status     # Check all projects"

# Docker MCP Commands
docker-setup:
	@echo "Setting up Docker MCP environment..."
	./scripts/mcp-docker.sh setup

docker-start:
	@echo "Starting MCP services..."
	./scripts/mcp-docker.sh start

docker-stop:
	@echo "Stopping MCP services..."
	./scripts/mcp-docker.sh stop

docker-restart:
	@echo "Restarting MCP services..."
	./scripts/mcp-docker.sh restart

docker-status:
	@echo "Checking MCP service status..."
	./scripts/mcp-docker.sh status

docker-health:
	@echo "Performing health check..."
	./scripts/mcp-docker.sh health

docker-logs:
	@echo "Showing service logs..."
	./scripts/mcp-docker.sh logs

docker-clean:
	@echo "Cleaning up Docker resources..."
	./scripts/mcp-docker.sh cleanup

# Development Commands
validate:
	@echo "Validating Docker setup..."
	./scripts/validate-docker-setup.sh

test:
	@echo "Running tests..."
	@if [ -f "tests/run-performance-tests.sh" ]; then \
		./tests/run-performance-tests.sh quick; \
	else \
		echo "No tests found - test suite not yet available"; \
	fi

docs:
	@echo "Documentation available:"
	@echo "  README.md - Main documentation"
	@echo "  docs/infrastructure/docker-mcp-setup.md - Docker setup guide"
	@echo "  docker/README.md - Docker infrastructure details"
	@echo "  CHANGELOG.md - Version history"

install:
	@echo "Installing/upgrading Simone framework..."
	./install-simone.sh

# Quick status check
status: docker-status docker-health

# Full setup workflow
setup: validate docker-setup docker-health
	@echo ""
	@echo "✅ Simone Docker MCP setup complete!"
	@echo "   Gateway: http://localhost:9000"
	@echo "   Status:  make docker-status"
	@echo "   Health:  make docker-health"

# Development workflow
dev: validate docker-start
	@echo ""
	@echo "🚀 Development environment ready!"
	@echo "   Services: make docker-status"
	@echo "   Logs:     make docker-logs"