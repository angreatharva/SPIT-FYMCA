// routes/bookingRoutes.js
const express = require('express');
const router = express.Router();
const bookingController = require('../controllers/bookingController');

// Get all bookings
router.get('/', bookingController.getAllBookings);

// Get user bookings
router.get('/user/:userId', bookingController.getUserBookings);

// Find optimal seats based on preferences using knapsack algorithm
router.post('/find-optimal-seats', bookingController.findOptimalSeats);

// Get pricing details for selected seats
router.post('/pricing-details', bookingController.getPricingDetails);

// Get alternative seat suggestions
router.post('/alternative-suggestions', bookingController.getAlternativeSeatSuggestions);

// Create a new booking
router.post('/', bookingController.createBooking);

module.exports = router;
