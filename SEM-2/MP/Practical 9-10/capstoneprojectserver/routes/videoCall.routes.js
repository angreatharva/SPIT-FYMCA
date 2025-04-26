const express = require('express');
const router = express.Router();
const videoCallController = require('../controllers/videoCall.controller');

// Get all active doctors (for patients)
router.get('/active-doctors', videoCallController.getActiveDoctors);

// Request a video call (for patients)
router.post('/request-call', videoCallController.requestVideoCall);

// Get pending call requests (for doctors)
router.get('/pending-requests/:doctorId', videoCallController.getPendingCallRequests);

// Update call request status (for doctors)
router.patch('/request/:requestId', videoCallController.updateCallRequestStatus);

module.exports = router; 