const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const userController = require('../controllers/user.controller');
const doctorController = require('../controllers/doctor.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// Authentication routes
router.post('/login', authController.login);
router.post('/logout', verifyToken, authController.logout);

// User registration routes
router.post('/register/user', userController.registerUser);
router.post('/register/doctor', doctorController.registerDoctor);

// Get registered users - protected route example
router.get('/users', verifyToken, userController.getRegisteredUsers);

// Get user details by ID - protected route
router.get('/user/:id', verifyToken, userController.getUserById);

module.exports = router; 