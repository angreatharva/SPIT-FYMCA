// controllers/bookingController.js
const Booking = require('../models/Booking');
const Show = require('../models/Show');
const { knapsackSeatSelection, fractionalKnapsackPricing, lcsSeatSuggestions } = require('../utils/bookingAlgorithms');

// Create a new booking
exports.createBooking = async (req, res) => {
  try {
    const { user, showId, seatNumbers, totalPrice } = req.body;
    const show = await Show.findById(showId);
    if (!show) {
      return res.status(404).json({ message: 'Show not found' });
    }

    // Check if all requested seats are available
    const isAvailable = seatNumbers.every(seat => show.availableSeats.includes(seat));
    if (!isAvailable) {
      return res.status(400).json({ message: 'Some seats are already booked' });
    }

    // Update available seats by removing the selected ones
    show.availableSeats = show.availableSeats.filter(seat => !seatNumbers.includes(seat));
    await show.save();

    const booking = new Booking({
      user,
      show: show._id,
      seatNumbers,
      totalPrice,
    });
    await booking.save();

    res.status(201).json({ message: 'Booking successful', booking });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Retrieve all bookings with show details
exports.getAllBookings = async (req, res) => {
  try {
    const bookings = await Booking.find().populate({
      path: 'show',
      populate: [{ path: 'movie' }, { path: 'theatre' }],
    });
    res.json(bookings);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Retrieve bookings for a specific user
exports.getUserBookings = async (req, res) => {
  try {
    const { userId } = req.params;
    const bookings = await Booking.find({ user: userId }).populate({
      path: 'show',
      populate: [{ path: 'movie' }, { path: 'theatre' }],
    });
    res.json(bookings);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Find optimal seats based on user preferences using Knapsack algorithm
exports.findOptimalSeats = async (req, res) => {
  try {
    const { showId, groupSize, budget, preferences } = req.body;
    
    // Validate required inputs
    if (!showId || !groupSize || !budget) {
      return res.status(400).json({ message: 'Missing required parameters: showId, groupSize, and budget are required' });
    }
    
    const show = await Show.findById(showId);
    if (!show) {
      return res.status(404).json({ message: 'Show not found' });
    }
    
    // Format available seats for the algorithm
    const availableSeats = show.availableSeats.map(seatNumber => ({
      number: seatNumber,
      basePrice: show.price
    }));
    
    // Use knapsack algorithm to find optimal seats
    const selectedSeats = knapsackSeatSelection(availableSeats, groupSize, budget, preferences || {});
    
    if (selectedSeats.length < groupSize) {
      // If we can't find enough optimal seats, try to find alternative suggestions
      const alternatives = lcsSeatSuggestions(selectedSeats, availableSeats);
      
      return res.json({
        success: false,
        message: 'Not enough optimal seats found. Consider these alternatives:',
        selectedSeats,
        alternatives,
      });
    }
    
    // Calculate the total price based on dynamic pricing
    const totalCapacity = 100; // Assuming total capacity is 100 seats
    const occupancyRate = (totalCapacity - show.availableSeats.length) / totalCapacity;
    
    // Get current day and time for pricing factors
    const now = new Date();
    const isWeekend = now.getDay() === 0 || now.getDay() === 6; // Sunday or Saturday
    const timeOfDay = now.getHours();
    
    const pricedSeats = fractionalKnapsackPricing(selectedSeats, occupancyRate, { isWeekend, timeOfDay });
    const totalPrice = pricedSeats.reduce((sum, seat) => sum + seat.adjustedPrice, 0);
    
    res.json({
      success: true,
      seats: pricedSeats,
      totalPrice,
      occupancyRate,
      pricingFactors: { isWeekend, timeOfDay }
    });
    
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Get dynamic pricing details for selected seats
exports.getPricingDetails = async (req, res) => {
  try {
    const { showId, seatNumbers } = req.body;
    
    if (!showId || !seatNumbers || !Array.isArray(seatNumbers)) {
      return res.status(400).json({ message: 'Missing required parameters: showId and seatNumbers (array) are required' });
    }
    
    const show = await Show.findById(showId);
    if (!show) {
      return res.status(404).json({ message: 'Show not found' });
    }
    
    // Check if all requested seats are available
    const isAvailable = seatNumbers.every(seat => show.availableSeats.includes(seat));
    if (!isAvailable) {
      return res.status(400).json({ message: 'Some seats are already booked' });
    }
    
    // Format seats for the pricing algorithm
    const seatsToPrice = seatNumbers.map(seatNumber => ({
      number: seatNumber,
      basePrice: show.price
    }));
    
    // Calculate occupancy rate for dynamic pricing
    const totalCapacity = 100; // Assuming total capacity is 100 seats
    const occupancyRate = (totalCapacity - show.availableSeats.length) / totalCapacity;
    
    // Get current day and time for pricing factors
    const now = new Date();
    const isWeekend = now.getDay() === 0 || now.getDay() === 6; // Sunday or Saturday
    const timeOfDay = now.getHours();
    
    // Apply dynamic pricing using Fractional Knapsack algorithm
    const pricedSeats = fractionalKnapsackPricing(seatsToPrice, occupancyRate, { isWeekend, timeOfDay });
    const totalPrice = pricedSeats.reduce((sum, seat) => sum + seat.adjustedPrice, 0);
    
    res.json({
      success: true,
      basePrice: show.price,
      pricedSeats,
      totalPrice,
      occupancyRate,
      pricingFactors: { isWeekend, timeOfDay }
    });
    
  } catch (error) {
    console.error('Error getting pricing details:', error);
    res.status(500).json({ message: 'Error getting pricing details', error: error.message });
  }
};

// Get alternative seat suggestions
exports.getAlternativeSeatSuggestions = async (req, res) => {
  try {
    const { showId, selectedSeats } = req.body;
    
    if (!showId || !selectedSeats || !Array.isArray(selectedSeats) || selectedSeats.length === 0) {
      return res.status(400).json({ message: 'Show ID and selected seats are required' });
    }
    
    // Get the show to access available seats
    const show = await Show.findById(showId);
    if (!show) {
      return res.status(404).json({ message: 'Show not found' });
    }
    
    // Format selected seats for the algorithm
    const formattedSelectedSeats = selectedSeats.map(seatNumber => ({
      number: seatNumber,
      basePrice: show.price
    }));
    
    // Get available seats from the show
    const availableSeats = show.availableSeats.map(seatNumber => ({
      number: seatNumber,
      basePrice: show.price
    }));
    
    // Get alternative suggestions using LCS algorithm
    const rawSuggestions = lcsSeatSuggestions(formattedSelectedSeats, availableSeats);
    
    // Format suggestions for the frontend
    const suggestions = rawSuggestions.map((suggestion, index) => {
      // Extract just the seat numbers
      const seats = suggestion.map(seat => seat.number);
      
      // Calculate similarity score (0-1)
      const similarityScore = calculateSimilarityScore(formattedSelectedSeats, suggestion) / 100;
      
      return {
        id: index + 1,
        seats,
        similarityScore
      };
    });
    
    res.json({ suggestions });
  } catch (error) {
    console.error('Error getting alternative seat suggestions:', error);
    res.status(500).json({ message: 'Error getting alternative seat suggestions', error: error.message });
  }
};

// Helper function to calculate similarity score
function calculateSimilarityScore(original, suggestion) {
  if (original.length !== suggestion.length) {
    return 0;
  }
  
  // Calculate average position difference
  let totalDiff = 0;
  for (let i = 0; i < original.length; i++) {
    totalDiff += Math.abs(original[i].number - suggestion[i].number);
  }
  
  const avgDiff = totalDiff / original.length;
  
  // Convert to a score (lower difference = higher score)
  return 100 - avgDiff;
}
