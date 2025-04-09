import '../models/movie.dart';
import '../utils/api_service.dart';

class MovieController {
  final ApiService _apiService = ApiService();

  Future<List<Movie>> getAllMovies() async {
    return await _apiService.fetchMovies();
  }
}

