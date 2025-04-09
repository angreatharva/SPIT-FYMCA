
import '../models/booking.dart';
import '../utils/api_service.dart';

class BookingController {
  final ApiService _apiService = ApiService();

  Future<List<Booking>> getAllBookings() async {
    return await _apiService.fetchBookings();
  }

  Future<Booking> createBooking(Booking booking) async {
    return await _apiService.createBooking(booking);
  }
}