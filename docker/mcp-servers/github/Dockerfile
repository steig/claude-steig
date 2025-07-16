# GitHub MCP Server Dockerfile
FROM ghcr.io/github/github-mcp-server:latest

LABEL maintainer="Simone Framework"
LABEL description="GitHub MCP Server - Repository management and API integration"
LABEL version="1.0.0"

# Install system dependencies for health checks
USER root
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create app directory and logs
RUN mkdir -p /app/data /app/logs

# Set up environment
ENV MCP_SERVER_PORT=8083
ENV MCP_SERVER_HOST=0.0.0.0

# Create health check script
COPY healthcheck.sh /app/healthcheck.sh
RUN chmod +x /app/healthcheck.sh

# Create startup script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose port
EXPOSE 8083

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /app/healthcheck.sh

# Start the server
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["github-mcp-server", "stdio"]