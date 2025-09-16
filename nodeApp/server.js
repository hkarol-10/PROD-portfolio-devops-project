const express = require('express');
const fs = require('fs');
const path = require('path');
const os = require('os');
const morgan = require('morgan');
const app = express();
const port = 3000;
const helmet = require('helmet');
const cors = require('cors');

app.disable('x-powered-by'); //disable version visibility

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

// --- LOGS ---
const logDirectory = path.join(__dirname, 'logs');
fs.existsSync(logDirectory) || fs.mkdirSync(logDirectory);

// access.log stream
const accessLogStream = fs.createWriteStream(path.join(logDirectory, 'access.log'), { flags: 'a' });
app.use(morgan('combined', { stream: accessLogStream }));

// --- HEALTH CHECK ---
app.get('/api/health', (req, res) => {
  const uptime = ((Date.now() - startTime) / 1000).toFixed(0);
  res.json({
    status: 'OK',
    server: os.hostname(),
    uptime: `${uptime} sec`,
    timestamp: new Date().toISOString()
  });
});

// --- STATIC FILE ---
app.use(express.static(path.join(__dirname, 'public')));

app.listen(port, () => {
  console.log(`🚀 Server running on port ${port}`);
});