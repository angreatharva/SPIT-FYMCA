import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../services/api_service.dart';
import '../services/signalling.service.dart';
import '../controllers/user_controller.dart';

class CallingController extends GetxController {
  static CallingController get to => Get.find<CallingController>();
  
  // Use ApiService's Dio instance that has the token interceptor
  final Dio _dio = ApiService.instance.client;
  
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxList activeDoctors = [].obs;
  final RxList pendingRequests = [].obs;
  final Rx<dynamic> incomingSDPOffer = Rx<dynamic>(null);
  final RxString doctorId = ''.obs;
  
  // For storing doctor details
  final Rx<Map<String, dynamic>?> currentDoctorDetails = Rx<Map<String, dynamic>?>(null);
  
  @override
  void onInit() {
    super.onInit();
    
    // Set up socket connection for incoming calls and updates
    _setupSocketListeners();
  }
  
  void _setupSocketListeners() {
    // Make sure the socket is initialized
    final socket = SignallingService.instance.socket;
    if (socket != null) {
      // Listen for incoming calls
      socket.on("newCall", (data) {
        incomingSDPOffer.value = data;
        // Fetch doctor details when receiving a call
        if (data != null && data["callerId"] != null) {
          fetchDoctorDetails(data["callerId"]);
        }
      });
      
      // Listen for doctor status changes
      socket.on("doctorStatusChanged", (data) {
        dev.log("Doctor status changed event received: $data");
        // Update active doctors list if we've already loaded it
        if (activeDoctors.isNotEmpty) {
          fetchActiveDoctors(silent: true);
        }
      });
      
      // Listen for new call requests
      socket.on("newCallRequest", (data) {
        dev.log("New call request event received: $data");
        
        // If we're a doctor and have our ID set, update pending requests immediately
        final userController = Get.find<UserController>();
        if (userController.isDoctor && 
            userController.userId.isNotEmpty &&
            data != null && 
            data["doctorId"] == userController.userId) {
          
          dev.log("New call request is for this doctor: ${userController.userId}");
          
          // Update pending requests without showing a loading indicator
          fetchPendingRequests(userController.userId, silent: true);
        }
      });
      
      // Listen for call request status updates
      socket.on("callRequestStatusUpdated", (data) {
        dev.log("Call request status updated: $data");
        
        // If we're a doctor and have our ID set, update pending requests immediately
        final userController = Get.find<UserController>();
        if (userController.isDoctor && userController.userId.isNotEmpty) {
          dev.log("Updating pending requests for doctor: ${userController.userId}");
          fetchPendingRequests(userController.userId, silent: true);
        }
      });
    }
  }
  
  // Clear incoming call offer
  void clearIncomingCall() {
    incomingSDPOffer.value = null;
    currentDoctorDetails.value = null;
  }
  
  // Fetch doctor details by ID
  Future<void> fetchDoctorDetails(String doctorId) async {
    try {
      dev.log('Fetching doctor details for ID: $doctorId');
      final response = await _dio.get('/api/doctors/$doctorId');
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        currentDoctorDetails.value = response.data['data'];
        dev.log('Doctor details fetched successfully: ${currentDoctorDetails.value?['doctorName']}');
      } else {
        dev.log('Failed to fetch doctor details: ${response.data['message']}');
      }
    } catch (e) {
      dev.log('Error fetching doctor details: $e');
    }
  }
  
  // Fetch all active doctors
  Future<bool> fetchActiveDoctors({bool silent = false}) async {
    if (!silent) {
      isLoading.value = true;
      error.value = '';
    }
    
    try {
      final response = await _dio.get('/api/video-call/active-doctors');
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        activeDoctors.value = response.data['data'];
        if (activeDoctors.isNotEmpty) {
          dev.log('Fetched ${activeDoctors.length} active doctors');
        } else {
          dev.log('No active doctors found');
        }
        return true;
      } else {
        if (!silent) {
          error.value = response.data['message'] ?? 'Failed to fetch active doctors';
        }
        dev.log('Failed to fetch active doctors: ${response.data['message']}');
        return false;
      }
    } catch (e) {
      if (!silent) {
        error.value = 'Network error: $e';
      }
      dev.log('Error fetching active doctors: $e');
      return false;
    } finally {
      if (!silent) {
        isLoading.value = false;
      }
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
        '/api/video-call/request-call',
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
  Future<bool> fetchPendingRequests(String doctorId, {bool silent = false}) async {
    if (!silent) {
      isLoading.value = true;
      error.value = '';
    }
    
    this.doctorId.value = doctorId;
    
    try {
      final response = await _dio.get('/api/video-call/pending-requests/$doctorId');
      
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
        
        if (pendingRequests.isNotEmpty) {
          dev.log('Fetched ${pendingRequests.length} pending requests');
        } else {
          dev.log('No pending requests found');
        }
        
        return true;
      } else {
        if (!silent) {
          error.value = response.data['message'] ?? 'Failed to fetch pending requests';
        }
        dev.log('Failed to fetch pending requests: ${response.data['message']}');
        return false;
      }
    } catch (e) {
      if (!silent) {
        error.value = 'Network error: $e';
      }
      dev.log('Error fetching pending requests: $e');
      return false;
    } finally {
      if (!silent) {
        isLoading.value = false;
      }
    }
  }
  
  // Update call request status
  Future<bool> updateCallRequestStatus(String requestId, String status) async {
    isLoading.value = true;
    error.value = '';
    
    try {
      final response = await _dio.patch(
        '/api/video-call/request/$requestId',
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
  
  @override
  void onClose() {
    // Clean up socket listeners when controller is closed
    final socket = SignallingService.instance.socket;
    if (socket != null) {
      socket.off("doctorStatusChanged");
      socket.off("newCallRequest");
      socket.off("callRequestStatusUpdated");
    }
    super.onClose();
  }
} 