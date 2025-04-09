import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/theatre.dart';
import '../models/show.dart';
import '../models/booking.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api'; // For Android emulator
  // Use 'http://localhost:5000/api' for iOS simulator

  // Movies
  Future<List<Movie>> fetchMovies() async {
    print('$baseUrl/movies');
    final response = await http.get(Uri.parse('$baseUrl/movies'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Theatres
  Future<List<Theatre>> fetchTheatres() async {
    print('$baseUrl/theatres');
    final response = await http.get(Uri.parse('$baseUrl/theatres'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Theatre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load theatres');
    }
  }

  // Shows
  Future<List<Show>> fetchShows() async {
    print('GET: $baseUrl/shows');
    final response = await http.get(Uri.parse('$baseUrl/shows'));
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Show.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }

  Future<List<Show>> fetchShowsByMovie(String movieId) async {
    print('GET: $baseUrl/shows');
    print('movieId: $movieId');
    final response = await http.get(Uri.parse('$baseUrl/shows'));
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Show> shows = data.map((json) => Show.fromJson(json)).toList();
      List<Show> result = shows.where((show) =>
      show.movie?.id == movieId || show.movieId == movieId
      ).toList();
      return result;
    } else {
      throw Exception('Failed to load shows for movie');
    }
  }

  // Bookings
  Future<List<Booking>> fetchBookings() async {
    print('$baseUrl/bookings');
    final response = await http.get(Uri.parse('$baseUrl/bookings'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<Booking> createBooking(Booking booking) async {
    print('$baseUrl/bookings');
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );
    if (response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      return Booking.fromJson(data['booking']);
    } else {
      throw Exception('Failed to create booking: ${response.body}');
    }
  }

  // Book seats for a show
  Future<Show> bookSeats(String showId, List<int> seatNumbers) async {
    print('$baseUrl/shows/book/$showId');
    final response = await http.put(
      Uri.parse('$baseUrl/shows/book/$showId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'seatNumbers': seatNumbers}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Show.fromJson(data['show']);
    } else {
      throw Exception('Failed to book seats: ${response.body}');
    }
  }
}