import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../models/doctor.dart';
import 'api_service.dart';

class DoctorService extends GetxService {
  static DoctorService get instance => Get.find<DoctorService>();
  final Dio _dio = ApiService.instance.client;

  // Get all available doctors
  Future<List<Doctor>> getAvailableDoctors() async {
    try {
      dev.log('Fetching available doctors...');
      final response = await _dio.get('/api/doctors/available');
      
      if (response.data['success']) {
        final List<dynamic> doctorsJson = response.data['doctors'];
        dev.log('Found ${doctorsJson.length} available doctors');
        return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
      } else {
        throw response.data['message'] ?? 'Failed to get available doctors';
      }
    } catch (e) {
      dev.log('Error getting available doctors: $e');
      throw 'Error getting available doctors: $e';
    }
  }

  // Get all doctors (for admin purposes)
  Future<List<Doctor>> getAllDoctors() async {
    try {
      dev.log('Fetching all doctors...');
      final response = await _dio.get('/api/doctors');
      
      if (response.data['success']) {
        final List<dynamic> doctorsJson = response.data['doctors'];
        dev.log('Found ${doctorsJson.length} doctors');
        return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
      } else {
        throw response.data['message'] ?? 'Failed to get doctors';
      }
    } catch (e) {
      dev.log('Error getting all doctors: $e');
      throw 'Error getting doctors: $e';
    }
  }

  // Toggle doctor's active status
  Future<bool> toggleActiveStatus(String doctorId) async {
    try {
      dev.log('Toggling active status for doctor ID: $doctorId');
      final response = await _dio.patch(
        '/api/doctors/$doctorId/toggle-status',
      );
      
      if (response.data['success']) {
        final bool newStatus = response.data['isActive'] ?? false;
        dev.log('Doctor status toggled to: $newStatus');
        return newStatus;
      } else {
        dev.log('API returned error: ${response.data['message']}');
        throw response.data['message'] ?? 'Failed to toggle status';
      }
    } catch (e) {
      dev.log('Error toggling doctor status: $e');
      throw 'Error toggling status: $e';
    }
  }

  // Get doctor's current status
  Future<bool> getDoctorStatus(String doctorId) async {
    try {
      dev.log('Getting status for doctor ID: $doctorId');
      final response = await _dio.get('/api/doctors/$doctorId/status');
      
      if (response.data['success']) {
        final bool status = response.data['isActive'] ?? false;
        dev.log('Doctor status is: $status');
        return status;
      } else {
        dev.log('API returned error: ${response.data['message']}');
        throw response.data['message'] ?? 'Failed to get status';
      }
    } catch (e) {
      dev.log('Error getting doctor status: $e');
      throw 'Error getting status: $e';
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize the service
    dev.log('DoctorService initialized');
  }
} 