import '../models/theatre.dart';
import '../utils/api_service.dart';

class TheatreController {
  final ApiService _apiService = ApiService();

  Future<List<Theatre>> getAllTheatres() async {
    return await _apiService.fetchTheatres();
  }
}