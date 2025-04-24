// Advanced booking algorithms for movie ticket booking system

/**
 * 0/1 Knapsack algorithm for optimal seat selection
 * @param {Array} availableSeats - Array of available seats with properties
 * @param {Number} groupSize - Number of seats to select
 * @param {Number} budget - Maximum budget per seat
 * @param {Object} preferences - User preferences for seat selection
 * @returns {Array} - Selected seats
 */
const knapsackSeatSelection = (availableSeats, groupSize, budget, preferences) => {
  // If we have fewer available seats than needed, return what we have
  if (availableSeats.length < groupSize) {
    return availableSeats;
  }

  // Sort seats by preference score
  const scoredSeats = availableSeats.map(seat => {
    let score = 0;
    
    // Prefer seats in the same row
    if (preferences.preferredRow !== undefined) {
      const seatRow = Math.floor((seat.number - 1) / 10);
      if (seatRow === preferences.preferredRow) {
        score += 10;
      } else {
        // Penalize seats far from preferred row
        score -= Math.abs(seatRow - preferences.preferredRow);
      }
    }
    
    // Prefer seats based on view angle
    if (preferences.viewAngle) {
      const seatPosition = (seat.number - 1) % 10;
      if (preferences.viewAngle === 'Center') {
        // Prefer seats in the middle (positions 3-6)
        if (seatPosition >= 3 && seatPosition <= 6) {
          score += 5;
        }
      } else if (preferences.viewAngle === 'Left') {
        // Prefer seats on the left (positions 0-3)
        if (seatPosition <= 3) {
          score += 5;
        }
      } else if (preferences.viewAngle === 'Right') {
        // Prefer seats on the right (positions 7-9)
        if (seatPosition >= 7) {
          score += 5;
        }
      }
    }
    
    return { ...seat, score };
  });
  
  // Sort by score (highest first)
  scoredSeats.sort((a, b) => b.score - a.score);
  
  // Take the top seats up to groupSize
  return scoredSeats.slice(0, groupSize);
};

/**
 * Fractional Knapsack algorithm for dynamic pricing
 * @param {Array} seats - Array of seats with base prices
 * @param {Number} occupancyRate - Current occupancy rate (0-1)
 * @param {Object} factors - Additional pricing factors
 * @returns {Array} - Seats with adjusted prices
 */
const fractionalKnapsackPricing = (seats, occupancyRate, factors) => {
  // Base multiplier based on occupancy
  let baseMultiplier = 1.0;
  
  if (occupancyRate > 0.9) {
    baseMultiplier = 1.3; // High demand
  } else if (occupancyRate > 0.7) {
    baseMultiplier = 1.2; // Medium-high demand
  } else if (occupancyRate > 0.5) {
    baseMultiplier = 1.1; // Medium demand
  }
  
  // Apply time-based factors
  if (factors.isWeekend) {
    baseMultiplier += 0.1; // Weekend premium
  }
  
  if (factors.timeOfDay >= 18 || factors.timeOfDay <= 22) {
    baseMultiplier += 0.1; // Evening premium
  }
  
  // Apply pricing to each seat
  return seats.map(seat => {
    // Calculate seat-specific multiplier
    let seatMultiplier = baseMultiplier;
    
    // Premium for center seats - Fix calculation to use 0-indexed positions
    const seatPosition = (seat.number - 1) % 10;
    if (seatPosition >= 3 && seatPosition <= 6) {
      seatMultiplier += 0.1; // Center premium
    }
    
    // Calculate adjusted price
    const adjustedPrice = seat.basePrice * seatMultiplier;
    
    return {
      ...seat,
      adjustedPrice,
      multiplier: seatMultiplier
    };
  });
};

/**
 * Longest Common Subsequence algorithm for finding similar seat arrangements
 * @param {Array} selectedSeats - Array of selected seats
 * @param {Array} availableSeats - Array of available seats
 * @returns {Array} - Array of similar seat arrangements
 */
const lcsSeatSuggestions = (selectedSeats, availableSeats) => {
  // If we don't have enough seats for suggestions, return empty array
  if (availableSeats.length < selectedSeats.length) {
    return [];
  }
  
  // Group seats by row for easier comparison
  const selectedByRow = {};
  selectedSeats.forEach(seat => {
    const row = Math.floor((seat.number - 1) / 10);
    if (!selectedByRow[row]) {
      selectedByRow[row] = [];
    }
    selectedByRow[row].push(seat);
  });
  
  // Find similar arrangements
  const suggestions = [];
  
  // For each row in the selected seats
  Object.keys(selectedByRow).forEach(row => {
    const rowSeats = selectedByRow[row];
    const rowSize = rowSeats.length;
    
    // Get available seats in this row
    const availableInRow = availableSeats.filter(seat => 
      Math.floor((seat.number - 1) / 10) === parseInt(row)
    );
    
    // If we have enough seats in this row
    if (availableInRow.length >= rowSize) {
      // Find consecutive seats
      for (let i = 0; i <= availableInRow.length - rowSize; i++) {
        const consecutiveSeats = availableInRow.slice(i, i + rowSize);
        
        // Check if these seats are consecutive
        const isConsecutive = consecutiveSeats.every((seat, index) => {
          if (index === 0) return true;
          return seat.number === consecutiveSeats[index - 1].number + 1;
        });
        
        if (isConsecutive) {
          suggestions.push(consecutiveSeats);
        }
      }
    }
  });
  
  // Sort suggestions by similarity to original selection
  suggestions.sort((a, b) => {
    // Calculate similarity score based on position difference
    const scoreA = calculateSimilarityScore(selectedSeats, a);
    const scoreB = calculateSimilarityScore(selectedSeats, b);
    return scoreB - scoreA;
  });
  
  // Return top 3 suggestions
  return suggestions.slice(0, 3);
};

/**
 * Calculate similarity score between two seat arrangements
 * @param {Array} original - Original seat arrangement
 * @param {Array} suggestion - Suggested seat arrangement
 * @returns {Number} - Similarity score (higher is better)
 */
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

// Export the functions
module.exports = {
  knapsackSeatSelection,
  fractionalKnapsackPricing,
  lcsSeatSuggestions
}; 