import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class _PendingCallsScreenState extends State<PendingCallsScreen> {
  final CallingController _callingController = Get.find<CallingController>();
  final UserController _userController = Get.find<UserController>();
  String? _selectedPatientCallerId;
  String? _selectedRequestId;

  @override
  void initState() {
    super.initState();
    _fetchPendingRequests();
  }

  Future<void> _fetchPendingRequests() async {
    await _callingController.fetchPendingRequests(_userController.userId);
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
        title: const Text('Accept Call Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Accept call request from $patientName?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A7DE1),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _updateRequestStatus(requestId, 'accepted');
            },
            child: const Text('Accept & Start Call'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Pending Call Requests',
          style: TextStyle(
          color: ThemeConstants.accentColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPendingRequests,
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            if (_callingController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (_callingController.error.value.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _callingController.error.value,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _fetchPendingRequests,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (_callingController.pendingRequests.isEmpty) {
              return const Center(
                child: Text(
                  'No pending call requests',
                  style: TextStyle(fontSize: 16),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _callingController.pendingRequests.length,
                        itemBuilder: (context, index) {
                          final request = _callingController.pendingRequests[index];
                          final patient = request['patientId'];
                          final patientName = patient['userName'] ?? 'Unknown Patient';
                          final patientAge = patient['age']?.toString() ?? 'N/A';
                          final patientGender = patient['gender'] ?? 'N/A';
                          final patientCallerId = request['patientCallerId'] ?? '';
                          final requestedAt = DateTime.parse(request['requestedAt']);
                          final formattedTime = '${requestedAt.hour}:${requestedAt.minute.toString().padLeft(2, '0')}';

                          return Card(
                            color: Color(0XFFC3DEA9),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                        child: Icon(Icons.person),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              patientName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              '$patientAge years, $patientGender',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade100,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Requested at $formattedTime',
                                          style: TextStyle(
                                            color: Colors.orange.shade800,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _updateRequestStatus(request['_id'], 'rejected'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ThemeConstants.dangerColor,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('Reject'),
                                      ),
                                      const SizedBox(width: 12),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ThemeConstants.primaryColor,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () => _showAcceptDialog(
                                          request['_id'],
                                          patientCallerId,
                                          patientName,
                                        ),
                                        child: const Text('Accept'),
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
          
          // Incoming call overlay
          Obx(() {
            final incomingOffer = _callingController.incomingSDPOffer.value;
            if (incomingOffer != null) {
              return Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF2A7DE1), width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Incoming Call from ${incomingOffer["callerId"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.call_end),
                              color: Colors.redAccent,
                              onPressed: () {
                                _callingController.clearIncomingCall();
                              },
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              icon: const Icon(Icons.call),
                              color: Colors.greenAccent,
                              onPressed: () {
                                _joinCall(
                                  callerId: incomingOffer["callerId"]!,
                                  calleeId: widget.selfCallerId,
                                  offer: incomingOffer["sdpOffer"],
                                  requestId: incomingOffer["_id"],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
} 