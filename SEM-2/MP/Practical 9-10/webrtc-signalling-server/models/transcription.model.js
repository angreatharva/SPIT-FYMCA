// models/transcription.model.js
const mongoose = require('mongoose');

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
