const mongoose = require("../config/db");
const { Schema } = mongoose;

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