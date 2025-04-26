import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme_constants.dart';
import '../widgets/custom_bottom_nav.dart';
import '../controllers/user_controller.dart';
import '../controllers/calling_controller.dart';
import 'call_screen.dart';

class ActiveDoctorsScreen extends StatefulWidget {
  final String selfCallerId;

  const ActiveDoctorsScreen({super.key, required this.selfCallerId});

  @override
  State<ActiveDoctorsScreen> createState() => _ActiveDoctorsScreenState();
}

class _ActiveDoctorsScreenState extends State<ActiveDoctorsScreen> {
  final CallingController _callingController = Get.find<CallingController>();
  final UserController _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _fetchActiveDoctors();
  }

  Future<void> _fetchActiveDoctors() async {
    await _callingController.fetchActiveDoctors();
  }

  Future<void> _requestVideoCall(String doctorId) async {
    final success = await _callingController.requestVideoCall(
      patientId: _userController.userId,
      doctorId: doctorId,
      patientCallerId: widget.selfCallerId,
    );

    if (success) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Call request sent successfully! Please wait for doctor to accept.'),
          backgroundColor: Colors.green,
        ),
      );
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
        toolbarHeight: Get.height * 0.1,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Available Doctors',
              style: TextStyle(
              color: ThemeConstants.accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),),
            const Text(
              'Tele-Consultation',
              style: TextStyle(color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,),
              maxLines: 2,
            ),
          ],
        ),
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
                      onPressed: _fetchActiveDoctors,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (_callingController.activeDoctors.isEmpty) {
              return const Center(
                child: Text(
                  'No doctors are currently available',
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
                        itemCount: _callingController.activeDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = _callingController.activeDoctors[index];
                          return Card(
                            color: Color(0XFFC3DEA9),
                            elevation: 3,
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  // Doctor image
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[200],
                                    child: const Icon(Icons.person, size: 40),
                                  ),
                                  const SizedBox(width: 16),
                                  // Doctor info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doctor['doctorName'] ?? 'Unknown',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          doctor['specialization'] ?? 'General',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          doctor['qualification'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Request call button
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ThemeConstants.primaryColor,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () => _requestVideoCall(doctor['_id']),
                                          child: const Text('Request Call'),
                                        ),
                                      ],
                                    ),
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
                top: 0,
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
                                  requestId: incomingOffer["requestId"],
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