const express = require('express');
const router = express.Router();
const healthController = require('../controllers/health.controller');

// Get all health questions
router.get('/questions', healthController.getAllQuestions);

// Get today's health tracking for a user
router.get('/tracking/:userId', healthController.getUserHealthTracking);

// Complete a health question
router.post('/tracking/:userId/:trackingId/complete/:questionId', healthController.completeHealthQuestion);

// For Admin: Manually trigger the refresh of all health tracking records
router.post('/admin/refresh', async (req, res) => {
  try {
    const result = await healthController.refreshAllHealthTracking();
    return res.status(200).json(result);
  } catch (error) {
    console.error('Error refreshing health tracking:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to refresh health tracking'
    });
  }
});

module.exports = router; 