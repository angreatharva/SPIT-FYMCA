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

  @override
  void initState() {
    super.initState();
    _initializeSeats();
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
    });
  }

  void _toggleSeatSelection(int seatNumber) {
    final seatIndex = _seats.indexWhere((seat) => seat.number == seatNumber);
    if (seatIndex != -1) {
      setState(() {
        if (_seats[seatIndex].status == SeatStatus.available) {
          _seats[seatIndex].status = SeatStatus.selected;
          _selectedSeats.add(seatNumber);
        } else if (_seats[seatIndex].status == SeatStatus.selected) {
          _seats[seatIndex].status = SeatStatus.available;
          _selectedSeats.remove(seatNumber);
        }
      });
    }
  }

// lib/views/seat_selection_screen.dart (continued)
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
      // Create booking
      final booking = Booking(
        user: 'current_user', // In a real app, this would be the logged-in user's ID
        showId: widget.show.id,
        seatNumbers: _selectedSeats,
        totalPrice: _selectedSeats.length * widget.show.price,
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

  @override
  Widget build(BuildContext context) {
    final movieTitle = widget.show.movie?.title ?? 'Movie';
    final theatreName = widget.show.theatre?.name ?? 'Theatre';
    final showDate = DateFormat('E, MMM d').format(widget.show.date);
    final totalPrice = _selectedSeats.length * widget.show.price;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats'),
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
                        _toggleSeatSelection(seat.number);
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
                        color: Colors.grey,
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
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                'Buy Ticket \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
