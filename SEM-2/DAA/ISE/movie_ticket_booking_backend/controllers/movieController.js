// controllers/movieController.js
const Movie = require('../models/Movie');

// Retrieve all movies
exports.getAllMovies = async (req, res) => {
  try {
    const movies = await Movie.find();
    res.json(movies);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Create a new movie
exports.createMovie = async (req, res) => {
  try {
    const movieData = { ...req.body };
    
    // If a file was uploaded, store its path
    if (req.file) {
      movieData.posterUrl = `/uploads/${req.file.filename}`;
    }
    
    const movie = new Movie(movieData);
    await movie.save();
    res.status(201).json(movie);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
