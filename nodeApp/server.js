const express = require('express');
const fs = require('fs');
const path = require('path');
const os = require('os');
const morgan = require('morgan');
const helmet = require('helmet');
const cors = require('cors');
const client = require('prom-client'); // Prometheus

const app = express();
const port = 3000;

app.disable('x-powered-by');

app.use(
  helmet({
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        imgSrc: ["'self'", "https:", "data:"],
        scriptSrc: ["'self'", "https:"],
        styleSrc: ["'self'", "https:", "'unsafe-inline'"]
      }
    }
  })
);

app.use(cors({ origin: 'https://hkarol-devops.com' }));

const startTime = Date.now();

// LOGS
const logDirectory = path.join(__dirname, 'logs');
fs.existsSync(logDirectory) || fs.mkdirSync(logDirectory);
const accessLogStream = fs.createWriteStream(path.join(logDirectory, 'access.log'), { flags: 'a' });
app.use(morgan('combined', { stream: accessLogStream }));

// PROMETHEUS METRICS
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics();

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});

// HEALTH CHECK
app.get('/api/health', (req, res) => {
  const uptime = ((Date.now() - startTime) / 1000).toFixed(0);
  res.json({
    status: 'OK',
    server: os.hostname(),
    uptime: `${uptime} sec`,
    timestamp: new Date().toISOString()
  });
});

// STATIC FILES
app.use(express.static(path.join(__dirname, 'public')));

module.exports = app;

if (require.main === module) {
  app.listen(port, () => {
    console.log(`🚀 Server running on port ${port}`);
  });
}
