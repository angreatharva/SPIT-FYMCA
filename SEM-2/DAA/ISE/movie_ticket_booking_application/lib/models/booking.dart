import 'show.dart';

class Booking {
  final String? id;
  final String user;
  final String showId;
  final Show? show;
  final List<int> seatNumbers;
  final double totalPrice;
  final DateTime? bookingTime;

  Booking({
    this.id,
    required this.user,
    required this.showId,
    this.show,
    required this.seatNumbers,
    required this.totalPrice,
    this.bookingTime,
  });

  factory Booking.fromJson(Map<String, dynamic> json, String serverRootUrl) {
    // Safely parse the totalPrice value with proper null handling
    double parseTotalPrice(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }
    
    return Booking(
      id: json['_id'],
      user: json['user'],
      showId: json['show'] is String ? json['show'] : json['show']?['_id'] ?? '',
      show: json['show'] is Map<String, dynamic> ? Show.fromJson(json['show'], serverRootUrl) : null,
      seatNumbers: List<int>.from(json['seatNumbers']),
      totalPrice: parseTotalPrice(json['totalPrice']),
      bookingTime: json['bookingTime'] != null ? DateTime.parse(json['bookingTime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'showId': showId,
      'seatNumbers': seatNumbers,
      'totalPrice': totalPrice, // Include totalPrice in the request
    };
  }
}