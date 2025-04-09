// models/Show.js
const mongoose = require('mongoose');

const ShowSchema = new mongoose.Schema({
  movie: { type: mongoose.Schema.Types.ObjectId, ref: 'Movie', required: true },
  theatre: { type: mongoose.Schema.Types.ObjectId, ref: 'Theatre', required: true },
  date: { type: Date, required: true },
  time: { type: String, required: true },
  price: { type: Number, required: true },
  // An array representing available seat numbers (e.g., 1 to 100)
  availableSeats: { type: [Number], default: [] },
});

module.exports = mongoose.model('Show', ShowSchema);
