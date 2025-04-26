import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  // Base URL for the API server
  static const String baseUrl = 'https://31b2-210-16-113-49.ngrok-free.app';
  
  // Singleton instance
  static ApiService get instance => Get.find<ApiService>();
  
  // Dio instance
  late final Dio dio;
  
  // Getter for the Dio instance
  Dio get client => dio;
  
  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }
  
  void _initializeDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    // Add interceptors for logging
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          return handler.next(e);
        },
      ),
    );
  }
  
  // Initialize method for GetX service
  Future<ApiService> init() async {
    return this;
  }
} 