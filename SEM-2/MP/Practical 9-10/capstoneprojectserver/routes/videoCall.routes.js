const express = require('express');
const router = express.Router();
const videoCallController = require('../controllers/videoCall.controller');
const { verifyToken } = require('../middleware/auth.middleware');
const socketService = require('../services/socket.service');

// Get all active doctors (for patients)
router.get('/active-doctors', verifyToken, videoCallController.getActiveDoctors);

// Request a video call (for patients)
router.post('/request-call', verifyToken, videoCallController.requestVideoCall);

// Get pending call requests (for doctors)
router.get('/pending-requests/:doctorId', verifyToken, videoCallController.getPendingCallRequests);

// Update call request status (for doctors)
router.patch('/request/:requestId', verifyToken, videoCallController.updateCallRequestStatus);

// Test route for debugging socket events (REMOVE IN PRODUCTION)
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