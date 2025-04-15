import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/theatre.dart';
import '../models/show.dart';
import '../models/booking.dart';

class ApiService {
  static const String _apiBaseUrl = 'http://10.0.2.2:5000/api'; // For Android emulator
  static const String serverRootUrl = 'http://10.0.2.2:5000'; // Server root for assets
  // Use 'http://localhost:5000/api' and 'http://localhost:5000' for iOS simulator

  // Movies
  Future<List<Movie>> fetchMovies() async {
    print('GET: $_apiBaseUrl/movies');
    final response = await http.get(Uri.parse('$_apiBaseUrl/movies'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Pass the serverRootUrl to the fromJson factory
      return data.map((json) => Movie.fromJson(json, serverRootUrl)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Theatres
  Future<List<Theatre>> fetchTheatres() async {
    print('GET: $_apiBaseUrl/theatres');
    final response = await http.get(Uri.parse('$_apiBaseUrl/theatres'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Theatre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load theatres');
    }
  }

  // Shows
  Future<List<Show>> fetchShows() async {
    print('GET: $_apiBaseUrl/shows');
    final response = await http.get(Uri.parse('$_apiBaseUrl/shows'));
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Pass the serverRootUrl to the fromJson factory if needed
      return data.map((json) => Show.fromJson(json, serverRootUrl)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }

  Future<List<Show>> fetchShowsByMovie(String movieId) async {
    print('GET: $_apiBaseUrl/shows');
    print('movieId: $movieId');
    final response = await http.get(Uri.parse('$_apiBaseUrl/shows'));
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Pass the serverRootUrl to the fromJson factory if needed
      List<Show> shows = data.map((json) => Show.fromJson(json, serverRootUrl)).toList();
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
    print('GET: $_apiBaseUrl/bookings');
    final response = await http.get(Uri.parse('$_apiBaseUrl/bookings'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Pass the serverRootUrl to the fromJson factory if needed
      return data.map((json) => Booking.fromJson(json, serverRootUrl)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<Booking> createBooking(Booking booking) async {
    print('POST: $_apiBaseUrl/bookings');
    final response = await http.post(
      Uri.parse('$_apiBaseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );
    if (response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      // Pass the serverRootUrl to the fromJson factory if needed
      return Booking.fromJson(data['booking'], serverRootUrl);
    } else {
      throw Exception('Failed to create booking: ${response.body}');
    }
  }

  // Book seats for a show
  Future<Show> bookSeats(String showId, List<int> seatNumbers) async {
    print('PUT: $_apiBaseUrl/shows/book/$showId');
    final response = await http.put(
      Uri.parse('$_apiBaseUrl/shows/book/$showId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'seatNumbers': seatNumbers}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // Pass the serverRootUrl to the fromJson factory if needed
      return Show.fromJson(data['show'], serverRootUrl);
    } else {
      throw Exception('Failed to book seats: ${response.body}');
    }
  }
}