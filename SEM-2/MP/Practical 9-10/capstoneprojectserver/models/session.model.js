const mongoose = require('mongoose');

/**
 * @swagger
 * components:
 *   schemas:
 *     Session:
 *       type: object
 *       required:
 *         - userId
 *         - role
 *         - token
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         userId:
 *           type: string
 *           description: ID of the user or doctor
 *         role:
 *           type: string
 *           enum: [patient, doctor]
 *           description: Role of the user
 *         token:
 *           type: string
 *           description: JWT authentication token
 *         device:
 *           type: string
 *           description: Device information
 *           default: unknown
 *         createdAt:
 *           type: string
 *           format: date-time
 *           description: Session creation timestamp (expires after 7 days)
 *       example:
 *         _id: 60d0fe4f5311236168a109cc
 *         userId: 60d0fe4f5311236168a109ca
 *         role: patient
 *         token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
 *         device: Mozilla/5.0 (Windows NT 10.0; Win64; x64)
 *         createdAt: 2023-05-01T10:30:00.000Z
 */
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