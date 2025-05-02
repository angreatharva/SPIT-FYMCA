import 'dart:developer';

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
        SnackBar(
          content: Text(
            'Call request sent successfully! Please wait for doctor to accept.',
            style: TextStyle(fontSize: Get.width * 0.035),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _callingController.error.value,
            style: TextStyle(fontSize: Get.width * 0.035),
          ),
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
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.backgroundColor,
        toolbarHeight: Get.height * 0.08,
        title: Text(
          'Available Doctors',
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
            onPressed: _fetchActiveDoctors,
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
                  'Tele-Consultation',
                  style: TextStyle(
                    fontSize: Get.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: ThemeConstants.accentColor,
                  ),
                ),
                SizedBox(height: Get.height * 0.005),
                Text(
                  'Connect with doctors for video consultation',
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
                            onPressed: _fetchActiveDoctors,
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
                              style: TextStyle(fontSize: Get.width * 0.04),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (_callingController.activeDoctors.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medical_services,
                            color: const Color(0xFF284C1C),
                            size: Get.width * 0.15,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Text(
                            'No doctors are currently available',
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
                      child: ListView.builder(
                        itemCount: _callingController.activeDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = _callingController.activeDoctors[index];
                          log("Doctor ID: ${doctor}");
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
                                      // Doctor image
                                      CircleAvatar(
                                        radius: Get.width * 0.075,
                                        backgroundColor: const Color(0xFF284C1C),
                                        child: Icon(
                                          Icons.person,
                                          size: Get.width * 0.09,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.04),
                                      // Doctor info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctor['doctorName'] ?? 'Unknown',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Get.width * 0.045,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: Get.height * 0.005),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.025, 
                                                vertical: Get.height * 0.005
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.7),
                                                borderRadius: BorderRadius.circular(Get.width * 0.04),
                                              ),
                                              child: Text(
                                                doctor['specialization'] ?? 'General',
                                                style: TextStyle(
                                                  fontSize: Get.width * 0.035,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.015),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.medical_information,
                                        size: Get.width * 0.04,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(width: Get.width * 0.02),
                                      Expanded(
                                        child: Text(
                                          doctor['specialization'] != null
                                              ? 'Specialist in ${doctor['specialization']}'
                                              : 'General Practitioner',
                                          style: TextStyle(
                                            fontSize: Get.width * 0.035,
                                            color: Colors.black87,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.video_call,
                                        size: Get.width * 0.06,
                                      ),
                                      label: Text(
                                        'Request Video Call',
                                        style: TextStyle(fontSize: Get.width * 0.035),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF284C1C),
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.04, 
                                          vertical: Get.height * 0.012
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Get.width * 0.50),
                                        ),
                                      ),
                                      onPressed: () => _requestVideoCall(doctor['_id']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),

                // Incoming call overlay
                Obx(() {
                  final incomingOffer = _callingController.incomingSDPOffer.value;
                  if (incomingOffer != null) {
                    return Positioned(
                      top: Get.height * 0.02,
                      left: Get.width * 0.04,
                      right: Get.width * 0.04,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(Get.width * 0.06),
                        child: Container(
                          padding: EdgeInsets.all(Get.width * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Get.width * 0.06),
                            border: Border.all(color: const Color(0xFF284C1C), width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Incoming Call from ${incomingOffer["callerId"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width * 0.04,
                                  color: const Color(0xFF284C1C),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.call_end,
                                      size: Get.width * 0.045,
                                    ),
                                    label: Text(
                                      'Decline',
                                      style: TextStyle(fontSize: Get.width * 0.035),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.03, 
                                        vertical: Get.height * 0.01
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Get.width * 0.06),
                                      ),
                                    ),
                                    onPressed: () {
                                      _callingController.clearIncomingCall();
                                    },
                                  ),
                                  SizedBox(width: Get.width * 0.04),
                                  ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.call,
                                      size: Get.width * 0.045,
                                    ),
                                    label: Text(
                                      'Accept',
                                      style: TextStyle(fontSize: Get.width * 0.035),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF284C1C),
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.03, 
                                        vertical: Get.height * 0.01
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Get.width * 0.06),
                                      ),
                                    ),
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
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}