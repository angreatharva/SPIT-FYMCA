import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';
import '../models/booking.dart';
import '../models/seat.dart';
import '../models/show.dart';
import '../widgets/seat_widget.dart';
import 'booking_confirmation_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Show show;

  const SeatSelectionScreen({Key? key, required this.show}) : super(key: key);

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final BookingController _bookingController = BookingController();
  List<Seat> _seats = [];
  List<int> _selectedSeats = [];
  bool _isLoading = false;
  int _groupSize = 2; // Default group size
  final int _seatsPerRow = 10;
  double _priceMultiplier = 1.0; // Default price multiplier

  @override
  void initState() {
    super.initState();
    _initializeSeats();
    // Show dialog after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showGroupSizeDialog();
    });
  }

  void _initializeSeats() {
    // Create a list of 100 seats (typical for a theatre)
    final List<Seat> seats = List.generate(100, (index) {
      final seatNumber = index + 1;
      final isAvailable = widget.show.availableSeats.contains(seatNumber);
      return Seat(
        number: seatNumber,
        status: isAvailable ? SeatStatus.available : SeatStatus.taken,
      );
    });
    setState(() {
      _seats = seats;
      _calculatePriceMultiplier();
    });
  }

  // Calculate price multiplier based on seat availability
  void _calculatePriceMultiplier() {
    final totalSeats = _seats.length;
    final availableSeats = _seats.where((seat) => seat.status == SeatStatus.available).length;
    final percentageBooked = (totalSeats - availableSeats) / totalSeats;
    
    setState(() {
      // If 80% or more seats are booked, apply 1.2X price multiplier
      _priceMultiplier = percentageBooked >= 0.8 ? 1.2 : 1.0;
    });

    // Debug info
    print('Total seats: $totalSeats');
    print('Available seats: $availableSeats');
    print('Percentage booked: ${(percentageBooked * 100).toStringAsFixed(1)}%');
    print('Price multiplier: $_priceMultiplier');
  }

  // Calculate the current ticket price with multiplier
  double get currentTicketPrice => widget.show.price * _priceMultiplier;

  void _showGroupSizeDialog() {
    // Temporary state variable for the dialog's dropdown
    int tempGroupSize = _groupSize;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Use a StatefulWidget builder to manage the dropdown state within the dialog
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF222222), // Dark background
              title: const Text(
                'Select Number of Seats',
                style: TextStyle(color: Colors.white), // White title text
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How many seats would you like to book?',
                    style: TextStyle(color: Colors.white70), // Lighter content text
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: tempGroupSize,
                        dropdownColor: const Color(0xFF333333), // Dark dropdown background
                        style: const TextStyle(color: Colors.white), // White dropdown text
                        iconEnabledColor: Colors.white70,
                        isExpanded: true, // Make dropdown take available width
                        items: List.generate(10, (index) => index + 1)
                            .map((size) => DropdownMenuItem<int>(
                                  value: size,
                                  child: Text(
                                    '$size ${size == 1 ? 'seat' : 'seats'}',
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() { // Use setDialogState to update the dialog's UI
                              tempGroupSize = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display price information if applicable
                  if (_priceMultiplier > 1.0)
                    Text(
                      'High demand! Price is ${(_priceMultiplier * 100 - 100).toStringAsFixed(0)}% higher.',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white70), // Lighter cancel text
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red accent for the primary button
                  ),
                  onPressed: () {
                    // Update the actual group size state only when confirming
                    setState(() {
                      _groupSize = tempGroupSize;
                    });
                    Navigator.of(context).pop(); // Close the dialog
                    _findBestSeats(); // Find seats with the new group size
                  },
                  child: const Text('Find Best Seats'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Clear all selected seats
  void _clearSelectedSeats() {
    for (var seat in _seats) {
      if (seat.status == SeatStatus.selected) {
        seat.status = SeatStatus.available;
      }
    }
    _selectedSeats.clear();
  }

  // Find the best available seats
  void _findBestSeats() {
    // Reset any previously selected seats
    setState(() {
      _clearSelectedSeats();
    });
    
    // Get all available seats
    List<int> availableSeats = _seats
        .where((seat) => seat.status == SeatStatus.available)
        .map((seat) => seat.number)
        .toList();
    
    if (availableSeats.length < _groupSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Not enough available seats for a group of $_groupSize')),
      );
      return;
    }
    
    // Group available seats by rows
    Map<int, List<int>> availableRowsMap = {};
    for (int seatNumber in availableSeats) {
      int row = (seatNumber - 1) ~/ _seatsPerRow;
      if (!availableRowsMap.containsKey(row)) {
        availableRowsMap[row] = [];
      }
      availableRowsMap[row]!.add(seatNumber);
    }
    
    // Find consecutive seat blocks in each row
    Map<int, List<List<int>>> consecutiveBlocksByRow = {};
    
    for (int row in availableRowsMap.keys) {
      List<int> rowSeats = availableRowsMap[row]!..sort();
      List<List<int>> blocks = [];
      
      if (rowSeats.length >= _groupSize) {
        for (int i = 0; i <= rowSeats.length - _groupSize; i++) {
          bool isConsecutive = true;
          for (int j = 1; j < _groupSize; j++) {
            if (rowSeats[i + j] != rowSeats[i + j - 1] + 1) {
              isConsecutive = false;
              break;
            }
          }
          
          if (isConsecutive) {
            blocks.add(rowSeats.sublist(i, i + _groupSize));
          }
        }
      }
      
      if (blocks.isNotEmpty) {
        consecutiveBlocksByRow[row] = blocks;
      }
    }
    
    // If no consecutive blocks found
    if (consecutiveBlocksByRow.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No consecutive blocks of $_groupSize seats available')),
      );
      return;
    }
    
    // Priority order: center rows first
    List<int> rowPriority = [4, 5, 3, 6, 2, 7, 1, 8, 0, 9];
    
    List<int> selectedBlock = [];
    
    // Find the best block in priority rows
    for (int row in rowPriority) {
      if (consecutiveBlocksByRow.containsKey(row)) {
        // Get blocks in this row
        List<List<int>> blocks = consecutiveBlocksByRow[row]!;
        
        // Find the block closest to center of the row
        int centerSeat = row * _seatsPerRow + _seatsPerRow ~/ 2;
        List<int> bestBlock = blocks[0];
        int minDistance = 999;
        
        for (List<int> block in blocks) {
          int blockCenter = block[block.length ~/ 2];
          int distance = (blockCenter - centerSeat).abs();
          
          if (distance < minDistance) {
            minDistance = distance;
            bestBlock = block;
          }
        }
        
        selectedBlock = bestBlock;
        break;
      }
    }
    
    // Select the found seats
    setState(() {
      for (int seatNumber in selectedBlock) {
        int index = _seats.indexWhere((seat) => seat.number == seatNumber);
        if (index != -1) {
          _seats[index].status = SeatStatus.selected;
          _selectedSeats.add(seatNumber);
        }
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('We found $_groupSize best seats for you!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // This function selects a new group of consecutive seats starting from clickedSeatNumber
  void _selectConsecutiveSeats(int clickedSeatNumber) {
    // First, clear any existing selections
    setState(() {
      _clearSelectedSeats();
    });
    
    // Get the row and position in row of the clicked seat
    int row = (clickedSeatNumber - 1) ~/ _seatsPerRow;
    int posInRow = (clickedSeatNumber - 1) % _seatsPerRow;
    
    // We need to check if we can fit _groupSize consecutive seats starting from this position
    // Trying to first fill to the right, then to the left if not enough space
    List<int> possibleSeats = [];
    
    // Try to select seats to the right
    int remainingRight = _seatsPerRow - posInRow;
    for (int i = 0; i < min(remainingRight, _groupSize); i++) {
      int seatNum = clickedSeatNumber + i;
      int index = _seats.indexWhere((seat) => seat.number == seatNum);
      
      if (index != -1 && _seats[index].status == SeatStatus.available) {
        possibleSeats.add(seatNum);
      } else {
        break; // Hit an unavailable seat
      }
    }
    
    // If we didn't get enough seats going right, try to fill from the left
    if (possibleSeats.length < _groupSize) {
      // Reset and start again from the clicked seat
      possibleSeats = [clickedSeatNumber];
      
      int index = _seats.indexWhere((seat) => seat.number == clickedSeatNumber);
      if (index == -1 || _seats[index].status != SeatStatus.available) {
        return; // Clicked seat is not available
      }
      
      // Try left
      for (int i = 1; i < _groupSize; i++) {
        int seatNum = clickedSeatNumber - i;
        // Make sure we're still in the same row
        if ((seatNum - 1) ~/ _seatsPerRow != row) break;
        
        int index = _seats.indexWhere((seat) => seat.number == seatNum);
        if (index != -1 && _seats[index].status == SeatStatus.available) {
          possibleSeats.insert(0, seatNum); // Insert at the beginning to maintain order
        } else {
          break; // Hit an unavailable seat
        }
      }
      
      // If we still don't have enough seats going left, try to fill from the right
      if (possibleSeats.length < _groupSize) {
        for (int i = 1; i < _groupSize - possibleSeats.length + 1; i++) {
          int seatNum = clickedSeatNumber + i;
          // Make sure we're still in the same row
          if ((seatNum - 1) ~/ _seatsPerRow != row) break;
          
          int index = _seats.indexWhere((seat) => seat.number == seatNum);
          if (index != -1 && _seats[index].status == SeatStatus.available) {
            possibleSeats.add(seatNum);
          } else {
            break; // Hit an unavailable seat
          }
        }
      }
    }
    
    // If we couldn't get enough seats
    if (possibleSeats.length < _groupSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot select $_groupSize consecutive seats from this position')),
      );
      return;
    }
    
    // If we got more than needed, trim the list
    if (possibleSeats.length > _groupSize) {
      // Prioritize keeping the clicked seat
      int clickedIndex = possibleSeats.indexOf(clickedSeatNumber);
      int startIndex = 0;
      
      // Try to keep the clicked seat in the selection
      if (clickedIndex + _groupSize <= possibleSeats.length) {
        startIndex = clickedIndex;
      } else {
        // If not possible, take the first _groupSize seats
        startIndex = 0;
      }
      
      possibleSeats = possibleSeats.sublist(startIndex, startIndex + _groupSize);
    }
    
    // Select the final seats
      setState(() {
      for (int seatNumber in possibleSeats) {
        int index = _seats.indexWhere((seat) => seat.number == seatNumber);
        if (index != -1) {
          _seats[index].status = SeatStatus.selected;
          _selectedSeats.add(seatNumber);
        }
      }
    });
  }

  // When a seat is tapped
  void _onSeatTap(int seatNumber) {
    int index = _seats.indexWhere((seat) => seat.number == seatNumber);
    if (index == -1) return;
    
    Seat seat = _seats[index];
    
    if (seat.status == SeatStatus.available) {
      _selectConsecutiveSeats(seatNumber);
    } else if (seat.status == SeatStatus.selected) {
      // If tapping a selected seat, do nothing
      // Alternatively, you could implement logic to deselect all seats
      // setState(() {
      //   _clearSelectedSeats();
      // });
    }
  }

  void _bookTickets() async {
    if (_selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one seat')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create booking with adjusted price
      final booking = Booking(
        user: 'current_user', // In a real app, this would be the logged-in user's ID
        showId: widget.show.id,
        seatNumbers: _selectedSeats,
        totalPrice: _selectedSeats.length * currentTicketPrice,
      );

      final createdBooking = await _bookingController.createBooking(booking);

      // Navigate to confirmation screen
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(booking: createdBooking),
        ),
            (route) => route.isFirst,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  int min(int a, int b) {
    return a < b ? a : b;
  }

  @override
  Widget build(BuildContext context) {
    final movieTitle = widget.show.movie?.title ?? 'Movie';
    final theatreName = widget.show.theatre?.name ?? 'Theatre';
    final showDate = DateFormat('E, MMM d').format(widget.show.date);
    final totalPrice = _selectedSeats.length * currentTicketPrice;
    
    // Calculate occupancy percentage
    final totalSeats = _seats.length;
    final bookedSeats = _seats.where((seat) => seat.status == SeatStatus.taken).length;
    final occupancyPercentage = (bookedSeats / totalSeats * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats'),
        actions: [
          IconButton(
            icon: Icon(Icons.group),
            onPressed: _showGroupSizeDialog,
            tooltip: 'Change number of seats',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: Column(
              children: [
                Text(
                  movieTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$theatreName - $showDate - ${widget.show.time}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                // Show occupancy and price information
                _priceMultiplier > 1.0
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Theater is $occupancyPercentage% full! Prices are ${(_priceMultiplier * 100 - 100).toStringAsFixed(0)}% higher',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Screen indicator
          Center(
            child: Container(
              width: 240,
              height: 20,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.red.withOpacity(0.8),
                    width: 3,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  'SCREEN',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Seat counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected: ${_selectedSeats.length}/$_groupSize seats',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text('Reset Selection'),
                  onPressed: _findBestSeats,
                ),
              ],
            ),
          ),
          
          // Seats grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: _seats.length,
                itemBuilder: (context, index) {
                  final seat = _seats[index];
                  return SeatWidget(
                    seat: seat,
                    onTap: () {
                      if (seat.status != SeatStatus.taken) {
                        _onSeatTap(seat.number);
                      }
                    },
                  );
                },
              ),
            ),
          ),
          // Legend
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('Available'),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('Taken'),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('Selected'),
                  ],
                ),
              ],
            ),
          ),
          // Location and price
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF222222),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.white70),
                        SizedBox(width: 4),
                        Text(theatreName),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mykola Ovodova 51,Vinnista, Vinnista region',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                    ),
                    // Show ticket price breakdown
                    Text(
                      '${_selectedSeats.length} × \$${currentTicketPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                    if (_priceMultiplier > 1.0)
                      Text(
                        'High demand: +${(_priceMultiplier * 100 - 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.amber,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Book button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: _selectedSeats.isNotEmpty ? _bookTickets : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                disabledBackgroundColor: Colors.grey,
              ),
              child: Text(
                'Buy Ticket\$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
