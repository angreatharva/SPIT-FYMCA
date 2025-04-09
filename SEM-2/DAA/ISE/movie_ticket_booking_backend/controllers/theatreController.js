// controllers/theatreController.js
const Theatre = require('../models/Theatre');

// Retrieve all theatres
exports.getAllTheatres = async (req, res) => {
  try {
    const theatres = await Theatre.find();
    res.json(theatres);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Create a new theatre
exports.createTheatre = async (req, res) => {
  try {
    const theatre = new Theatre(req.body);
    await theatre.save();
    res.status(201).json(theatre);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
