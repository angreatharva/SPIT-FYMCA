const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const userController = require('../controllers/user.controller');
const doctorController = require('../controllers/doctor.controller');
const { verifyToken } = require('../middleware/auth.middleware');

/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: User or doctor login
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *               password:
 *                 type: string
 *                 format: password
 *     responses:
 *       200:
 *         description: Login successful
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 role:
 *                   type: string
 *                   example: patient
 *                 userId:
 *                   type: string
 *                   example: 60d0fe4f5311236168a109ca
 *                 userName:
 *                   type: string
 *                 email:
 *                   type: string
 *                 token:
 *                   type: string
 *                 message:
 *                   type: string
 *       401:
 *         description: Invalid credentials
 *       500:
 *         description: Server error
 */
router.post('/login', authController.login);

/**
 * @swagger
 * /api/auth/logout:
 *   post:
 *     summary: Logout the user or doctor
 *     tags: [Authentication]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Logout successful
 *       400:
 *         description: No token provided
 *       500:
 *         description: Server error
 */
router.post('/logout', verifyToken, authController.logout);

/**
 * @swagger
 * /api/auth/register/user:
 *   post:
 *     summary: Register a new user
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - userName
 *               - email
 *               - password
 *             properties:
 *               userName:
 *                 type: string
 *               email:
 *                 type: string
 *                 format: email
 *               password:
 *                 type: string
 *                 format: password
 *     responses:
 *       201:
 *         description: User registered successfully
 *       400:
 *         description: Invalid input or user already exists
 *       500:
 *         description: Server error
 */
router.post('/register/user', userController.registerUser);

/**
 * @swagger
 * /api/auth/register/doctor:
 *   post:
 *     summary: Register a new doctor
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - doctorName
 *               - email
 *               - password
 *               - specialization
 *             properties:
 *               doctorName:
 *                 type: string
 *               email:
 *                 type: string
 *                 format: email
 *               password:
 *                 type: string
 *                 format: password
 *               specialization:
 *                 type: string
 *     responses:
 *       201:
 *         description: Doctor registered successfully
 *       400:
 *         description: Invalid input or doctor already exists
 *       500:
 *         description: Server error
 */
router.post('/register/doctor', doctorController.registerDoctor);

/**
 * @swagger
 * /api/auth/users:
 *   get:
 *     summary: Get all registered users
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: List of registered users
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.get('/users', verifyToken, userController.getRegisteredUsers);

/**
 * @swagger
 * /api/auth/user/{id}:
 *   get:
 *     summary: Get user details by ID
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: User ID
 *     responses:
 *       200:
 *         description: User details
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: User not found
 *       500:
 *         description: Server error
 */
router.get('/user/:id', verifyToken, userController.getUserById);

module.exports = router; 