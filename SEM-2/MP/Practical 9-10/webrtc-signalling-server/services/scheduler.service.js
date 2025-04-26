const cron = require('node-cron');
const healthController = require('../controllers/health.controller');

// Setup cron job to refresh health tracking data at midnight every day
const setupDailyHealthTrackingRefresh = () => {
  // Schedule task to run at midnight (00:00) every day
  cron.schedule('0 0 * * *', async () => {
    console.log('Running daily health tracking refresh job at', new Date().toISOString());
    try {
      const result = await healthController.refreshAllHealthTracking();
      console.log('Daily health tracking refresh completed:', result);
    } catch (error) {
      console.error('Error during daily health tracking refresh:', error);
    }
  });
  
  // Also run once at startup to make sure all users have today's tracking
  setTimeout(async () => {
    console.log('Running initial health tracking setup for today');
    try {
      const result = await healthController.refreshAllHealthTracking();
      console.log('Initial health tracking setup completed:', result);
    } catch (error) {
      console.error('Error during initial health tracking setup:', error);
    }
  }, 5000); // Wait 5 seconds after server start
  
  console.log('Daily health tracking refresh job scheduled');
};

module.exports = {
  setupDailyHealthTrackingRefresh
}; 