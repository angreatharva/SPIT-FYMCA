import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/signalling.service.dart';

class CallingController extends GetxController {
  static CallingController get to => Get.find<CallingController>();
  
  final Dio _dio = Dio();
  final _baseUrl = ApiService.baseUrl;
  
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxList activeDoctors = [].obs;
  final RxList pendingRequests = [].obs;
  final Rx<dynamic> incomingSDPOffer = Rx<dynamic>(null);
  final RxString doctorId = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Configure dio
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.validateStatus = (status) {
      return status! < 500; // Accept all status codes less than 500
    };
    
    // Set up socket connection for incoming calls
    _setupSocketListeners();
  }
  
  void _setupSocketListeners() {
    // Make sure the socket is initialized
    final socket = SignallingService.instance.socket;
    if (socket != null) {
      // Listen for incoming calls
      socket.on("newCall", (data) {
        incomingSDPOffer.value = data;
      });
    }
  }
  
  // Clear incoming call offer
  void clearIncomingCall() {
    incomingSDPOffer.value = null;
  }
  
  // Fetch all active doctors
  Future<bool> fetchActiveDoctors() async {
    isLoading.value = true;
    error.value = '';
    
    try {
      final response = await _dio.get(
        '$_baseUrl/api/video-call/active-doctors',
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        activeDoctors.value = response.data['data'];
        return true;
      } else {
        error.value = response.data['message'] ?? 'Failed to fetch active doctors';
        return false;
      }
    } catch (e) {
      error.value = 'Network error: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Request a video call with a doctor
  Future<bool> requestVideoCall({
    required String patientId,
    required String doctorId,
    required String patientCallerId,
  }) async {
    isLoading.value = true;
    error.value = '';
    
    try {
      final response = await _dio.post(
        '$_baseUrl/api/video-call/request-call',
        data: {
          'patientId': patientId,
          'doctorId': doctorId,
          'patientCallerId': patientCallerId,
        },
      );
      
      if (response.statusCode == 201 && response.data['success'] == true) {
        return true;
      } else {
        error.value = response.data['message'] ?? 'Failed to request video call';
        return false;
      }
    } catch (e) {
      error.value = 'Network error: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Fetch pending call requests for a doctor
  Future<bool> fetchPendingRequests(String doctorId) async {
    isLoading.value = true;
    error.value = '';
    this.doctorId.value = doctorId;
    
    try {
      final response = await _dio.get(
        '$_baseUrl/api/video-call/pending-requests/$doctorId',
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Get the pending requests data
        List requestsList = response.data['data'];
        
        // Sort by requestedAt time (oldest first)
        requestsList.sort((a, b) {
          DateTime timeA = DateTime.parse(a['requestedAt']);
          DateTime timeB = DateTime.parse(b['requestedAt']);
          return timeA.compareTo(timeB);
        });
        
        // Update the observable list
        pendingRequests.value = requestsList;
        return true;
      } else {
        error.value = response.data['message'] ?? 'Failed to fetch pending requests';
        return false;
      }
    } catch (e) {
      error.value = 'Network error: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Update call request status
  Future<bool> updateCallRequestStatus(String requestId, String status) async {
    isLoading.value = true;
    error.value = '';
    
    try {
      final response = await _dio.patch(
        '$_baseUrl/api/video-call/request/$requestId',
        data: {
          'status': status,
        },
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        error.value = response.data['message'] ?? 'Failed to update call request status';
        return false;
      }
    } catch (e) {
      error.value = 'Network error: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
} 