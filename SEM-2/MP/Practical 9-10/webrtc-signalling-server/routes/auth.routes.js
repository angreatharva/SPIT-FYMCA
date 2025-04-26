const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const userController = require('../controllers/user.controller');
const doctorController = require('../controllers/doctor.controller');

// Authentication route
router.post('/login', authController.login);

// User registration routes
router.post('/register/user', userController.registerUser);
router.post('/register/doctor', doctorController.registerDoctor);

// Get registered users
router.get('/users', userController.getRegisteredUsers);

module.exports = router; 