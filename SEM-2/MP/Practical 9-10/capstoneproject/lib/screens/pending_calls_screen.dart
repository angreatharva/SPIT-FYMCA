import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../utils/theme_constants.dart';
import '../widgets/custom_bottom_nav.dart';
import '../controllers/user_controller.dart';
import '../controllers/calling_controller.dart';
import 'call_screen.dart';

class PendingCallsScreen extends StatefulWidget {
  final String selfCallerId;

  const PendingCallsScreen({super.key, required this.selfCallerId});

  @override
  State<PendingCallsScreen> createState() => _PendingCallsScreenState();
}

class _PendingCallsScreenState extends State<PendingCallsScreen> with WidgetsBindingObserver {
  final CallingController _callingController = Get.find<CallingController>();
  final UserController _userController = Get.find<UserController>();
  String? _selectedPatientCallerId;
  String? _selectedRequestId;
  
  // Add a worker to listen for changes
  late Worker _pendingRequestsWorker;

  @override
  void initState() {
    super.initState();
    
    // Add observer to detect when the screen comes back into view
    WidgetsBinding.instance.addObserver(this);
    
    // Fetch requests immediately
    _fetchPendingRequests();
    
    // Set up a worker for real-time updates
    _setupRealTimeUpdates();
    
    dev.log('PendingCallsScreen initialized');
  }
  
