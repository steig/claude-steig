# Docker MCP Infrastructure

This directory contains Docker configurations for running all MCP servers in isolated containers.

## Architecture

```
docker/
├── mcp-servers/              # Individual MCP server containers
│   ├── serena/              # IDE assistance and project management
│   ├── context7/            # Context management and retrieval  
│   ├── playwright/          # Browser automation and testing
│   ├── work-history/        # Command tracking and logging
│   └── sequential-thinking/ # Enhanced reasoning and problem-solving
├── mcp-gateway/             # Central proxy and load balancer
└── README.md               # This file
```

## Quick Start

```bash
# Validate setup
./scripts/validate-docker-setup.sh

# Setup and start all services
./scripts/mcp-docker.sh setup

# Check service health
./scripts/mcp-docker.sh health
```

## Service Details

### Serena (Port 8080)
- **Purpose**: Enhanced IDE assistance and project management
- **Base Image**: node:18-alpine
- **Features**: Project analysis, code assistance, Simone integration
- **Health Check**: `curl http://localhost:8080/health`

### Context7 (Port 8081) 
- **Purpose**: Advanced context management and retrieval
- **Base Image**: node:18-alpine
- **Features**: Session persistence, smart context preservation
- **Optional**: Redis integration for enhanced storage
- **Health Check**: `curl http://localhost:8081/health`

### Playwright (Port 8082)
- **Purpose**: Browser automation and testing
- **Base Image**: mcr.microsoft.com/playwright:v1.40.0-focal
- **Features**: Headless browsers, X11 forwarding, test automation
- **Requirements**: Additional capabilities for browser sandboxing
- **Health Check**: `curl http://localhost:8082/health`

### Work History (Port 8083)
- **Purpose**: Command tracking and output logging
- **Base Image**: node:18-alpine
- **Features**: Execution history, audit trail, log retention
- **Health Check**: `curl http://localhost:8083/health`

### Sequential Thinking (Port 8084)
- **Purpose**: Enhanced reasoning and problem-solving
- **Base Image**: node:18-alpine
- **Features**: Structured thinking, analytical modes
- **Health Check**: `curl http://localhost:8084/health`

### MCP Gateway (Port 9000)
- **Purpose**: Central proxy and load balancer
- **Base Image**: node:18-alpine
- **Features**: Service discovery, health monitoring, unified API
- **Health Check**: `curl http://localhost:9000/health`

## Environment Configuration

### Required Environment Variables

```bash
# Project integration
PROJECT_PATH=${PWD}

# Service URLs (internal Docker network)
SERENA_URL=http://serena:8080
CONTEXT7_URL=http://context7:8081
PLAYWRIGHT_URL=http://playwright:8082
WORK_HISTORY_URL=http://work-history:8083
SEQUENTIAL_THINKING_URL=http://sequential-thinking:8084
```

### Optional Configuration

```bash
# Context7 Redis (for persistent storage)
UPSTASH_REDIS_REST_URL=https://your-redis.upstash.io
UPSTASH_REDIS_REST_TOKEN=your-token

# Work History retention
HISTORY_RETENTION_DAYS=30

# Sequential Thinking mode
THINKING_MODE=structured

# Playwright display
DISPLAY=:99
RESOLUTION=1920x1080x24
```

## Data Persistence

### Docker Volumes

Each service uses named volumes for data persistence:

- `mcp-serena-data`: Project analysis cache, IDE state
- `mcp-context7-data`: Context storage, session data  
- `mcp-playwright-data`: Browser profiles, test artifacts
- `mcp-work-history-data`: Command logs, execution history
- `mcp-sequential-thinking-data`: Reasoning chains, analysis

### Backup and Restore

```bash
# Backup all volumes
for volume in $(docker volume ls -q | grep ^mcp-); do
    docker run --rm -v $volume:/data -v $(pwd):/backup alpine tar czf /backup/$volume.tar.gz -C /data .
done

# Restore specific volume
docker run --rm -v mcp-serena-data:/data -v $(pwd):/backup alpine tar xzf /backup/mcp-serena-data.tar.gz -C /data
```

## Development

### Building Images

```bash
# Build all images
docker compose -f ../docker-compose.mcp.yml build

# Build specific service
docker compose -f ../docker-compose.mcp.yml build serena

# Force rebuild (no cache)
docker compose -f ../docker-compose.mcp.yml build --no-cache
```

### Debugging

```bash
# View logs
docker compose -f ../docker-compose.mcp.yml logs -f serena

# Interactive shell
docker compose -f ../docker-compose.mcp.yml exec serena sh

# Health check
docker compose -f ../docker-compose.mcp.yml exec serena /app/healthcheck.sh
```

### Custom Builds

For development, you can override images:

```bash
# Use local Dockerfile
docker compose -f ../docker-compose.mcp.yml build serena

# Override with custom image
export SERENA_IMAGE=my-custom-serena:latest
docker compose -f ../docker-compose.mcp.yml up -d
```

## Security

### Network Isolation

- Services communicate on private `mcp-network` 
- Only gateway port (9000) exposed externally
- Internal service ports not accessible from host

### Container Security

- Non-root users where possible
- Read-only filesystem for applications
- Minimal base images (Alpine Linux)
- Regular security updates

### Production Deployment

For production environments:

```yaml
# Use Docker secrets
secrets:
  redis_token:
    external: true

services:
  context7:
    secrets:
      - redis_token
    environment:
      UPSTASH_REDIS_REST_TOKEN_FILE: /run/secrets/redis_token
```

## Troubleshooting

### Common Issues

**Services won't start**
```bash
# Check Docker daemon
docker info

# Check port conflicts
netstat -tlnp | grep -E '(8080|8081|8082|8083|8084|9000)'

# Check logs
./scripts/mcp-docker.sh logs
```

**Gateway can't reach services**
```bash
# Test internal network
docker compose -f ../docker-compose.mcp.yml exec mcp-gateway ping serena

# Check service health
docker compose -f ../docker-compose.mcp.yml exec serena /app/healthcheck.sh
```

**Browser automation fails**
```bash
# Check X11 forwarding
docker compose -f ../docker-compose.mcp.yml exec playwright echo $DISPLAY

# Test browser installation
docker compose -f ../docker-compose.mcp.yml exec playwright playwright --version
```

### Resource Monitoring

```bash
# Container resource usage
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Network usage
docker network inspect mcp-network

# Volume usage
docker system df -v
```

## Contributing

### Adding New Services

1. Create service directory: `mcp-servers/new-service/`
2. Add Dockerfile with standard structure
3. Create entrypoint.sh and healthcheck.sh
4. Update docker-compose.mcp.yml
5. Add service to gateway configuration
6. Update documentation

### Standard Dockerfile Template

```dockerfile
FROM node:18-alpine

LABEL maintainer="Simone Framework"
LABEL description="New MCP Service"
LABEL version="1.0.0"

WORKDIR /app
RUN mkdir -p /app/data /app/logs

# Install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy application
COPY src/ ./src/
COPY entrypoint.sh healthcheck.sh ./
RUN chmod +x entrypoint.sh healthcheck.sh

ENV MCP_SERVER_PORT=8085
ENV MCP_SERVER_HOST=0.0.0.0

EXPOSE 8085

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD ./healthcheck.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["node", "src/server.js"]
```

---

**Docker MCP Infrastructure** | **Simone Framework v3.0.0** | **Last Updated**: 2025-01-14