// models/transcription.model.js
const mongoose = require('mongoose');

/**
 * @swagger
 * components:
 *   schemas:
 *     Transcription:
 *       type: object
 *       required:
 *         - callId
 *         - speakerId
 *         - role
 *         - text
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         callId:
 *           type: string
 *           description: Unique identifier for the call session
 *         speakerId:
 *           type: string
 *           description: ID of the speaker (user or doctor)
 *         role:
 *           type: string
 *           enum: [doctor, patient]
 *           description: Role of the speaker
 *         text:
 *           type: string
 *           description: Transcribed text content
 *         timestamp:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the transcription was created
 *       example:
 *         _id: 60d0fe4f5311236168a109cf
 *         callId: call-123456
 *         speakerId: 60d0fe4f5311236168a109ca
 *         role: patient
 *         text: Hello doctor, I'm experiencing some symptoms.
 *         timestamp: 2023-05-20T09:45:00.000Z
 */
const TranscriptionSchema = new mongoose.Schema({
  callId: {
    type: String,
    required: true,
    index: true
  },
  speakerId: {
    type: String,
    required: true
  },
  role: {
    type: String,
    enum: ['doctor', 'patient'],
    required: true
  },
  text: {
    type: String,
    required: true
  },
  timestamp: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('Transcription', TranscriptionSchema);
