// app.js
require('dotenv').config();
const express = require('express');
const cors = require("cors");
const connectDB = require('./config/database');
const path = require('path');
const ngrok = require('ngrok');

const movieRoutes = require('./routes/movieRoutes');
const theatreRoutes = require('./routes/theatreRoutes');
const showRoutes = require('./routes/showRoutes');
const bookingRoutes = require('./routes/bookingRoutes');

const app = express();

// Middleware to parse JSON requestsx
app.use(express.json({ limit: "100mb" }));
app.use(express.urlencoded({ limit: "100mb", extended: true }));
app.use(
  cors({
    origin: true,
  })
);

// Serve static files from the uploads directory
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Use API routes
app.use('/api/movies', movieRoutes);
app.use('/api/theatres', theatreRoutes);
app.use('/api/shows', showRoutes);
app.use('/api/bookings', bookingRoutes);

// Global error handler middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something went wrong!');
});

const PORT = process.env.PORT || 5000;
const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  
  // 🚀 Start ngrok after server is up
  (async function() {
    try {
      const url = await ngrok.connect({
        proto: "http",
        addr: PORT,
        authtoken: process.env.NGROK_TOKEN, // Optional: Add your token to .env file if you have one
      });
      console.log(`\n🎉 Public URL (share this!): ${url}`);
      
    } catch (err) {
      console.error("Failed to start ngrok:", err);
    }
  })();
});

// Handle server shutdown
process.on('SIGINT', async () => {
  console.log('Shutting down server...');
  await ngrok.disconnect();
  await ngrok.kill();
  server.close(() => {
    console.log('Server closed');
    process.exit(0);
  });
});
