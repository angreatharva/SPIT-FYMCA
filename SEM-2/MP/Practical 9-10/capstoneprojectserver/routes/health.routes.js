const express = require('express');
const router = express.Router();
const healthController = require('../controllers/health.controller');

// Get all health questions
router.get('/questions', healthController.getAllQuestions);

// Get questions by role (doctor, patient, or both)
router.get('/questions/role/:role', healthController.getQuestionsByRole);

// Get today's health tracking for a user
// userType query parameter can be 'doctor' or 'patient' (default: 'patient')
router.get('/tracking/:userId', healthController.getUserHealthTracking);

// Complete a health question
router.post('/tracking/:userId/:trackingId/complete/:questionId', healthController.completeHealthQuestion);

// Get health activity heatmap data for a user
router.get('/heatmap/:userId', healthController.getHealthActivityHeatmap);

// Admin routes
// Manually trigger a refresh of all health tracking records
router.post('/admin/refresh', async (req, res) => {
  try {
    const result = await healthController.refreshAllHealthTracking();
    if (result.success) {
      return res.status(200).json(result);
    } else {
      return res.status(500).json(result);
    }
  } catch (error) {
    console.error('Error refreshing health tracking:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to refresh health tracking records'
    });
  }
});

// Backfill health activity data
router.post('/admin/backfill', healthController.backfillHealthActivity);

module.exports = router; 