import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static AuthService get instance => _instance;
  
  // Key for storing token in SharedPreferences
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';
  
  // Getter for auth headers
  Future<Map<String, String>> get authHeaders async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  
  // Save token to storage
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }
  
  // Get token from storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }
  
  // Save user info
  Future<void> saveUserInfo(String userId, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
    await prefs.setString(userRoleKey, role);
  }
  
  // Get user ID
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }
  
  // Get user role
  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRoleKey);
  }
  
  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
  
  // Validate token by making a test API call
  Future<bool> validateToken() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) {
        return false;
      }
      
      // Make a request to a protected endpoint
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/auth/users'),
        headers: await authHeaders,
      );
      
      // If response is 401, token is invalid
      if (response.statusCode == 401) {
        debugPrint('Token validation failed with status 401');
        return false;
      }
      
      // If response is 200, token is valid
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error validating token: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Save token and user info
        if (data['token'] != null) {
          await saveToken(data['token']);
          await saveUserInfo(data['userId'], data['role']);
        }
        
        debugPrint(response.body);
        return data;
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
  
  // Logout user
  Future<bool> logout() async {
    try {
      final headers = await authHeaders;
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/api/auth/logout'),
        headers: headers,
      );
      
      // Clear local storage regardless of server response
      await _clearUserData();
      
      return response.statusCode == 200;
    } catch (e) {
      // Even if server request fails, clear local storage
      await _clearUserData();
      
      return false;
    }
  }
  
  // Clear all user data from local storage
  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userIdKey);
    await prefs.remove(userRoleKey);
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/api/auth/register/user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<Map<String, dynamic>> registerDoctor(Map<String, dynamic> doctorData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/api/auth/register/doctor'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(doctorData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Failed to register doctor: $e');
    }
  }
} 