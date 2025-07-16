const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');

const app = express();
const PORT = process.env.GATEWAY_PORT || 9000;

// Security middleware
app.use(helmet());
app.use(cors());

// Logging
app.use(morgan('combined'));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
app.use(limiter);

// MCP Service URLs
const services = {
  serena: process.env.SERENA_URL || 'http://serena:8080',
  context7: process.env.CONTEXT7_URL || 'http://context7:8081',
  playwright: process.env.PLAYWRIGHT_URL || 'http://playwright:8082',
  'work-history': process.env.WORK_HISTORY_URL || 'http://work-history:8083',
  'sequential-thinking': process.env.SEQUENTIAL_THINKING_URL || 'http://sequential-thinking:8084'
};

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    services: Object.keys(services),
    gateway: {
      version: '1.0.0',
      uptime: process.uptime()
    }
  });
});

// Service status endpoint
app.get('/status', async (req, res) => {
  const serviceStatus = {};
  
  for (const [name, url] of Object.entries(services)) {
    try {
      const response = await fetch(`${url}/health`);
      serviceStatus[name] = {
        status: response.ok ? 'healthy' : 'unhealthy',
        url: url,
        lastCheck: new Date().toISOString()
      };
    } catch (error) {
      serviceStatus[name] = {
        status: 'unreachable',
        url: url,
        error: error.message,
        lastCheck: new Date().toISOString()
      };
    }
  }
  
  res.json({
    gateway: 'healthy',
    services: serviceStatus
  });
});

// Proxy configuration
const proxyOptions = {
  changeOrigin: true,
  pathRewrite: {
    '^/api/([^/]+)': '/' // Remove /api/servicename prefix
  },
  onError: (err, req, res) => {
    console.error('Proxy error:', err);
    res.status(503).json({
      error: 'Service unavailable',
      message: 'The requested MCP service is currently unavailable'
    });
  },
  onProxyReq: (proxyReq, req, res) => {
    console.log(`Proxying ${req.method} ${req.url} to ${proxyReq.path}`);
  }
};

// Create proxy middleware for each service
Object.entries(services).forEach(([serviceName, serviceUrl]) => {
  app.use(`/api/${serviceName}`, createProxyMiddleware({
    target: serviceUrl,
    ...proxyOptions
  }));
});

// Default route
app.get('/', (req, res) => {
  res.json({
    name: 'MCP Gateway',
    version: '1.0.0',
    description: 'Central proxy and load balancer for MCP services',
    services: Object.keys(services),
    endpoints: {
      health: '/health',
      status: '/status',
      services: Object.keys(services).map(name => `/api/${name}`)
    }
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Gateway error:', err);
  res.status(500).json({
    error: 'Internal server error',
    message: 'An error occurred in the MCP Gateway'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not found',
    message: 'The requested endpoint was not found'
  });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`MCP Gateway running on port ${PORT}`);
  console.log('Available services:', Object.keys(services));
  console.log('Service URLs:', services);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down gracefully');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('SIGINT received, shutting down gracefully');
  process.exit(0);
});