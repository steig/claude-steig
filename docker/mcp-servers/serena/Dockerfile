# Serena MCP Server Dockerfile
FROM node:18-alpine

LABEL maintainer="Simone Framework"
LABEL description="Serena MCP Server - Enhanced IDE assistance and project management"
LABEL version="1.0.0"

# Install system dependencies
RUN apk add --no-cache \
    git \
    curl \
    python3 \
    py3-pip \
    && rm -rf /var/cache/apk/*

# Create app directory
WORKDIR /app

# Install uvx and serena
RUN pip3 install --no-cache-dir uv
RUN uv tool install --from git+https://github.com/oraios/serena serena-mcp-server

# Create data directory and logs
RUN mkdir -p /app/data /app/logs

# Set up environment
ENV PATH="/root/.local/bin:$PATH"
ENV MCP_SERVER_PORT=8080
ENV MCP_SERVER_HOST=0.0.0.0

# Create startup script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Create health check script
COPY healthcheck.sh /app/healthcheck.sh
RUN chmod +x /app/healthcheck.sh

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /app/healthcheck.sh

# Start the server
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["serena-mcp-server", "--context", "ide-assistant", "--port", "8080", "--host", "0.0.0.0"]