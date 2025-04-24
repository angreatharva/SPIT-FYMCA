import '../models/booking.dart';
import '../utils/api_service.dart';

class BookingController {
  final ApiService _apiService = ApiService();

  Future<List<Booking>> getAllBookings() async {
    return await _apiService.fetchBookings();
  }

  Future<List<Booking>> getUserBookings(String userId) async {
    return await _apiService.fetchUserBookings(userId);
  }

  Future<Booking> createBooking(Booking booking) async {
    return await _apiService.createBooking(booking);
  }

  Future<Map<String, dynamic>> findOptimalSeats({
    required String showId,
    required int groupSize,
    required double budget,
    required Map<String, dynamic> preferences,
  }) async {
    return await _apiService.findOptimalSeats(
      showId: showId,
      groupSize: groupSize,
      budget: budget,
      preferences: preferences,
    );
  }

  Future<Map<String, dynamic>> getPricingDetails({
    required String showId,
    required List<int> seatNumbers,
  }) async {
    return await _apiService.getPricingDetails(
      showId: showId,
      seatNumbers: seatNumbers,
    );
  }

  // Get alternative seat suggestions using LCS algorithm
  Future<Map<String, dynamic>> getAlternativeSeatSuggestions({
    required String showId,
    required List<int> selectedSeats,
  }) async {
    return await _apiService.getAlternativeSeatSuggestions(
      showId: showId,
      selectedSeats: selectedSeats,
    );
  }
}