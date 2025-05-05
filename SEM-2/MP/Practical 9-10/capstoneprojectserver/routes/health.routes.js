const express = require('express');
const router = express.Router();
const healthController = require('../controllers/health.controller');
const { verifyToken } = require('../middleware/auth.middleware');

/**
 * @swagger
 * /api/health/questions:
 *   get:
 *     summary: Get all health questions
 *     tags: [Health]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: List of all health questions
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 questions:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       _id:
 *                         type: string
 *                       question:
 *                         type: string
 *                       targetRole:
 *                         type: string
 *                         enum: [patient, doctor, both]
 *                       points:
 *                         type: integer
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.get('/questions', verifyToken, healthController.getAllQuestions);

/**
 * @swagger
 * /api/health/questions/role/{role}:
 *   get:
 *     summary: Get questions by role
 *     tags: [Health]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: role
 *         required: true
 *         schema:
 *           type: string
 *           enum: [patient, doctor, both]
 *         description: Target role for questions
 *     responses:
 *       200:
 *         description: List of questions for the specified role
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 questions:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       _id:
 *                         type: string
 *                       question:
 *                         type: string
 *                       targetRole:
 *                         type: string
 *                         enum: [patient, doctor, both]
 *                       points:
 *                         type: integer
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.get('/questions/role/:role', verifyToken, healthController.getQuestionsByRole);

/**
 * @swagger
 * /api/health/tracking/{userId}:
 *   get:
 *     summary: Get today's health tracking for a user
 *     tags: [Health]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: string
 *         description: User ID
 *       - in: query
 *         name: userType
 *         schema:
 *           type: string
 *           enum: [patient, doctor]
 *           default: patient
 *         description: User type (patient or doctor)
 *     responses:
 *       200:
 *         description: User's health tracking data
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 tracking:
 *                   type: object
 *                   properties:
 *                     _id:
 *                       type: string
 *                     userId:
 *                       type: string
 *                     userType:
 *                       type: string
 *                     date:
 *                       type: string
 *                       format: date
 *                     completed:
 *                       type: array
 *                       items:
 *                         type: string
 *                     totalQuestions:
 *                       type: integer
 *                     completedCount:
 *                       type: integer
 *                     progress:
 *                       type: number
 *                     points:
 *                       type: integer
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Tracking record not found
 *       500:
 *         description: Server error
 */
router.get('/tracking/:userId', verifyToken, healthController.getUserHealthTracking);

/**
 * @swagger
 * /api/health/tracking/{userId}/{trackingId}/complete/{questionId}:
 *   post:
 *     summary: Complete a health question
 *     tags: [Health]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: string
 *         description: User ID
 *       - in: path
 *         name: trackingId
 *         required: true
 *         schema:
 *           type: string
 *         description: Tracking record ID
 *       - in: path
 *         name: questionId
 *         required: true
 *         schema:
 *           type: string
 *         description: Question ID to complete
 *     responses:
 *       200:
 *         description: Question completed successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 tracking:
 *                   type: object
 *                   properties:
 *                     _id:
 *                       type: string
 *                     userId:
 *                       type: string
 *                     userType:
 *                       type: string
 *                     date:
 *                       type: string
 *                       format: date
 *                     completed:
 *                       type: array
 *                       items:
 *                         type: string
 *                     totalQuestions:
 *                       type: integer
 *                     completedCount:
 *                       type: integer
 *                     progress:
 *                       type: number
 *                     points:
 *                       type: integer
 *       400:
 *         description: Question already completed or invalid
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Tracking record or question not found
 *       500:
 *         description: Server error
 */
router.post('/tracking/:userId/:trackingId/complete/:questionId', verifyToken, healthController.completeHealthQuestion);

/**
 * @swagger
 * /api/health/heatmap/{userId}:
 *   get:
 *     summary: Get health activity heatmap data for a user
 *     tags: [Health]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: string
 *         description: User ID
 *     responses:
 *       200:
 *         description: User's health activity heatmap data
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 heatmapData:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       date:
 *                         type: string
 *                         format: date
 *                       count:
 *                         type: integer
 *                 totalPoints:
 *                   type: integer
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: User not found
 *       500:
 *         description: Server error
 */
router.get('/heatmap/:userId', verifyToken, healthController.getHealthActivityHeatmap);

/**
 * @swagger
 * /api/health/admin/refresh:
 *   post:
 *     summary: Manually trigger a refresh of all health tracking records
 *     tags: [Health Admin]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Health tracking records refreshed successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 recordsCreated:
 *                   type: integer
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.post('/admin/refresh', verifyToken, async (req, res) => {
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

/**
 * @swagger
 * /api/health/admin/backfill:
 *   post:
 *     summary: Backfill health activity data
 *     tags: [Health Admin]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Health activity data backfilled successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.post('/admin/backfill', verifyToken, healthController.backfillHealthActivity);

module.exports = router; 