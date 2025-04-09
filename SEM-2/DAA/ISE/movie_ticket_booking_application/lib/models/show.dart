import 'movie.dart';
import 'theatre.dart';

class Show {
  final String id;
  final Movie? movie;
  final Theatre? theatre;
  final String movieId;
  final String theatreId;
  final DateTime date;
  final String time;
  final double price;
  final List<int> availableSeats;

  Show({
    required this.id,
    this.movie,
    this.theatre,
    required this.movieId,
    required this.theatreId,
    required this.date,
    required this.time,
    required this.price,
    required this.availableSeats,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['_id'],
      movie: json['movie'] != null ? Movie.fromJson(json['movie']) : null,
      theatre: json['theatre'] != null ? Theatre.fromJson(json['theatre']) : null,
      movieId: json['movie'] is String ? json['movie'] : json['movie']['_id'],
      theatreId: json['theatre'] is String ? json['theatre'] : json['theatre']['_id'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      price: json['price'].toDouble(),
      availableSeats: List<int>.from(json['availableSeats']),
    );
  }
}