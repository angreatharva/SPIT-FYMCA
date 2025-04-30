import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/booking.dart';
import 'home_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Booking booking;

  const BookingConfirmationScreen({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Booking Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xFF222222),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (booking.show?.movie != null)
                      Text(
                        booking.show!.movie!.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (booking.show?.theatre != null)
                      Text(
                        'Theatre: ${booking.show!.theatre!.name}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    if (booking.show != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        'Date: ${DateFormat('E, MMM d, y').format(booking.show!.date)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Time: ${booking.show!.time}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                    const SizedBox(height: 5),
                    Text(
                      'Seats: ${booking.seatNumbers.join(', ')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total Amount: ₹${booking.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (booking.bookingTime != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        'Booking ID: ${booking.id}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Booking Time: ${DateFormat('MMM d, y HH:mm').format(booking.bookingTime!)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Back to Home', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
