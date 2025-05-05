const mongoose = require("../config/db");
const { Schema } = mongoose;

/**
 * @swagger
 * components:
 *   schemas:
 *     CallRequest:
 *       type: object
 *       required:
 *         - patientId
 *         - doctorId
 *         - patientCallerId
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         patientId:
 *           type: string
 *           description: ID of the patient making the call request
 *         doctorId:
 *           type: string
 *           description: ID of the doctor being called
 *         patientCallerId:
 *           type: string
 *           description: Unique caller ID for the patient in the video call system
 *         status:
 *           type: string
 *           enum: [pending, accepted, rejected, completed]
 *           description: Current status of the call request
 *           default: pending
 *         requestedAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the call was requested
 *         completedAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the call was completed (if applicable)
 *       example:
 *         _id: 60d0fe4f5311236168a109ce
 *         patientId: 60d0fe4f5311236168a109ca
 *         doctorId: 60d0fe4f5311236168a109cb
 *         patientCallerId: patient-60d0fe4f5311236168a109ca
 *         status: pending
 *         requestedAt: 2023-05-15T14:30:00.000Z
 *         completedAt: null
 */
const callRequestSchema = new Schema({
  patientId: {
    type: Schema.Types.ObjectId,
    ref: 'userData',
    required: true
  },
  doctorId: {
    type: Schema.Types.ObjectId,
    ref: 'doctorData',
    required: true
  },
  patientCallerId: {
    type: String,
    required: true
  },
  status: {
    type: String,
    enum: ['pending', 'accepted', 'rejected', 'completed'],
    default: 'pending'
  },
  requestedAt: {
    type: Date,
    default: Date.now
  },
  completedAt: {
    type: Date
  }
});

const CallRequestModel = mongoose.model("callRequest", callRequestSchema, "callRequest");
module.exports = CallRequestModel; 