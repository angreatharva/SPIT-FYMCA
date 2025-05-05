// routes/transcription.routes.js
const express = require('express');
const router = express.Router();
const transcriptionController = require('../controllers/transcription.controller');
const { verifyToken } = require('../middleware/auth.middleware');

/**
 * @swagger
 * /api/transcriptions:
 *   post:
 *     summary: Add a new transcription
 *     tags: [Transcriptions]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - callId
 *               - text
 *               - speakerId
 *               - speakerType
 *             properties:
 *               callId:
 *                 type: string
 *                 description: The ID of the call/session
 *               text:
 *                 type: string
 *                 description: The transcribed text
 *               speakerId:
 *                 type: string
 *                 description: ID of the speaker (user or doctor)
 *               speakerType:
 *                 type: string
 *                 description: Type of speaker (patient or doctor)
 *               timestamp:
 *                 type: string
 *                 format: date-time
 *                 description: Timestamp of the transcription (defaults to current time)
 *     responses:
 *       201:
 *         description: Transcription added successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 transcription:
 *                   type: object
 *                   properties:
 *                     _id:
 *                       type: string
 *                     callId:
 *                       type: string
 *                     text:
 *                       type: string
 *                     speakerId:
 *                       type: string
 *                     speakerType:
 *                       type: string
 *                     timestamp:
 *                       type: string
 *                       format: date-time
 *       400:
 *         description: Invalid request data
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.post('/', verifyToken, transcriptionController.addTranscription);

/**
 * @swagger
 * /api/transcriptions/{callId}:
 *   get:
 *     summary: Get all transcriptions for a call
 *     tags: [Transcriptions]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: callId
 *         required: true
 *         schema:
 *           type: string
 *         description: ID of the call/session
 *     responses:
 *       200:
 *         description: List of transcriptions for the call
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 transcriptions:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       _id:
 *                         type: string
 *                       callId:
 *                         type: string
 *                       text:
 *                         type: string
 *                       speakerId:
 *                         type: string
 *                       speakerType:
 *                         type: string
 *                       timestamp:
 *                         type: string
 *                         format: date-time
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: No transcriptions found
 *       500:
 *         description: Server error
 */
router.get('/:callId', verifyToken, transcriptionController.getTranscriptions);

module.exports = router;