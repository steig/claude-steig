# MCP Gateway Dockerfile
FROM node:18-alpine

LABEL maintainer="Simone Framework"
LABEL description="MCP Gateway - Central proxy and load balancer for MCP services"
LABEL version="1.0.0"

# Install system dependencies
RUN apk add --no-cache \
    curl \
    nginx \
    && rm -rf /var/cache/apk/*

# Create app directory
WORKDIR /app

# Copy gateway application
COPY package.json package-lock.json ./
RUN npm ci --only=production

COPY src/ ./src/
COPY nginx.conf /etc/nginx/nginx.conf

# Create logs directory
RUN mkdir -p /app/logs /var/log/nginx

# Set up environment
ENV GATEWAY_PORT=9000
ENV NODE_ENV=production

# Create startup script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Create health check script
COPY healthcheck.sh /app/healthcheck.sh
RUN chmod +x /app/healthcheck.sh

# Expose port
EXPOSE 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /app/healthcheck.sh

# Start the gateway
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["node", "src/gateway.js"]