const express = require('express');
const router = express.Router();
const videoCallController = require('../controllers/videoCall.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// Get all active doctors (for patients)
router.get('/active-doctors', verifyToken, videoCallController.getActiveDoctors);

// Request a video call (for patients)
router.post('/request-call', verifyToken, videoCallController.requestVideoCall);

// Get pending call requests (for doctors)
router.get('/pending-requests/:doctorId', verifyToken, videoCallController.getPendingCallRequests);

// Update call request status (for doctors)
router.patch('/request/:requestId', verifyToken, videoCallController.updateCallRequestStatus);

module.exports = router; 