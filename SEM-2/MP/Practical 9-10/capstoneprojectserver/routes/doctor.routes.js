const express = require('express');
const router = express.Router();
const doctorController = require('../controllers/doctor.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// Get all available doctors
router.get('/available', verifyToken, doctorController.getAvailableDoctors);

// Get doctor's status
router.get('/:id/status', verifyToken, doctorController.getDoctorStatus);

// Get doctor details by ID
router.get('/:id', verifyToken, doctorController.getDoctorById);

// Toggle doctor's status
router.patch('/:id/toggle-status', verifyToken, doctorController.toggleDoctorStatus);

module.exports = router; 