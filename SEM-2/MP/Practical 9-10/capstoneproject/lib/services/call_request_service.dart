import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../models/call_request.dart';
import 'api_service.dart';

class CallRequestService extends GetxService {
  static CallRequestService get instance => Get.find<CallRequestService>();
  final Dio _dio = ApiService.instance.client;

  // Create a new call request
  Future<CallRequest> createCallRequest({
    required String patientId,
    required String patientName,
    required String patientCallerId,
    required String doctorId,
    required String doctorName,
    required String doctorCallerId,
  }) async {
    try {
      dev.log('Creating call request from patient $patientId to doctor $doctorId');
      dev.log('Patient caller ID: $patientCallerId');
      dev.log('Doctor caller ID: $doctorCallerId');
      dev.log('Doctor name: $doctorName');
      
      final requestData = {
        'patientId': patientId,
        'patientName': patientName,
        'patientCallerId': patientCallerId,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'doctorCallerId': doctorCallerId,
      };
      
      dev.log('Request payload: $requestData');
      
      final response = await _dio.post('/api/call-requests', data: requestData);
      
      if (response.data['success']) {
        final callRequest = CallRequest.fromJson(response.data['callRequest']);
        dev.log('Call request created with ID: ${callRequest.id}');
        return callRequest;
      } else {
        dev.log('Server returned error: ${response.data}');
        throw response.data['message'] ?? 'Failed to create call request';
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        dev.log('Server returned status code: ${e.response!.statusCode}');
        dev.log('Response data: ${e.response!.data}');
      }
      dev.log('Error creating call request: $e');
      throw 'Error creating call request: $e';
    }
  }

  // Get all call requests for a doctor
  Future<List<CallRequest>> getDoctorCallRequests(String doctorId) async {
    try {
      dev.log('Fetching call requests for doctor ID: $doctorId');
      final response = await _dio.get('/api/call-requests/doctor/$doctorId');
      
      if (response.data['success']) {
        final List<dynamic> requestsJson = response.data['callRequests'];
        dev.log('Found ${requestsJson.length} call requests for doctor');
        return requestsJson.map((json) => CallRequest.fromJson(json)).toList();
      } else {
        throw response.data['message'] ?? 'Failed to get call requests';
      }
    } catch (e) {
      dev.log('Error getting doctor call requests: $e');
      throw 'Error getting call requests: $e';
    }
  }

  // Get all call requests for a patient
  Future<List<CallRequest>> getPatientCallRequests(String patientId) async {
    try {
      dev.log('Fetching call requests for patient ID: $patientId');
      final response = await _dio.get('/api/call-requests/patient/$patientId');
      
      if (response.data['success']) {
        final List<dynamic> requestsJson = response.data['callRequests'];
        dev.log('Found ${requestsJson.length} call requests for patient');
        return requestsJson.map((json) => CallRequest.fromJson(json)).toList();
      } else {
        throw response.data['message'] ?? 'Failed to get call requests';
      }
    } catch (e) {
      dev.log('Error getting patient call requests: $e');
      throw 'Error getting call requests: $e';
    }
  }

  // Update call request status
  Future<CallRequest> updateCallRequestStatus(String requestId, String status) async {
    try {
      dev.log('Updating call request $requestId status to $status');
      final response = await _dio.patch('/api/call-requests/$requestId', data: {
        'status': status,
      });
      
      if (response.data['success']) {
        final callRequest = CallRequest.fromJson(response.data['callRequest']);
        dev.log('Call request status updated to: ${callRequest.status}');
        return callRequest;
      } else {
        throw response.data['message'] ?? 'Failed to update call request';
      }
    } catch (e) {
      dev.log('Error updating call request: $e');
      throw 'Error updating call request: $e';
    }
  }

  @override
  void onInit() {
    super.onInit();
    dev.log('CallRequestService initialized');
  }
} 