  void _setupRealTimeUpdates() {
    // Create a worker to watch for changes in the pendingRequests list
    _pendingRequestsWorker = ever(_callingController.pendingRequests, (requests) {
      dev.log('Pending requests updated in real-time, count: ${requests.length}');
      // No need to do anything else, GetX will automatically update the UI
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When the app resumes, refresh the pending requests
    if (state == AppLifecycleState.resumed) {
      dev.log('PendingCallsScreen resumed, refreshing data');
      _fetchPendingRequests();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // Dispose of the worker when the screen is disposed
    _pendingRequestsWorker.dispose();
    
    // Remove observer
    WidgetsBinding.instance.removeObserver(this);
    
    dev.log('PendingCallsScreen disposed');
    super.dispose();
  }

  Future<void> _fetchPendingRequests() async {
    dev.log('Fetching pending requests for doctor: ${_userController.userId}');
    await _callingController.fetchPendingRequests(_userController.userId);
    dev.log('Pending requests fetched, count: ${_callingController.pendingRequests.length}');
  }

  Future<void> _updateRequestStatus(String requestId, String status) async {
    final success = await _callingController.updateCallRequestStatus(requestId, status);
    
    if (success) {
      // If request was accepted, we'll initiate the call
      if (status == 'accepted' && _selectedPatientCallerId != null) {
        _joinCall(
          callerId: widget.selfCallerId,
          calleeId: _selectedPatientCallerId!,
          offer: null,
          requestId: _selectedRequestId,
        );
      } else {
        // Otherwise, refresh the list
        await _fetchPendingRequests();
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request ${status == 'rejected' ? 'rejected' : 'updated'} successfully'),
            backgroundColor: status == 'rejected' ? Colors.red : Colors.green,
          ),
        );
      }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_callingController.error.value),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAcceptDialog(String requestId, String patientCallerId, String patientName) {
    setState(() {
      _selectedPatientCallerId = patientCallerId;
      _selectedRequestId = requestId;
    });
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Accept Call Request',
          style: TextStyle(
            fontSize: Get.width * 0.045,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accept call request from $patientName?',
              style: TextStyle(
                fontSize: Get.width * 0.04,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.06),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: Get.width * 0.035,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF284C1C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Get.width * 0.06),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
                vertical: Get.height * 0.01,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              _updateRequestStatus(requestId, 'accepted');
            },
            child: Text(
              'Accept & Start Call',
              style: TextStyle(
                fontSize: Get.width * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Join Call (handles both outgoing and incoming calls)
  void _joinCall({
    required String callerId,
    required String calleeId,
    dynamic offer,
    String? requestId,
  }) {
    // Navigate to call screen
    Get.to(() => CallScreen(
      callerId: callerId,
      calleeId: calleeId,
      offer: offer,
      isDoctor: _userController.isDoctor,
      requestId: requestId,
    ));
    
    // Clear incoming call offer
    _callingController.clearIncomingCall();
  }

  @override
  Widget build(BuildContext context) {
    // Refresh when the screen becomes visible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dev.log('PendingCallsScreen is now visible, refreshing data');
      _fetchPendingRequests();
    });
    
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.backgroundColor,
        toolbarHeight: Get.height * 0.08,
        title: Text(
          'Pending Call Requests',
          style: TextStyle(
            color: ThemeConstants.mainColor,
            fontSize: Get.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh, 
              color: const Color(0xFF284C1C),
              size: Get.width * 0.06,
            ),
            onPressed: _fetchPendingRequests,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description text - similar to Health Dashboard
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage your patient call requests',
                  style: TextStyle(
                    fontSize: Get.width * 0.04,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
          
          // Main content
          Expanded(
            child: Stack(
              children: [
                Obx(() {
                  if (_callingController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: const Color(0xFF284C1C),
                      )
                    );
                  } else if (_callingController.error.value.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: Get.width * 0.15,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Text(
                            _callingController.error.value,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: Get.width * 0.04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Get.height * 0.025),
                          ElevatedButton(
                            onPressed: _fetchPendingRequests,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF284C1C),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.06, 
                                vertical: Get.height * 0.015
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Get.width * 0.06),
                              ),
                            ),
                            child: Text(
                              'Retry',
                              style: TextStyle(
                                fontSize: Get.width * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (_callingController.pendingRequests.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.call_missed,
                            color: const Color(0xFF284C1C),
                            size: Get.width * 0.15,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Text(
                            'No pending call requests',
                            style: TextStyle(
                              fontSize: Get.width * 0.04,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(Get.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: _callingController.pendingRequests.length,
                              itemBuilder: (context, index) {
                                final request = _callingController.pendingRequests[index];
                                final patientName = request['patientId']['userName'] ?? 'Unknown Patient';
                                final requestTime = request['requestedAt'] != null
                                    ? DateTime.parse(request['requestedAt'])
                                    : DateTime.now();
                                final formattedTime = "${requestTime.hour}:${requestTime.minute.toString().padLeft(2, '0')}";
                                final requestId = request['_id'] ?? '';
                                final patientCallerId = request['patientCallerId'] ?? '';
                                final status = request['status'] ?? 'pending';
                                
                                // Skip requests that are not pending
                                if (status != 'pending') return const SizedBox.shrink();
                                
                                return Card(
                                  color: const Color(0XFFC3DEA9),
                                  elevation: 3,
                                  margin: EdgeInsets.only(bottom: Get.height * 0.02),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Get.width * 0.06),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(Get.width * 0.04),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // Patient image
                                            CircleAvatar(
                                              radius: Get.width * 0.075,
                                              backgroundColor: const Color(0xFF284C1C),
                                              child: Icon(
                                                Icons.person,
                                                size: Get.width * 0.08,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: Get.width * 0.04),
                                            // Patient info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    patientName,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: Get.width * 0.045,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  SizedBox(height: Get.height * 0.005),
                                                  Text(
                                                    'Requested at $formattedTime',
                                                    style: TextStyle(
                                                      fontSize: Get.width * 0.035,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        Text(
                                          'Patient is waiting for video consultation',
                                          style: TextStyle(
                                            fontSize: Get.width * 0.035,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // Reject button
                                            OutlinedButton(
                                              onPressed: () => _updateRequestStatus(requestId, 'rejected'),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.red,
                                                side: BorderSide(color: Colors.red),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(Get.width * 0.04),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.04,
                                                  vertical: Get.height * 0.01
                                                ),
                                              ),
                                              child: Text(
                                                'Reject',
                                                style: TextStyle(
                                                  fontSize: Get.width * 0.035,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: Get.width * 0.03),
                                            // Accept button
                                            ElevatedButton(
                                              onPressed: () => _showAcceptDialog(requestId, patientCallerId, patientName),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF284C1C),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(Get.width * 0.04),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.04,
                                                  vertical: Get.height * 0.01
                                                ),
                                              ),
                                              child: Text(
                                                'Accept',
                                                style: TextStyle(
                                                  fontSize: Get.width * 0.035,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
} 