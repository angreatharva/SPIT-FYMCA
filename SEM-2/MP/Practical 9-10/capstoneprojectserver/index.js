// Load environment variables
require('dotenv').config();

// Main server file
const express = require('express');
const IO = require('socket.io');
const cors = require('cors');
const path = require('path');
const swaggerUi = require('swagger-ui-express');
const swaggerSpecs = require('./config/swagger.config');

// Import configuration
const config = require('./config/server.config');
const connectDB = require('./config/db.config');

// Import services
const setupSocketServer = require('./services/socket.service');
const setupNgrok = require('./services/ngrok.service');
const { setupDailyHealthTrackingRefresh } = require('./services/scheduler.service');

// Import middleware
const errorHandler = require('./middleware/error.middleware');

// Create Express app
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Swagger UI setup
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpecs, { explorer: true }));

// Serve static files from uploads directory
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Connect to MongoDB
connectDB();

// Routes
app.use('/api/transcriptions', require('./routes/transcription.routes'));
app.use('/api/auth', require('./routes/auth.routes'));
app.use('/api/doctors', require('./routes/doctor.routes'));
app.use('/api/health', require('./routes/health.routes'));
app.use('/api/video-call', require('./routes/videoCall.routes'));
app.use('/api/blogs', require('./routes/blog.routes'));

// Error handling middleware (must be after routes)
app.use(errorHandler);

// Only start the server if this file is run directly, not when imported for testing
if (process.env.NODE_ENV !== 'test') {
  // Create HTTP server and attach socket.io
  const server = app.listen(config.port, () => console.log(`Server running on port ${config.port}`));
  const io = IO(server, {
    cors: {
      origin: true,
      methods: ["GET", "POST"],
    },
  });

  // Setup socket.io server
  setupSocketServer(io);

  // Setup ngrok for public access
  setupNgrok();

  // Setup daily health tracking refresh
  setupDailyHealthTrackingRefresh();
}

module.exports = app;
