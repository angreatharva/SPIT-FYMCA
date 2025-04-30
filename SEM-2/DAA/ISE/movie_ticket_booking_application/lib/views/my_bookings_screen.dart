import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';
import '../models/booking.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final BookingController _bookingController = BookingController();
  late Future<List<Booking>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _bookingsFuture = _bookingController.getAllBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final booking = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  color: const Color(0xFF222222),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (booking.show?.movie?.posterUrl != null) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  booking.show!.movie!.posterUrl,
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 120,
                                      color: Colors.grey[800],
                                      child: const Center(
                                        child: Icon(Icons.movie, size: 40, color: Colors.white70),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (booking.show?.movie != null)
                                    Text(
                                      booking.show!.movie!.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  if (booking.show?.theatre != null)
                                    Text(
                                      'Theatre: ${booking.show!.theatre!.name}',
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                  if (booking.show != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'Date: ${DateFormat('E, MMM d, y').format(booking.show!.date)}',
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Time: ${booking.show!.time}',
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                  ],
                                  const SizedBox(height: 4),
                                  Text(
                                    'Seats: ${booking.seatNumbers.join(', ')}',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Total: ₹${booking.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey, height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Booking ID: ${booking.id?.substring(0, 8) ?? ''}',
                              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                            ),
                            if (booking.bookingTime != null)
                              Text(
                                'Booked on: ${DateFormat('MMM d, y').format(booking.bookingTime!)}',
                                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
