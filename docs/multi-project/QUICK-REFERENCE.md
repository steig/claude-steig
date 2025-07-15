# Multi-Project Quick Reference

**Essential commands and port assignments for multi-project MCP Docker setup.**

## Port Reference

| Project | Gateway | Serena | Context7 | Playwright | Work History | Sequential |
|---------|---------|--------|----------|------------|--------------|------------|
| **1**   | 9000    | 8080   | 8081     | 8082       | 8083         | 8084       |
| **2**   | 9010    | 8090   | 8091     | 8092       | 8093         | 8094       |
| **3**   | 9020    | 8100   | 8101     | 8102       | 8103         | 8104       |

## Essential Commands

### Setup and Start
```bash
# Setup project in current directory
./scripts/mcp-multi.sh setup 1

# Start project services
./scripts/mcp-multi.sh start 1

# Setup and start in one go
cd /path/to/project && ./scripts/mcp-multi.sh setup 2 && ./scripts/mcp-multi.sh start 2
```

### Status and Health
```bash
# Check all projects
./scripts/mcp-multi.sh status

# Check specific project
./scripts/mcp-multi.sh health 1

# Quick HTTP check
curl http://localhost:9000/health  # Project 1
curl http://localhost:9010/health  # Project 2
curl http://localhost:9020/health  # Project 3
```

### Stop and Restart
```bash
# Stop project
./scripts/mcp-multi.sh stop 1

# Restart project
./scripts/mcp-multi.sh restart 2

# Stop all projects
./scripts/mcp-multi.sh stop 1
./scripts/mcp-multi.sh stop 2
./scripts/mcp-multi.sh stop 3
```

### Logs and Debugging
```bash
# View all logs for project
./scripts/mcp-multi.sh logs 1

# View specific service logs
./scripts/mcp-multi.sh logs 2 serena

# Follow logs in real-time
./scripts/mcp-multi.sh logs 1 | tail -f
```

## Claude Code Configuration

### Gateway Method (Recommended)
```bash
claude mcp add project1 -- http://localhost:9000
claude mcp add project2 -- http://localhost:9010  
claude mcp add project3 -- http://localhost:9020
```

### Individual Services Method
```bash
# Project 1
claude mcp add p1-serena -- http://localhost:8080
claude mcp add p1-context7 -- http://localhost:8081

# Project 2  
claude mcp add p2-serena -- http://localhost:8090
claude mcp add p2-context7 -- http://localhost:8091
```

## Common Workflows

### Start Multiple Projects
```bash
# Projects 1 and 2 simultaneously
cd /path/to/project1 && ./scripts/mcp-multi.sh setup 1 && ./scripts/mcp-multi.sh start 1
cd /path/to/project2 && ./scripts/mcp-multi.sh setup 2 && ./scripts/mcp-multi.sh start 2

# Verify both running
./scripts/mcp-multi.sh status
```

### Switch Between Projects
```bash
# No stopping required - just change Claude Code context
claude mcp use project1  # Work on project 1
claude mcp use project2  # Work on project 2
```

### Daily Startup
```bash
#!/bin/bash
# Create as daily-startup.sh
./scripts/mcp-multi.sh start 1 /path/to/main-project
./scripts/mcp-multi.sh start 2 /path/to/side-project
./scripts/mcp-multi.sh status
```

### Daily Shutdown
```bash
#!/bin/bash  
# Create as daily-shutdown.sh
./scripts/mcp-multi.sh stop 1
./scripts/mcp-multi.sh stop 2
./scripts/mcp-multi.sh stop 3
```

## Troubleshooting Quick Fixes

### Port Already in Use
```bash
# Find what's using the port
lsof -i :9000  # Or netstat -tlnp | grep 9000

# Kill the process or use different project number
./scripts/mcp-multi.sh setup 3  # Use project 3 instead
```

### Services Won't Start
```bash
# Check Docker daemon
docker info

# Check available resources
docker system df

# Clean up if needed
docker system prune -f
```

### Project Not Responding
```bash
# Check container status
docker ps --filter "name=mcp-.*-project1"

# Restart project
./scripts/mcp-multi.sh restart 1

# Check logs for errors
./scripts/mcp-multi.sh logs 1
```

### Complete Reset
```bash
# ⚠️ WARNING: Deletes all project data
./scripts/mcp-multi.sh cleanup 1
./scripts/mcp-multi.sh setup 1
./scripts/mcp-multi.sh start 1
```

## File Locations

### Generated Files
```
/path/to/project1/.env.mcp.project1  # Project 1 environment
/path/to/project2/.env.mcp.project2  # Project 2 environment  
/path/to/project3/.env.mcp.project3  # Project 3 environment
```

### Docker Resources
```
# Containers
mcp-gateway-project1, mcp-serena-project1, etc.

# Volumes  
mcp-serena-data-project1, mcp-context7-data-project1, etc.

# Networks
mcp-network-project1, mcp-network-project2, etc.
```

## Environment Variables

### Key Variables in .env.mcp.project<N>
```bash
PROJECT_NUM=1                    # Project number (1, 2, or 3)
PROJECT_PATH=/path/to/project    # Absolute project path
GATEWAY_PORT=9000               # Gateway port for this project
SERENA_PORT=8080                # Serena port for this project
# ... other service ports
NETWORK_SUBNET=172.20.0.0/16    # Docker network subnet
```

## Performance Notes

### Resource Usage
- **Each project**: ~1-2GB RAM when running
- **Recommended**: 8GB+ RAM for 3 simultaneous projects
- **CPU**: Moderate usage, scales with project activity

### Optimization Tips
```bash
# Monitor resource usage
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Stop unused projects
./scripts/mcp-multi.sh stop 3  # If not using project 3

# Clean up periodically
docker system prune -f
```

---

## Emergency Commands

### Force Stop All
```bash
# Nuclear option - stops ALL Docker containers
docker stop $(docker ps -q)

# Stop only MCP containers
docker stop $(docker ps -q --filter "name=mcp-")
```

### Clean Everything
```bash
# ⚠️ WARNING: Removes ALL MCP data
docker rm -f $(docker ps -aq --filter "name=mcp-")
docker volume rm $(docker volume ls -q | grep mcp-)
docker network rm $(docker network ls -q | grep mcp-network)
```

### Rebuild Containers
```bash
# If containers are corrupted
cd /path/to/simone-framework
docker compose -f docker-compose.mcp-multi.yml build --no-cache
```

---

**Keep this reference handy for daily multi-project operations!**