const express = require('express');
const router = express.Router();
const doctorController = require('../controllers/doctor.controller');

// Get all available doctors
router.get('/available', doctorController.getAvailableDoctors);

// Get doctor's status
router.get('/:id/status', doctorController.getDoctorStatus);

// Toggle doctor's status
router.patch('/:id/toggle-status', doctorController.toggleDoctorStatus);

module.exports = router; 