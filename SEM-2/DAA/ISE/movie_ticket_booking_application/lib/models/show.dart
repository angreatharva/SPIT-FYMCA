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

  factory Show.fromJson(Map<String, dynamic> json, String serverRootUrl) {
    // Safe price parsing
    double parsePrice(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }
    
    return Show(
      id: json['_id'],
      movie: json['movie'] != null && json['movie'] is Map<String, dynamic>
          ? Movie.fromJson(json['movie'], serverRootUrl)
          : null,
      theatre: json['theatre'] != null ? Theatre.fromJson(json['theatre']) : null,
      movieId: json['movie'] is String ? json['movie'] : json['movie']?['_id'] ?? '',
      theatreId: json['theatre'] is String ? json['theatre'] : json['theatre']?['_id'] ?? '',
      date: DateTime.parse(json['date']),
      time: json['time'],
      price: parsePrice(json['price']),
      availableSeats: List<int>.from(json['availableSeats']),
    );
  }
}