const express = require('express');
const router = express.Router();
const callRequestController = require('../controllers/call-request.controller');

// Create a new call request
router.post('/', callRequestController.createCallRequest);

// Get all call requests for a doctor
router.get('/doctor/:doctorId', callRequestController.getDoctorCallRequests);

// Get all call requests for a patient
router.get('/patient/:patientId', callRequestController.getPatientCallRequests);

// Update call request status
router.patch('/:requestId', callRequestController.updateCallRequestStatus);

module.exports = router; 