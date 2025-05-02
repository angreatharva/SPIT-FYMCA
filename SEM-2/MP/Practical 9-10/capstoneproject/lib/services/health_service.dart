import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/health_tracking_model.dart';
import 'dart:developer' as dev;

class HealthService extends GetxService {
  final Dio _dio = ApiService.instance.client;
  
  // Singleton instance
  static HealthService get instance => Get.find<HealthService>();
  
  // Get all health questions
  Future<List<dynamic>> getAllQuestions() async {
    try {
      final response = await _dio.get(
        '${ApiService.baseUrl}/api/health/questions',
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] ?? [];
      } else {
        dev.log('Error getting health questions: ${response.data}');
        return [];
      }
    } catch (e) {
      dev.log('Exception getting health questions: $e');
      return [];
    }
  }
  
  // Get today's health tracking for a user
  Future<HealthTrackingModel?> getUserHealthTracking(String userId, {String userType = 'patient'}) async {
    if (userId.isEmpty) {
      dev.log('HealthService: Cannot get health tracking - userId is empty');
      return null;
    }
    
    try {
      dev.log('HealthService: Getting health tracking for $userId with userType: $userType');
      
      final response = await _dio.get(
        '${ApiService.baseUrl}/api/health/tracking/$userId',
        queryParameters: {'userType': userType},
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data == null) {
          dev.log('HealthService: Server returned null data for health tracking');
          return null;
        }
        
        // Validate trackingId
        if (data['_id'] == null) {
          dev.log('HealthService: Warning - Server returned health tracking without trackingId');
        } else {
          dev.log('HealthService: Successfully received health tracking with ID: ${data['_id']}');
        }
        
        return HealthTrackingModel.fromJson(data);
      } else {
        dev.log('HealthService: Error getting health tracking: ${response.data}');
        return null;
      }
    } catch (e) {
      dev.log('HealthService: Exception getting health tracking: $e');
      return null;
    }
  }
  
  // Complete a health question
  Future<bool> completeHealthQuestion(String userId, String trackingId, String questionId) async {
    try {
      final response = await _dio.post(
        '${ApiService.baseUrl}/api/health/tracking/$userId/$trackingId/complete/$questionId',
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        dev.log('Error completing health question: ${response.data}');
        return false;
      }
    } catch (e) {
      dev.log('Exception completing health question: $e');
      return false;
    }
  }
  
  // Get health activity heatmap data
  Future<Map<String, dynamic>?> getHealthActivityHeatmap(
    String userId, {
    String? startDate,
    String? endDate,
    String userType = 'patient',
  }) async {
    try {
      Map<String, dynamic> queryParams = {};
      
      if (startDate != null) {
        queryParams['startDate'] = startDate;
      }
      
      if (endDate != null) {
        queryParams['endDate'] = endDate;
      }
      
      queryParams['userType'] = userType;
      
      final response = await _dio.get(
        '${ApiService.baseUrl}/api/health/heatmap/$userId',
        queryParameters: queryParams,
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'];
      } else {
        dev.log('Error getting health heatmap: ${response.data}');
        return null;
      }
    } catch (e) {
      dev.log('Exception getting health heatmap: $e');
      return null;
    }
  }

  // Get questions by role (doctor, patient, or both)
  Future<List<dynamic>> getQuestionsByRole(String role) async {
    try {
      final response = await _dio.get(
        '${ApiService.baseUrl}/api/health/questions/role/$role',
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] ?? [];
      } else {
        dev.log('Error getting health questions by role: ${response.data}');
        return [];
      }
    } catch (e) {
      dev.log('Exception getting health questions by role: $e');
      return [];
    }
  }

  // Initialize method for GetX service
  Future<HealthService> init() async {
    return this;
  }
} 