const mongoose = require('mongoose');

const sessionSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: 'User'
  },
  role: {
    type: String,
    enum: ['patient', 'doctor'],
    required: true
  },
  token: {
    type: String,
    required: true
  },
  device: {
    type: String,
    default: 'unknown'
  },
  createdAt: {
    type: Date,
    default: Date.now,
    expires: '7d' // Automatically expire sessions after 7 days
  }
});

// Index to find sessions by userId quickly
sessionSchema.index({ userId: 1 });

module.exports = mongoose.model('Session', sessionSchema); 