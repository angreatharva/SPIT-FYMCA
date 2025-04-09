// controllers/showController.js
const Show = require('../models/Show');

// Retrieve all shows, populated with movie and theatre details
exports.getAllShows = async (req, res) => {
  try {
    const shows = await Show.find().populate('movie').populate('theatre');
    res.json(shows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Create a new show
exports.createShow = async (req, res) => {
  try {
    const show = new Show(req.body);
    await show.save();
    res.status(201).json(show);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Book seats by removing the booked seats from availableSeats
exports.bookSeats = async (req, res) => {
  try {
    const show = await Show.findById(req.params.id);
    if (!show) return res.status(404).json({ message: 'Show not found' });

    const { seatNumbers } = req.body;
    // Check if all requested seats are available
    const available = seatNumbers.every(seat => show.availableSeats.includes(seat));
    if (!available) {
      return res.status(400).json({ message: 'Some seats are not available' });
    }

    // Remove booked seats
    show.availableSeats = show.availableSeats.filter(seat => !seatNumbers.includes(seat));
    await show.save();
    res.json({ message: 'Seats booked successfully', show });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
