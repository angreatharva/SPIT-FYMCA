import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'dart:math' as math;
import '../models/call_request.dart';
import '../models/doctor.dart';
import '../services/call_request_service.dart';
import '../services/signalling.service.dart';
import '../screens/join_screen.dart';
import '../screens/call_screen.dart';

class CallRequestController extends GetxController {
  static CallRequestController get to => Get.find<CallRequestController>();
  
  // Observable properties
  final RxList<CallRequest> doctorCallRequests = <CallRequest>[].obs;
  final RxList<CallRequest> patientCallRequests = <CallRequest>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isRequesting = false.obs;
  
  late final CallRequestService _callRequestService;
  
  @override
  void onInit() {
    super.onInit();
    _callRequestService = Get.find<CallRequestService>();
    dev.log('CallRequestController initialized');
  }
  
  // Fetch all call requests for a doctor
  Future<void> fetchDoctorCallRequests(String doctorId) async {
    try {
      isLoading.value = true;
      dev.log('Fetching call requests for doctor: $doctorId');
      final requests = await _callRequestService.getDoctorCallRequests(doctorId);
      
      // Filter only pending requests
      doctorCallRequests.assignAll(requests.where((request) => request.status == 'pending'));
      dev.log('Fetched ${doctorCallRequests.length} pending call requests for doctor');
    } catch (e) {
      dev.log('Error fetching doctor call requests: $e');
      doctorCallRequests.clear();
    } finally {
      isLoading.value = false;
    }
  }
  
  // Fetch all call requests for a patient
  Future<void> fetchPatientCallRequests(String patientId) async {
    try {
      isLoading.value = true;
      dev.log('Fetching call requests for patient: $patientId');
      final requests = await _callRequestService.getPatientCallRequests(patientId);
      patientCallRequests.assignAll(requests);
      dev.log('Fetched ${patientCallRequests.length} call requests for patient');
    } catch (e) {
      dev.log('Error fetching patient call requests: $e');
      patientCallRequests.clear();
    } finally {
      isLoading.value = false;
    }
  }
  
  // Create a new call request
  Future<void> requestVideoCall({
    required String patientId,
    required String patientName,
    required String patientCallerId,
    required Doctor doctor,
  }) async {
    if (isRequesting.value) {
      dev.log('Already creating a request, ignoring');
      return;
    }
    
    try {
      isRequesting.value = true;
      
      // Debug the doctor object
      dev.log('Doctor object details:');
      dev.log('ID: ${doctor.id}');
      dev.log('Name: ${doctor.name}');
      dev.log('Email: ${doctor.email}');
      dev.log('Specialization: ${doctor.specialization}');
      dev.log('isActive: ${doctor.isActive}');
      
      dev.log('Requesting video call with doctor: ${doctor.name}');
      
      // Generate a consistent callerId for the doctor based on their ID
      // This ensures we use a proper callerId format instead of just the ID
      final doctorCallerId = 'doc_${doctor.id}';
      dev.log('Using doctorCallerId: $doctorCallerId');
      
      // Ensure doctor name is not empty - use a fallback if needed
      final String doctorName = doctor.name.isNotEmpty 
          ? doctor.name 
          : "Doctor ${doctor.id.substring(0, math.min(6, doctor.id.length))}";
      dev.log('Using doctor name: $doctorName');
      
      await _callRequestService.createCallRequest(
        patientId: patientId,
        patientName: patientName,
        patientCallerId: patientCallerId,
        doctorId: doctor.id,
        doctorName: doctorName, // Use the validated name
        doctorCallerId: doctorCallerId,
      );
      
      Get.snackbar(
        'Request Sent',
        'Your video call request has been sent to Dr. ${doctorName}',
        snackPosition: SnackPosition.BOTTOM,
      );
      
    } catch (e) {
      dev.log('Error requesting video call: $e');
      Get.snackbar(
        'Request Failed',
        'Failed to send video call request. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isRequesting.value = false;
    }
  }
  
  // Accept a call request
  Future<void> acceptCallRequest({
    required CallRequest request,
    required String selfCallerId,
    required bool isDoctor,
    required String userId,
    required String userName,
  }) async {
    try {
      dev.log('Accepting call request: ${request.id}');
      await _callRequestService.updateCallRequestStatus(request.id, 'accepted');
      
      // Update patient caller ID to match the one stored in the call request
      final String remoteCallerId = request.patientCallerId;
      dev.log('Remote caller ID (patient): $remoteCallerId');
      
      // Send socket notification to patient that their request was accepted
      SignallingService.instance.socket?.emit('callRequestAccepted', {
        'patientCallerId': remoteCallerId,
        'requestId': request.id,
        'doctorCallerId': selfCallerId,
        'doctorName': userName,
      });
      
      dev.log('Emitted callRequestAccepted event to patient: $remoteCallerId');
      
      // Instead of navigating to JoinScreen, directly initiate a call
      dev.log('Doctor directly initiating call to patient');
      Get.to(
        () => CallScreen(
          callerId: selfCallerId,
          calleeId: remoteCallerId,
          offer: null, // No offer as doctor is initiating the call
          isDoctor: isDoctor,
          // userId: userId,
          // userName: userName,
        ),
      );
      
      // Refresh doctor's call requests
      fetchDoctorCallRequests(request.doctorId);
      
    } catch (e) {
      dev.log('Error accepting call request: $e');
      Get.snackbar(
        'Error',
        'Failed to accept call request. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Reject a call request
  Future<void> rejectCallRequest(CallRequest request) async {
    try {
      dev.log('Rejecting call request: ${request.id}');
      await _callRequestService.updateCallRequestStatus(request.id, 'rejected');
      
      // Refresh doctor's call requests
      fetchDoctorCallRequests(request.doctorId);
      
      Get.snackbar(
        'Request Rejected',
        'You have rejected the call request from ${request.patientName}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      dev.log('Error rejecting call request: $e');
      Get.snackbar(
        'Error',
        'Failed to reject call request. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Complete a call request (called after ending a call)
  Future<void> completeCallRequest(String requestId) async {
    try {
      dev.log('Completing call request: $requestId');
      await _callRequestService.updateCallRequestStatus(requestId, 'completed');
    } catch (e) {
      dev.log('Error completing call request: $e');
    }
  }
} 