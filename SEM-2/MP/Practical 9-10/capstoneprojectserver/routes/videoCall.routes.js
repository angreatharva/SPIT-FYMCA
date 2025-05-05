const express = require('express');
const router = express.Router();
const videoCallController = require('../controllers/videoCall.controller');
const { verifyToken } = require('../middleware/auth.middleware');
const socketService = require('../services/socket.service');

/**
 * @swagger
 * /api/video-call/active-doctors:
 *   get:
 *     summary: Get all active doctors (for patients)
 *     tags: [Video Call]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: List of active doctors
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 doctors:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       _id:
 *                         type: string
 *                       doctorName:
 *                         type: string
 *                       email:
 *                         type: string
 *                       specialization:
 *                         type: string
 *                       isAvailable:
 *                         type: boolean
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.get('/active-doctors', verifyToken, videoCallController.getActiveDoctors);

/**
 * @swagger
 * /api/video-call/request-call:
 *   post:
 *     summary: Request a video call (for patients)
 *     tags: [Video Call]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - doctorId
 *               - patientId
 *             properties:
 *               doctorId:
 *                 type: string
 *                 description: ID of the doctor to call
 *               patientId:
 *                 type: string
 *                 description: ID of the requesting patient
 *               notes:
 *                 type: string
 *                 description: Optional notes for the call
 *     responses:
 *       201:
 *         description: Call request created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 requestId:
 *                   type: string
 *                 message:
 *                   type: string
 *       400:
 *         description: Invalid request data or doctor not available
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Doctor or patient not found
 *       500:
 *         description: Server error
 */
router.post('/request-call', verifyToken, videoCallController.requestVideoCall);

/**
 * @swagger
 * /api/video-call/pending-requests/{doctorId}:
 *   get:
 *     summary: Get pending call requests (for doctors)
 *     tags: [Video Call]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: doctorId
 *         required: true
 *         schema:
 *           type: string
 *         description: Doctor ID
 *     responses:
 *       200:
 *         description: List of pending call requests
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 requests:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       _id:
 *                         type: string
 *                       doctorId:
 *                         type: string
 *                       patientId:
 *                         type: string
 *                       status:
 *                         type: string
 *                         enum: [pending, accepted, rejected, completed]
 *                       notes:
 *                         type: string
 *                       requestedAt:
 *                         type: string
 *                         format: date-time
 *                       patientDetails:
 *                         type: object
 *                         properties:
 *                           userName:
 *                             type: string
 *                           email:
 *                             type: string
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Doctor not found
 *       500:
 *         description: Server error
 */
router.get('/pending-requests/:doctorId', verifyToken, videoCallController.getPendingCallRequests);

/**
 * @swagger
 * /api/video-call/request/{requestId}:
 *   patch:
 *     summary: Update call request status (for doctors)
 *     tags: [Video Call]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: requestId
 *         required: true
 *         schema:
 *           type: string
 *         description: Call request ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - status
 *             properties:
 *               status:
 *                 type: string
 *                 enum: [accepted, rejected, completed]
 *                 description: New status for the call request
 *     responses:
 *       200:
 *         description: Call request status updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 request:
 *                   type: object
 *                   properties:
 *                     _id:
 *                       type: string
 *                     doctorId:
 *                       type: string
 *                     patientId:
 *                       type: string
 *                     status:
 *                       type: string
 *                     notes:
 *                       type: string
 *                     requestedAt:
 *                       type: string
 *                       format: date-time
 *                     updatedAt:
 *                       type: string
 *                       format: date-time
 *       400:
 *         description: Invalid status value
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Call request not found
 *       500:
 *         description: Server error
 */
router.patch('/request/:requestId', verifyToken, videoCallController.updateCallRequestStatus);

// Hidden test route - not included in Swagger docs as it's for development only
router.get('/test-socket/:doctorId/:patientId/:requestId', (req, res) => {
  const { doctorId, patientId, requestId } = req.params;
  
  console.log(`TEST: Emitting socket events for doctorId=${doctorId}, patientId=${patientId}, requestId=${requestId}`);
  
  // 1. Emit a new call request event
  socketService.emitNewCallRequest(doctorId, patientId, requestId);
  
  // 2. After 3 seconds, emit a status update event
  setTimeout(() => {
    socketService.emitCallRequestStatusUpdate(doctorId, patientId, requestId, 'accepted');
    console.log('TEST: Emitted status update event');
  }, 3000);
  
  res.json({
    success: true,
    message: 'Test socket events triggered',
    data: { doctorId, patientId, requestId }
  });
});

module.exports = router; 