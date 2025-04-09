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

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      user: json['user'],
      showId: json['show'] is String ? json['show'] : json['show']['_id'],
      show: json['show'] is Map<String, dynamic> ? Show.fromJson(json['show']) : null,
      seatNumbers: List<int>.from(json['seatNumbers']),
      totalPrice: json['totalPrice'].toDouble(),
      bookingTime: json['bookingTime'] != null ? DateTime.parse(json['bookingTime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'showId': showId,
      'seatNumbers': seatNumbers,
    };
  }
}