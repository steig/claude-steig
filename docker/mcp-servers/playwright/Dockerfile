# Playwright MCP Server Dockerfile
FROM mcr.microsoft.com/playwright:v1.40.0-focal

LABEL maintainer="Simone Framework"
LABEL description="Playwright MCP Server - Browser automation and testing"
LABEL version="1.0.0"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Install uvx and playwright MCP server
RUN pip3 install --no-cache-dir uv
RUN uv tool install --from git+https://github.com/microsoft/playwright-mcp playwright-mcp-server

# Install Playwright browsers
RUN playwright install

# Create data directory and logs
RUN mkdir -p /app/data /app/logs

# Set up environment
ENV PATH="/root/.local/bin:$PATH"
ENV MCP_SERVER_PORT=8082
ENV MCP_SERVER_HOST=0.0.0.0
ENV DISPLAY=:99

# Create startup script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Create health check script
COPY healthcheck.sh /app/healthcheck.sh
RUN chmod +x /app/healthcheck.sh

# Start virtual display for headless browsers
COPY start-xvfb.sh /app/start-xvfb.sh
RUN chmod +x /app/start-xvfb.sh

# Expose port
EXPOSE 8082

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /app/healthcheck.sh

# Start the server
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["playwright-mcp-server", "--port", "8082", "--host", "0.0.0.0"]