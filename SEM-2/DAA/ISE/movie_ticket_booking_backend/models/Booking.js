// models/Booking.js
const mongoose = require('mongoose');

const BookingSchema = new mongoose.Schema({
  user: { type: String, required: true }, // Can be user ID or username
  show: { type: mongoose.Schema.Types.ObjectId, ref: 'Show', required: true },
  seatNumbers: { type: [Number], required: true },
  totalPrice: Number,
  bookingTime: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Booking', BookingSchema);
