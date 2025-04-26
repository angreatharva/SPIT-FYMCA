import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../services/storage_service.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  // Prevent multiple redirects
  static bool _isRedirecting = false;

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
    
    // User is authenticated and has valid data, continue to requested route
    return null;
  }
} 