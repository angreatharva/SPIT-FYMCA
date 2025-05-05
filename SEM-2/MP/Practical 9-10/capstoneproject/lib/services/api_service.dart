import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../routes/app_routes.dart';
import 'auth_service.dart';

class ApiService extends GetxService {
  // Base URL for the API server
  static const String baseUrl = 'https://5193-202-134-190-211.ngrok-free.app';
  
  // Singleton instance
  static ApiService get instance => Get.find<ApiService>();
  
  // Dio instance
  late final Dio dio;
  
  // Flag to prevent multiple redirects
  static bool _isRedirectingToLogin = false;
  
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
    
    // Add auth token interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get token from AuthService
          final token = await AuthService().getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          dev.log('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          dev.log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          dev.log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          
          // Handle authentication errors (401)
          if (e.response?.statusCode == 401) {
            _handleTokenExpiration();
          }
          
          return handler.next(e);
        },
      ),
    );
  }
  
  // Handle token expiration and redirect to login page
  void _handleTokenExpiration() {
    if (_isRedirectingToLogin) return; // Prevent multiple redirects
    
    _isRedirectingToLogin = true;
    
    // Logout user if token is invalid
    AuthService().logout().then((_) {
      // Show message about session expiration
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Your session has expired. Please log in again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      
      // Redirect to login page after a short delay to allow snackbar to be shown
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAllNamed(AppRoutes.login);
        _isRedirectingToLogin = false; // Reset flag after redirection
      });
    }).catchError((error) {
      dev.log('Error during logout: $error');
      // Still redirect to login even if logout fails
      Get.offAllNamed(AppRoutes.login);
      _isRedirectingToLogin = false;
    });
  }
  
  // Initialize method for GetX service
  Future<ApiService> init() async {
    return this;
  }
} 