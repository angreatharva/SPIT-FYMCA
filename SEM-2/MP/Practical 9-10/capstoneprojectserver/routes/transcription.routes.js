// routes/transcription.routes.js
const express = require('express');
const router = express.Router();
const transcriptionController = require('../controllers/transcription.controller');

// Add a new transcription
router.post('/', transcriptionController.addTranscription);

// Get all transcriptions for a call
router.get('/:callId', transcriptionController.getTranscriptions);

module.exports = router;