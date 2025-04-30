import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/theatre.dart';
import '../models/show.dart';
import '../models/booking.dart';

class ApiService {

  // static const String serverRootUrl = ' http://localhost:5000';
  static const String serverRootUrl = 'https://baa9-202-134-190-225.ngrok-free.app';
  static const String _apiBaseUrl = '$serverRootUrl/api';

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

  Future<List<Booking>> fetchUserBookings(String userId) async {
    print('GET: $_apiBaseUrl/bookings/user/$userId');
    final response = await http.get(Uri.parse('$_apiBaseUrl/bookings/user/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Booking.fromJson(json, serverRootUrl)).toList();
    } else {
      throw Exception('Failed to load user bookings');
    }
  }

  Future<Booking> createBooking(Booking booking) async {
    print('POST: $_apiBaseUrl/bookings');
    print('Request body: ${json.encode(booking.toJson())}');
    
    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/bookings'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(booking.toJson()),
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['booking'] == null) {
          print('Warning: Response has no booking data: $data');
          // Create a basic booking object if the response doesn't have one
          return booking;
        }
        // Pass the serverRootUrl to the fromJson factory if needed
        return Booking.fromJson(data['booking'], serverRootUrl);
      } else {
        throw Exception('Failed to create booking: ${response.body}');
      }
    } catch (e) {
      print('createBooking exception: $e');
      throw Exception('Network error creating booking: $e');
    }
  }

  // Find optimal seats using the knapsack algorithm
  Future<Map<String, dynamic>> findOptimalSeats({
    required String showId,
    required int groupSize,
    required double budget,
    required Map<String, dynamic> preferences,
  }) async {
    print('POST: $_apiBaseUrl/bookings/find-optimal-seats');
    final response = await http.post(
      Uri.parse('$_apiBaseUrl/bookings/find-optimal-seats'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'showId': showId,
        'groupSize': groupSize,
        'budget': budget,
        'preferences': preferences,
      }),
    );

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to find optimal seats: ${response.body}');
    }
  }

  // Get pricing details for selected seats
  Future<Map<String, dynamic>> getPricingDetails({
    required String showId,
    required List<int> seatNumbers,
  }) async {
    print('POST: $_apiBaseUrl/bookings/pricing-details');
    final response = await http.post(
      Uri.parse('$_apiBaseUrl/bookings/pricing-details'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'showId': showId,
        'seatNumbers': seatNumbers,
      }),
    );

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get pricing details: ${response.body}');
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

  Future<Map<String, dynamic>> getAlternativeSeatSuggestions({
    required String showId,
    required List<int> selectedSeats,
  }) async {
    try {
      print('PUT: $_apiBaseUrl/bookings/alternative-suggestions');
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/bookings/alternative-suggestions'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'showId': showId,
          'selectedSeats': selectedSeats,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get alternative seat suggestions');
      }
    } catch (e) {
      throw Exception('Error getting alternative seat suggestions: $e');
    }
  }
}