// routes/transcription.routes.js
const express = require('express');
const router = express.Router();
const transcriptionController = require('../controllers/transcription.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// Add a new transcription
router.post('/', verifyToken, transcriptionController.addTranscription);

// Get all transcriptions for a call
router.get('/:callId', verifyToken, transcriptionController.getTranscriptions);

module.exports = router;