import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';
import '../controllers/show_controller.dart';
import '../models/booking.dart';
import '../models/seat.dart';
import '../models/show.dart';
import '../widgets/seat_widget.dart';
import 'booking_confirmation_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String showId;
  final String movieTitle;
  final List<int>? preselectedSeats;

  const SeatSelectionScreen({
    Key? key, 
    required this.showId, 
    required this.movieTitle,
    this.preselectedSeats,
  }) : super(key: key);

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final BookingController _bookingController = BookingController();
  final ShowController _showController = ShowController();
  List<Seat> _seats = [];
  List<int> _selectedSeats = [];
  bool _isLoading = false;
  int _groupSize = 2; // Default group size
  final int _seatsPerRow = 10;
  double _priceMultiplier = 1.0; // Default price multiplier
  double _occupancyRate = 0.0; // Add this line to store occupancy rate
  Show? _show;
  bool _isWeekend = false;
  bool _isPeakHour = false;

  @override
  void initState() {
    super.initState();
    _loadShowDetails();
  }

  Future<void> _loadShowDetails() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final shows = await _showController.getAllShows();
      final show = shows.firstWhere((s) => s.id == widget.showId);
      
      setState(() {
        _show = show;
        _initializeSeats();
        
        // Check if theater is full immediately after loading seats
        int availableSeatsCount = _seats.where((seat) => seat.status == SeatStatus.available).length;
        if (availableSeatsCount == 0) {
          // If no seats available, show a persistent message at the top of the screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('This showing is completely sold out.'),
                duration: Duration(days: 1), // Effectively permanent until dismissed
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Close',
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to previous screen
                  },
                ),
              ),
            );
          });
        } else if (widget.preselectedSeats != null && widget.preselectedSeats!.isNotEmpty) {
          // Apply preselected seats if provided
          for (int seatNumber in widget.preselectedSeats!) {
            int index = _seats.indexWhere((seat) => seat.number == seatNumber);
            if (index != -1 && _seats[index].status == SeatStatus.available) {
              _seats[index].status = SeatStatus.selected;
              _selectedSeats.add(seatNumber);
            }
          }
          _groupSize = _selectedSeats.length;
        } else if (availableSeatsCount > 0) {
          // Only show dialog after the screen is built if theater is not full and no preselected seats
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showGroupSizeDialog();
          });
        }
        
        _isLoading = false;
      });
    } catch (e) {
      print("error${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading show details: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initializeSeats() {
    if (_show == null) return;
    
    // Create a list of 100 seats (typical for a theatre)
    final List<Seat> seats = List.generate(100, (index) {
      final seatNumber = index + 1;
      final isAvailable = _show!.availableSeats.contains(seatNumber);
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
    final occupancyRate = (totalSeats - availableSeats) / totalSeats;
    
    // Use the same pricing logic as the backend
    double baseMultiplier = 1.0;
    
    // Base multiplier based on occupancy
    if (occupancyRate > 0.9) {
      baseMultiplier = 1.3; // High demand
    } else if (occupancyRate > 0.7) {
      baseMultiplier = 1.2; // Medium-high demand
    } else if (occupancyRate > 0.5) {
      baseMultiplier = 1.1; // Medium demand
    }
    
    // Apply time-based factors
    final now = DateTime.now();
    final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
    final currentHour = now.hour;
    
    if (isWeekend) {
      baseMultiplier += 0.1; // Weekend premium
    }
    
    if (currentHour >= 18 && currentHour <= 22) {
      baseMultiplier += 0.1; // Evening premium
    }
    
    // Apply the multiplier
    setState(() {
      _priceMultiplier = baseMultiplier;
      _isWeekend = isWeekend;
      _isPeakHour = (currentHour >= 18 && currentHour <= 22);
      _occupancyRate = occupancyRate;
    });

    // Debug info
    print('Total seats: $totalSeats');
    print('Available seats: $availableSeats');
    print('Occupancy rate: ${(occupancyRate * 100).toStringAsFixed(1)}%');
    print('Is weekend: $_isWeekend');
    print('Current hour: $currentHour (peak: $_isPeakHour)');
    print('Price multiplier: $_priceMultiplier');
  }

  // Calculate adjusted price for individual seats
  double getAdjustedSeatPrice(int seatNumber) {
    // Base price with occupancy and time multiplier
    double price = _show!.price * _priceMultiplier;
    
    // Apply center seat premium if applicable
    final row = (seatNumber - 1) ~/ _seatsPerRow; // Get the row (0-indexed)
    final seatPosition = (seatNumber - 1) % _seatsPerRow; // Get position in row (0-indexed)
    
    // Center seats are typically positions 3,4,5,6 (in a 0-9 indexed row)
    if (seatPosition >= 3 && seatPosition <= 6) {
      price = price * 1.1; // 10% premium for center seats
    }
    
    return price;
  }
  
  // Calculate total price for selected seats with all factors
  double calculateTotalPrice() {
    if (_selectedSeats.isEmpty) return 0.0;
    
    double total = 0.0;
    for (int seatNumber in _selectedSeats) {
      total += getAdjustedSeatPrice(seatNumber);
    }
    
    return total;
  }

  // Calculate the current ticket price with multiplier
  double get currentTicketPrice => _show!.price * _priceMultiplier;

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
                  // Display price information based on factors
                  if (_priceMultiplier > 1.0) ...[
                    if (_occupancyRate > 0.0)
                      Text(
                        'High demand! Price is ${(_priceMultiplier * 100 - 100).toStringAsFixed(0)}% higher.',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (_isWeekend)
                      Text(
                        'Weekend pricing: +10%',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (_isPeakHour)
                      Text(
                        'Evening hour pricing: +10%',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
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
        // For a row with 10 seats (1-10), the center is between seats 5 and 6
        // So we calculate the center as row * _seatsPerRow + (_seatsPerRow / 2) + 0.5
        // This gives us 5.5 for the first row, which is between seats 5 and 6
        double exactCenter = row * _seatsPerRow + (_seatsPerRow / 2) + 0.5;
        List<int> bestBlock = blocks[0];
        double minDistance = 999;
        
        for (List<int> block in blocks) {
          // Calculate the center of the block as the average of all seat numbers
          double blockCenter = block.reduce((a, b) => a + b) / block.length;
          double distance = (blockCenter - exactCenter).abs();
          
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

  // Find optimal seats using the knapsack algorithm from the backend
  Future<void> _findOptimalSeats() async {
    if (_show == null) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Calculate budget based on maximum price per seat
      double budget = _show!.price * 1.5; // Allow for premium pricing up to 50% more
      
      // Gather user preferences
      Map<String, dynamic> preferences = await _showPreferencesDialog();
      if (preferences.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return; // User cancelled the dialog
      }
      
      final result = await _bookingController.findOptimalSeats(
        showId: _show!.id,
        groupSize: _groupSize,
        budget: budget,
        preferences: preferences,
      );
      
      if (result['success'] == true) {
        // Reset any previously selected seats
        _clearSelectedSeats();
        
        // Extract the seat numbers from the result
        final List<dynamic> pricedSeats = result['seats'];
        List<int> optimalSeatNumbers = [];
        
        for (var seat in pricedSeats) {
          int seatNumber = seat['number'];
          optimalSeatNumbers.add(seatNumber);
          
          // Log the seat's adjusted price for debugging
          print('Seat $seatNumber price: ${seat['adjustedPrice']}');
        }
        
        // Update the UI with the selected seats
        setState(() {
          for (int seatNumber in optimalSeatNumbers) {
            int index = _seats.indexWhere((seat) => seat.number == seatNumber);
            if (index != -1) {
              _seats[index].status = SeatStatus.selected;
              _selectedSeats.add(seatNumber);
            }
          }
          
          // Show a message with the total price
          double totalPrice = result['totalPrice'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'We found $_groupSize optimal seats for you! Total: ₹${totalPrice.toStringAsFixed(2)}',
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        });
      } else {
        // If not enough optimal seats found, show alternative suggestions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Could not find optimal seats'),
            duration: const Duration(seconds: 3),
          ),
        );
        
        // Try the local algorithm as a fallback
        _findBestSeats();
      }
    } catch (e) {
      print('Error finding optimal seats: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error finding optimal seats. Trying alternative method...'),
          duration: const Duration(seconds: 2),
        ),
      );
      
      // Fall back to the local algorithm
      _findBestSeats();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  // Show a dialog to collect user preferences for seat selection
  Future<Map<String, dynamic>> _showPreferencesDialog() async {
    int preferredRow = 4; // Default to middle row
    String viewAngle = 'Center'; // Default to center view
    bool? result;
    
    // Wait for the dialog result
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xff222222),
              title: Text('Seat Preferences',style: TextStyle(color: Colors.white),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AI will recommend seats based on your preferences:'),
                  SizedBox(height: 16),
                  
                  Text('Preferred Row:'),
                  DropdownButton<int>(
                    value: preferredRow,
                    isExpanded: true,
                    items: List.generate(10, (index) {
                      // Map row numbers 0-9 to more user-friendly labels
                      String rowLabel;
                      if (index < 3) rowLabel = 'Front (Row ${index + 1})';
                      else if (index < 7) rowLabel = 'Middle (Row ${index + 1})';
                      else rowLabel = 'Back (Row ${index + 1})';
                      
                      return DropdownMenuItem(
                        value: index,
                        child: Text(rowLabel,style: TextStyle(color: Colors.white),),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        preferredRow = value!;
                      });
                    },
                  ),
                  
                  SizedBox(height: 16),
                  Text('View Angle:'),
                  DropdownButton<String>(
                    value: viewAngle,
                    isExpanded: true,
                    items: ['Left', 'Center', 'Right'].map((angle) {
                      return DropdownMenuItem(
                        value: angle,
                        child: Text(angle,style: TextStyle(color: Colors.white),),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        viewAngle = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    result = false;
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    result = true;
                  },
                  child: Text('Find Seats'),
                ),
              ],
            );
          },
        );
      },
    );
    
    if (result == true) {
      return {
        'preferredRow': preferredRow,
        'viewAngle': viewAngle,
      };
    } else {
      return {}; // Empty map means user cancelled
    }
  }

  // Get dynamic pricing details from the backend
  Future<void> _getDynamicPricing() async {
    if (_show == null || _selectedSeats.isEmpty) return;
    
    try {
      final result = await _bookingController.getPricingDetails(
        showId: _show!.id,
        seatNumbers: _selectedSeats,
      );
      
      if (result['success'] == true) {
        final basePrice = result['basePrice'];
        final List<dynamic> pricedSeats = result['pricedSeats'];
        final totalPrice = result['totalPrice'];
        
        // Show a dialog with the pricing breakdown
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xFF222222),
              title: Text('Dynamic Pricing Details',style: TextStyle(color: Colors.white),),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Base price: ₹${basePrice.toStringAsFixed(2)}'),
                    Divider(),
                    ...pricedSeats.map<Widget>((seat) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Seat ${seat['number']}:'),
                            Text('₹${seat['adjustedPrice'].toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    }).toList(),
                    Divider(thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total price:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('₹${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text('Pricing Factors:'),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16,color:Colors.white),
                        SizedBox(width: 4),
                        Text('Occupancy: ${(result['occupancyRate'] * 100).toStringAsFixed(0)}%'),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16,color:Colors.white),
                        SizedBox(width: 4),
                        Text('Weekend: ${result['pricingFactors']['isWeekend'] ? 'Yes' : 'No'}'),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16,color:Colors.white),
                        SizedBox(width: 4),
                        Text('Time: ${result['pricingFactors']['timeOfDay']}:00'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error getting pricing details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting pricing details: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
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
      // Calculate the total price using our local method that matches backend logic
      final calculatedTotalPrice = calculateTotalPrice();
      
      print('Total price calculated client-side: $calculatedTotalPrice');
      
      // Create booking with our calculated price
      final booking = Booking(
        user: 'current_user', // In a real app, this would be the logged-in user's ID
        showId: widget.showId,
        seatNumbers: _selectedSeats,
        totalPrice: calculatedTotalPrice,
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
      print("Booking error: $e");
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

  // Get alternative seat suggestions using LCS algorithm
  Future<void> _getAlternativeSuggestions() async {
    if (_selectedSeats.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _bookingController.getAlternativeSeatSuggestions(
        showId: widget.showId,
        selectedSeats: _selectedSeats,
      );

      if (result.containsKey('suggestions') && result['suggestions'] is List) {
        List<dynamic> suggestions = result['suggestions'];
        if (suggestions.isNotEmpty) {
          _showAlternativeSuggestions(suggestions);
        }
      }
    } catch (e) {
      print('Error getting seat suggestions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get alternative seat suggestions')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Show a dialog with alternative seat suggestions
  void _showAlternativeSuggestions(List<dynamic> suggestions) {
    if (!mounted) return;
    
    showDialog(
      // barrierColor: Colors.black,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF222222),
        title: Text(
          'Alternative Seating Options',
          style: TextStyle(color: Colors.red),
        ),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: min(suggestions.length, 3),
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              final List<dynamic> seats = suggestion['seats'];
              // Safe conversion of similarityScore to double
              final double similarityScore = suggestion['similarityScore'] != null 
                  ? (suggestion['similarityScore'] is int 
                      ? (suggestion['similarityScore'] as int).toDouble() 
                      : suggestion['similarityScore'] as double)
                  : 0.0;
              
              return Card(
                color: Colors.black87, 
                margin: EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.red.withOpacity(0.5), width: 1), // Red border
                ),
                child: ListTile(
                  title: Text(
                    'Option ${index + 1}',
                    style: TextStyle(color: Colors.red), // Red title text
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${seats.length} seats',
                        style: TextStyle(color: Colors.white), // White text
                      ),
                      Text(
                        'Similarity: ${(similarityScore * 100).toStringAsFixed(0)}%',
                        style: TextStyle(color: Colors.white), // White text
                      ),
                      Text(
                        'Seats: ${seats.join(", ")}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white), // White text
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red button
                      foregroundColor: Colors.white, // White text
                    ),
                    child: Text('Select'),
                    onPressed: () {
                      setState(() {
                        // Clear current selections
                        _clearSelectedSeats();
                        
                        // Select the suggested seats
                        for (var seatNumber in seats) {
                          int index = _seats.indexWhere((seat) => seat.number == seatNumber);
                          if (index != -1) {
                            _seats[index].status = SeatStatus.selected;
                            _selectedSeats.add(seatNumber);
                          }
                        }
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // Red text
            ),
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_show == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Select Seats')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final movieTitle = widget.movieTitle;
    final theatreName = _show!.theatre?.name ?? 'Theatre';
    final showDate = DateFormat('E, MMM d').format(_show!.date);
    
    // Calculate accurate price with all factors
    final basePrice = _show!.price;
    final dynamicPrice = calculateTotalPrice();
    
    // Calculate occupancy percentage
    final totalSeats = _seats.length;
    final bookedSeats = _seats.where((seat) => seat.status == SeatStatus.taken).length;
    final availableSeats = _seats.where((seat) => seat.status == SeatStatus.available).length;
    final occupancyPercentage = (bookedSeats / totalSeats * 100).toStringAsFixed(0);
    final isSoldOut = availableSeats == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats'),
        actions: [
          // Only show group size button if no preselected seats and there are available seats
          if (widget.preselectedSeats == null && !isSoldOut)
            IconButton(
              icon: Icon(Icons.group),
              onPressed: _showGroupSizeDialog,
              tooltip: 'Change number of seats',
            ),
          // Add button for alternative seat suggestions
          if (_selectedSeats.isNotEmpty)
            IconButton(
              icon: Icon(Icons.swap_horiz),
              onPressed: _getAlternativeSuggestions,
              tooltip: 'See alternative seating options',
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
                  '$theatreName - $showDate - ${_show!.time}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                // Show occupancy or sold out message
                isSoldOut
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'SOLD OUT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : (_priceMultiplier > 1.0 && _occupancyRate > 0.0
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Theater is $occupancyPercentage% full! Dynamic pricing in effect',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : SizedBox.shrink()),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected: ${_selectedSeats.length}/$_groupSize seats',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.refresh, size: 16),
                      label: Text('Reset'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: Size(10, 36),
                      ),
                      onPressed: _selectedSeats.isNotEmpty ? () {
                        setState(() {
                          _clearSelectedSeats();
                        });
                      } : null,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.grid_view, size: 16),
                      label: Text('Best Seats'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: Size(10, 36),
                      ),
                      onPressed: _findBestSeats,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.smart_toy, size: 16),
                      label: Text('AI Select'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: Size(10, 36),
                      ),
                      onPressed: _findOptimalSeats,
                    ),
                  ],
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
                      'Mumbai',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                    // Add pricing details button when seats are selected
                    if (_selectedSeats.isNotEmpty)
                      TextButton.icon(
                        icon: Icon(Icons.price_change, size: 16),
                        label: Text('View Pricing Details'),
                        onPressed: _getDynamicPricing,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 25),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: Colors.amber,
                        ),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${dynamicPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Show ticket price breakdown
                    Text(
                      'Base: ₹${basePrice.toStringAsFixed(2)} × ${_selectedSeats.length} seats',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                    // Dynamic pricing factors
                    if (_priceMultiplier > 1.0) ...[
                      if (_occupancyRate > 0.5)
                        Text(
                          'Demand (${occupancyPercentage}% full): ${_getPriceChange(_occupancyRate)}',
                          style: TextStyle(fontSize: 11, color: Colors.amber),
                        ),
                      if (_isWeekend)
                        Text(
                          'Weekend: +10%',
                          style: TextStyle(fontSize: 11, color: Colors.amber),
                        ),
                      if (_isPeakHour)
                        Text(
                          'Evening hours: +10%',
                          style: TextStyle(fontSize: 11, color: Colors.amber),
                        ),
                      // Show center seats premium information
                      if (_selectedSeats.isNotEmpty && _selectedSeats.where((seatNum) {
                        final seatPosition = (seatNum - 1) % _seatsPerRow;
                        return seatPosition >= 3 && seatPosition <= 6;
                      }).length > 0)
                        Builder(
                          builder: (context) {
                            // Count how many center seats are selected
                            final centerSeatCount = _selectedSeats.where((seatNum) {
                              final seatPosition = (seatNum - 1) % _seatsPerRow;
                              return seatPosition >= 3 && seatPosition <= 6;
                            }).length;
                            
                            // Calculate percentage of selected seats that are center seats
                            final centerSeatPercentage = (centerSeatCount / _selectedSeats.length * 100).toInt();
                            
                            return Text(
                              'Center seats ($centerSeatCount/${_selectedSeats.length}): +10%',
                              style: TextStyle(fontSize: 11, color: Colors.amber),
                            );
                          }
                        ),
                    ],
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
              onPressed: isSoldOut ? null : (_selectedSeats.isNotEmpty ? _bookTickets : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                disabledBackgroundColor: isSoldOut ? Colors.red.withOpacity(0.5) : Colors.grey,
              ),
              child: Text(
                isSoldOut ? 'SOLD OUT' : 'Buy Ticket ₹${dynamicPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to display price changes based on occupancy
  String _getPriceChange(double occupancyRate) {
    if (occupancyRate > 0.9) return '+30%';
    if (occupancyRate > 0.7) return '+20%';
    if (occupancyRate > 0.5) return '+10%';
    return '0%';
  }
}
