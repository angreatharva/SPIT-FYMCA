// controllers/bookingController.js
const Booking = require('../models/Booking');
const Show = require('../models/Show');

// Create a new booking
exports.createBooking = async (req, res) => {
  try {
    const { user, showId, seatNumbers, groupSize } = req.body;
    const show = await Show.findById(showId);
    if (!show) {
      return res.status(404).json({ message: 'Show not found' });
    }

    let selectedSeats = [];
    
    // If explicit seat numbers are provided, use them.
    if (seatNumbers && seatNumbers.length > 0) {
      // Check if all requested seats are available
      const isAvailable = seatNumbers.every(seat => show.availableSeats.includes(seat));
      if (!isAvailable) {
        return res.status(400).json({ message: 'Some seats are already booked' });
      }
      selectedSeats = seatNumbers;
    } 
    // Else, if a group size is provided, use the algorithm to find an optimal contiguous block.
    else if (groupSize) {
      selectedSeats = findOptimalContiguousSeats(show.availableSeats, groupSize);
      if (selectedSeats.length !== groupSize) {
        return res.status(400).json({ message: 'Not enough contiguous seats available' });
      }
    } 
    else {
      return res.status(400).json({ message: 'No seat selection provided' });
    }

    // Update available seats by removing the selected ones
    show.availableSeats = show.availableSeats.filter(seat => !selectedSeats.includes(seat));
    
    // ===== Dynamic Pricing Calculation =====
    // Assume a fixed total capacity for the show (for demonstration, totalCapacity = 100)
    const totalCapacity = 100;
    // Calculate current occupancy BEFORE booking these seats.
    const currentOccupied = totalCapacity - show.availableSeats.length;
    const occupancyRate = currentOccupied / totalCapacity;
    // Adjust the price per seat based on occupancy demand.
    const finalPricePerSeat = dynamicPriceAdjustment(show.price, occupancyRate);
    // Calculate total price with adjusted price.
    const totalPrice = selectedSeats.length * finalPricePerSeat;

    await show.save();

    const booking = new Booking({
      user,
      show: show._id,
      seatNumbers: selectedSeats,
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

/**
 * findOptimalContiguousSeats:
 * Finds all contiguous blocks of available seats of size groupSize,
 * then returns the block whose average seat number is closest to the ideal center.
 *
 * Assumes availableSeats is an array of seat numbers.
 */
function findOptimalContiguousSeats(availableSeats, groupSize) {
  // Sort the available seats to ensure they're in order
  const sortedSeats = [...availableSeats].sort((a, b) => a - b);
  let blocks = [];

  // Iterate to find all contiguous blocks of desired size
  for (let i = 0; i <= sortedSeats.length - groupSize; i++) {
    let block = [sortedSeats[i]];
    for (let j = i + 1; j < sortedSeats.length; j++) {
      if (sortedSeats[j] === block[block.length - 1] + 1) {
        block.push(sortedSeats[j]);
        if (block.length === groupSize) {
          blocks.push([...block]);
          break; // Break out once a full block is found starting at index i.
        }
      } else {
        break; // No longer contiguous
      }
    }
  }
  if (blocks.length === 0) return [];

  // Define an ideal center seat (assuming total capacity of 100)
  const totalCapacity = 100;
  const idealCenter = Math.floor(totalCapacity / 2);

  // Pick the block whose average is closest to the ideal center
  let bestBlock = blocks[0];
  let bestDistance = Math.abs(average(bestBlock) - idealCenter);

  for (const block of blocks) {
    const distance = Math.abs(average(block) - idealCenter);
    if (distance < bestDistance) {
      bestDistance = distance;
      bestBlock = block;
    }
  }
  return bestBlock;
}

// Helper function to compute the average of a list of numbers.
function average(arr) {
  return arr.reduce((sum, val) => sum + val, 0) / arr.length;
}

/**
 * dynamicPriceAdjustment:
 * Adjusts the base price based on current occupancy rate.
 * For example, if occupancyRate >= 0.8, the price is increased by 20%.
 */
function dynamicPriceAdjustment(basePrice, occupancyRate) {
  if (occupancyRate >= 0.8) {
    return basePrice * 1.2;
  }
  return basePrice;
}
