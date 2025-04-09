class Movie {
  final String id;
  final String title;
  final String genre;
  final int duration;
  final double rating;
  final String description;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.description,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      title: json['title'],
      genre: json['genre'] ?? '',
      duration: json['duration'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      posterUrl: json['posterUrl'] ?? '',
    );
  }
}