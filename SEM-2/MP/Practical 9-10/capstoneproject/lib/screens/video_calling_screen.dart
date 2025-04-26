import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

import '../controllers/doctor_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/call_request_controller.dart';
import '../models/doctor.dart';
import '../models/call_request.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_bottom_nav.dart';
import '../services/signalling.service.dart';
import '../screens/call_screen.dart';

class VideoCallingScreen extends StatefulWidget {
  const VideoCallingScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallingScreen> createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  // UI variables
  final Color _primaryColor = const Color(0xFF2A7DE1);
  final Color _accentColor = const Color(0xFF1E5BB6);
  final Color _backgroundColor = const Color(0xFFE8EDDE);
  final Color _secondaryColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  
  // Filters for doctor selection
  final List<String> filters = ['All', 'General', 'Specialist'];
  
  @override
  void initState() {
    super.initState();
    dev.log("🏁 VideoCallingScreen initialized");
    // Setup will be done in build since we need access to controllers
  }
  
  @override
  void dispose() {
    // Clean up socket listeners
    dev.log("🧹 Cleaning up VideoCallingScreen resources");
    SignallingService.instance.socket?.off('callRequestAccepted');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get controllers
    final navigationController = Get.find<NavigationController>();
    final userController = Get.find<UserController>();
    final doctorController = Get.find<DoctorController>();
    
    // Initialize call request controller
    final callRequestController = Get.put(CallRequestController());
    
    // Validate user is logged in
    if (!userController.validateUser()) {
      return const SizedBox.shrink(); // User will be redirected by the controller
    }
    
    // Fetch appropriate data based on user role
    if (userController.isDoctor) {
      // Fetch pending call requests for doctor
      callRequestController.fetchDoctorCallRequests(userController.userId);
    } else {
      // Fetch available doctors for patient
      doctorController.fetchAvailableDoctors();
      
      // Setup listener for when doctor accepts the call request
      _setupCallAcceptedListener(userController);
    }
    
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              'Welcome ${userController.isDoctor ? "Dr." : ""} ${userController.userName}',
              style: TextStyle(
                color: _accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
            Text(
              userController.isDoctor ? 'Call Requests' : 'Find Available Doctors',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: _accentColor),
            onPressed: () {
              if (userController.isDoctor) {
                callRequestController.fetchDoctorCallRequests(userController.userId);
              } else {
                doctorController.fetchAvailableDoctors();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Only show filters for patients
          if (!userController.isDoctor)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filters.asMap().entries.map((entry) {
                    final index = entry.key;
                    final filter = entry.value;
                    return Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index != filters.length - 1 ? 8.0 : 0,
                        ),
                        child: FilterChip(
                          selected: doctorController.selectedFilterIndex.value == index,
                          label: Text(filter),
                          onSelected: (_) => doctorController.changeFilter(index),
                          backgroundColor: Colors.white,
                          selectedColor: _primaryColor,
                          labelStyle: TextStyle(
                            color: doctorController.selectedFilterIndex.value == index
                                ? Colors.white
                                : _primaryColor,
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
            ),
          
          // Main content - different for patient and doctor
          Expanded(
            child: userController.isDoctor 
                ? _buildDoctorView(callRequestController, userController)
                : _buildPatientView(doctorController, userController, callRequestController),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
  
  // Patient view - shows available doctors
  Widget _buildPatientView(
    DoctorController doctorController, 
    UserController userController,
    CallRequestController callRequestController
  ) {
    return Obx(
      () => doctorController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : doctorController.availableDoctors.isEmpty
              ? _buildEmptyDoctorsView(doctorController)
              : RefreshIndicator(
                  onRefresh: () => doctorController.fetchAvailableDoctors(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: doctorController.availableDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorController.availableDoctors[index];
                      return _buildDoctorCard(
                        doctor: doctor, 
                        userController: userController,
                        callRequestController: callRequestController
                      );
                    },
                  ),
                ),
    );
  }
  
  // Doctor view - shows pending call requests
  Widget _buildDoctorView(
    CallRequestController callRequestController,
    UserController userController
  ) {
    return Obx(
      () => callRequestController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : callRequestController.doctorCallRequests.isEmpty
              ? _buildEmptyRequestsView(callRequestController, userController)
              : RefreshIndicator(
                  onRefresh: () => callRequestController.fetchDoctorCallRequests(userController.userId),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: callRequestController.doctorCallRequests.length,
                    itemBuilder: (context, index) {
                      final request = callRequestController.doctorCallRequests[index];
                      return _buildCallRequestCard(
                        request: request, 
                        userController: userController,
                        callRequestController: callRequestController
                      );
                    },
                  ),
                ),
    );
  }
  
  // Empty state for doctors view
  Widget _buildEmptyDoctorsView(DoctorController doctorController) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medical_services, color: Colors.grey, size: 64),
          const SizedBox(height: 16),
          const Text(
            'No doctors available at the moment',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => doctorController.fetchAvailableDoctors(),
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }
  
  // Empty state for requests view
  Widget _buildEmptyRequestsView(
    CallRequestController callRequestController,
    UserController userController
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videocam_off, color: Colors.grey, size: 64),
          const SizedBox(height: 16),
          const Text(
            'No pending call requests',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => callRequestController.fetchDoctorCallRequests(userController.userId),
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }
  
  // Doctor card for patient view
  Widget _buildDoctorCard({
    required Doctor doctor,
    required UserController userController,
    required CallRequestController callRequestController
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(doctor.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: TextStyle(
                          color: _accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialization,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: _secondaryColor, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            doctor.rating.toStringAsFixed(1),
                            style: TextStyle(
                              color: _secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Obx(() => 
              callRequestController.isRequesting.value 
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: _primaryColor,
                    child: IconButton(
                      icon: const Icon(Icons.video_call, color: Colors.white),
                      onPressed: () {
                        // Request video call with doctor
                        callRequestController.requestVideoCall(
                          patientId: userController.userId,
                          patientName: userController.userName,
                          patientCallerId: userController.callerId.value,
                          doctor: doctor,
                        );
                      },
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Call request card for doctor view
  Widget _buildCallRequestCard({
    required CallRequest request,
    required UserController userController,
    required CallRequestController callRequestController
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient info
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: _accentColor,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.patientName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Patient ID: ${request.patientId.substring(0, 8)}...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Request timestamp
            Text(
              'Request received: ${_formatRequestTime(request.createdAt)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            // Action buttons
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Reject button
                OutlinedButton.icon(
                  icon: Icon(Icons.close, color: _dangerColor),
                  label: Text(
                    'Reject',
                    style: TextStyle(color: _dangerColor),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: _dangerColor),
                  ),
                  onPressed: () {
                    callRequestController.rejectCallRequest(request);
                  },
                ),
                const SizedBox(width: 12),
                
                // Accept button
                ElevatedButton.icon(
                  icon: const Icon(Icons.video_call, color: Colors.white),
                  label: const Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _secondaryColor,
                  ),
                  onPressed: () {
                    callRequestController.acceptCallRequest(
                      request: request,
                      selfCallerId: userController.callerId.value,
                      isDoctor: userController.isDoctor,
                      userId: userController.userId,
                      userName: userController.userName,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // Format request time to a readable format
  String _formatRequestTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
  
  // Setup listener for call request acceptance notification
  void _setupCallAcceptedListener(UserController userController) {
    try {
      // Remove any existing listener to avoid duplicates
      dev.log("🔄 Setting up call acceptance listener for patient");
      SignallingService.instance.socket?.off('callRequestAccepted');
      
      // Listen for call request accepted event
      SignallingService.instance.socket?.on('callRequestAccepted', (data) {
        dev.log('📱 Received callRequestAccepted event: $data');
        final String doctorCallerId = data['doctorCallerId'];
        final String doctorName = data['doctorName'];
        
        // Show notification to the patient
        dev.log('🔔 Showing notification for accepted call request');
        Get.snackbar(
          'Call Request Accepted',
          'Dr. $doctorName has accepted your call request. Connecting...',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        );
        
        // Give time for the snackbar to be visible, then navigate to call screen
        dev.log('⏱️ Scheduling navigation to call screen in 1.5 seconds');
        Future.delayed(const Duration(milliseconds: 1500), () {
          // Navigate to call screen to receive the call
          dev.log('🚀 Navigating to CallScreen - callerId: $doctorCallerId, calleeId: ${userController.callerId.value}');
          Get.to(() => CallScreen(
            callerId: doctorCallerId,
            calleeId: userController.callerId.value,
            offer: null,
            isDoctor: false, // Patient
          ));
        });
      });
      
      dev.log('✅ Call acceptance listener set up for patient');
    } catch (e) {
      dev.log('❌ Error setting up call acceptance listener: $e');
    }
  }
}