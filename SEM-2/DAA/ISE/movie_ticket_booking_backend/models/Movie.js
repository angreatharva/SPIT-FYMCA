// models/Movie.js
const mongoose = require('mongoose');

const MovieSchema = new mongoose.Schema({
  title: { type: String, required: true },
  genre: String,
  duration: Number, // in minutes
  rating: Number,   // average rating
  description: String,
  posterUrl: String,
});

module.exports = mongoose.model('Movie', MovieSchema);
