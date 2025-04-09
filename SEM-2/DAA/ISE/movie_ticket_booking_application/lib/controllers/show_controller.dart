import '../models/show.dart';
import '../utils/api_service.dart';

class ShowController {
  final ApiService _apiService = ApiService();

  Future<List<Show>> getAllShows() async {
    return await _apiService.fetchShows();
  }

  Future<List<Show>> getShowsByMovie(String movieId) async {
    return await _apiService.fetchShowsByMovie(movieId);
  }

  Future<Show> bookSeats(String showId, List<int> seatNumbers) async {
    return await _apiService.bookSeats(showId, seatNumbers);
  }
}