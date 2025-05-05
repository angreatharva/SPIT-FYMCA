const express = require('express');
const router = express.Router();
const doctorController = require('../controllers/doctor.controller');
const { verifyToken } = require('../middleware/auth.middleware');

/**
 * @swagger
 * /api/doctors/available:
 *   get:
 *     summary: Get all available doctors
 *     tags: [Doctors]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: List of available doctors
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
router.get('/available', verifyToken, doctorController.getAvailableDoctors);

/**
 * @swagger
 * /api/doctors/{id}/status:
 *   get:
 *     summary: Get doctor's status
 *     tags: [Doctors]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Doctor ID
 *     responses:
 *       200:
 *         description: Doctor's status
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 isAvailable:
 *                   type: boolean
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Doctor not found
 *       500:
 *         description: Server error
 */
router.get('/:id/status', verifyToken, doctorController.getDoctorStatus);

/**
 * @swagger
 * /api/doctors/{id}:
 *   get:
 *     summary: Get doctor details by ID
 *     tags: [Doctors]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Doctor ID
 *     responses:
 *       200:
 *         description: Doctor details
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 doctor:
 *                   type: object
 *                   properties:
 *                     _id:
 *                       type: string
 *                     doctorName:
 *                       type: string
 *                     email:
 *                       type: string
 *                     specialization:
 *                       type: string
 *                     isAvailable:
 *                       type: boolean
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Doctor not found
 *       500:
 *         description: Server error
 */
router.get('/:id', verifyToken, doctorController.getDoctorById);

/**
 * @swagger
 * /api/doctors/{id}/toggle-status:
 *   patch:
 *     summary: Toggle doctor's availability status
 *     tags: [Doctors]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Doctor ID
 *     responses:
 *       200:
 *         description: Status toggled successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 isAvailable:
 *                   type: boolean
 *                 message:
 *                   type: string
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Doctor not found
 *       500:
 *         description: Server error
 */
router.patch('/:id/toggle-status', verifyToken, doctorController.toggleDoctorStatus);

module.exports = router; 