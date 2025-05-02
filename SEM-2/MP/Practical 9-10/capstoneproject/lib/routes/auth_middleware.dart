import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../services/storage_service.dart';
import '../services/auth_service.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  // Prevent multiple redirects
  static bool _isRedirecting = false;
  // Last validation time
  static DateTime _lastValidationTime = DateTime(2000);
  // Validation interval (5 minutes)
  static const _validationInterval = Duration(minutes: 5);

  @override
  RouteSettings? redirect(String? route) {
    // If already redirecting, avoid creating a loop
    if (_isRedirecting) {
      return null;
    }
    
    final storageService = StorageService.instance;
    
    // Routes that don't require authentication
    final publicRoutes = [
      AppRoutes.login,
      AppRoutes.userRegistration,
      AppRoutes.doctorRegistration,
    ];
    
    // If this is a public route, no redirect needed
    if (publicRoutes.contains(route)) {
      return null;
    }
    
    // If not logged in, redirect to login
    if (!storageService.isUserLoggedIn()) {
      _isRedirecting = true;
      dev.log('User not logged in, redirecting to login from route: $route');
      
      // Reset redirection flag after a delay
      Future.delayed(const Duration(milliseconds: 500), () {
        _isRedirecting = false;
      });
      
      return const RouteSettings(name: AppRoutes.login);
    }
    
    // Check if user has valid data
    final user = storageService.getUserData();
    if (user == null) {
      _isRedirecting = true;
      dev.log('User data is missing, redirecting to login from route: $route');
      
      // Reset redirection flag after a delay
      Future.delayed(const Duration(milliseconds: 500), () {
        _isRedirecting = false;
      });
      
      return const RouteSettings(name: AppRoutes.login);
    }
    
    // Check token validity if it hasn't been checked recently
    _validateToken();
    
    // User is authenticated and has valid data, continue to requested route
    return null;
  }
  
  // Check token validity
  void _validateToken() async {
    try {
      // Skip validation if we've checked recently
      final now = DateTime.now();
      if (now.difference(_lastValidationTime) < _validationInterval) {
        return;
      }
      
      _lastValidationTime = now;
      
      // Get token
      final token = await AuthService().getToken();
      if (token == null || token.isEmpty) {
        dev.log('Token is missing, will redirect to login on API call');
        return;
      }
      
      // Validate token by making a test API call
      final isValid = await AuthService().validateToken();
      if (!isValid && !_isRedirecting) {
        dev.log('Token validation failed, logging out');
        _isRedirecting = true;
        
        // Show a message and redirect
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Your session has expired. Please log in again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        
        // Logout and redirect
        await AuthService().logout();
        
        // Navigate to login
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAllNamed(AppRoutes.login);
          _isRedirecting = false;
        });
      }
    } catch (e) {
      dev.log('Error validating token: $e');
    }
  }
} 