const mongoose = require('mongoose');

const appointmentSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true },
  phone: { type: String, required: true },
  date: { type: Date, required: true },
  time: { type: String, required: true },
  age: { type: Number, required: true },
  gender: { type: String, required: true },
  therapy: { type: String, required: true },
  doctor: { type: String, required: true },
  message: { type: String }
});

const Appointment = mongoose.model('Appointment', appointmentSchema);

module.exports = Appointment;
