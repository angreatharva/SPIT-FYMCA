// models/Theatre.js
const mongoose = require('mongoose');

const TheatreSchema = new mongoose.Schema({
  name: { type: String, required: true },
  location: String,
});

module.exports = mongoose.model('Theatre', TheatreSchema);
