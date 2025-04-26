import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/signalling.service.dart';
import '../screens/call_screen.dart';
import '../models/call_request.dart';
import '../controllers/call_request_controller.dart';

class JoinController extends GetxController {
  final String selfCallerId;
  final bool role;
  final String userId;
  final String userName;
  
  // Observable properties
  final remoteCallerId = ''.obs;
  final Rx<Map<String, dynamic>?> incomingSDPOffer = Rx<Map<String, dynamic>?>(null);
  final Rx<CallRequest?> activeCallRequest = Rx<CallRequest?>(null);

  JoinController({
    required this.selfCallerId,
    required this.role,
    required this.userId,
    required this.userName,
  });

  @override
  void onInit() {
    super.onInit();
    // Listen for incoming video call
    SignallingService.instance.socket!.on("newCall", (data) {
      incomingSDPOffer.value = data;
    });
    
    // Get call request from arguments if available
    if (Get.arguments != null && Get.arguments['callRequest'] != null) {
      activeCallRequest.value = Get.arguments['callRequest'] as CallRequest;
      
      // Set remote caller ID automatically if from call request
      if (Get.arguments['remoteCallerId'] != null) {
        remoteCallerId.value = Get.arguments['remoteCallerId'];
      }
    }
  }

  void setRemoteCallerId(String value) {
    remoteCallerId.value = value;
  }

  void rejectCall() {
    incomingSDPOffer.value = null;
  }

  void joinCall({
    required String callerId,
    required String calleeId,
    dynamic offer,
  }) {
    // Complete the call request if it exists
    CallRequestController callRequestController;
    try {
      callRequestController = Get.find<CallRequestController>();
      if (activeCallRequest.value != null) {
        callRequestController.completeCallRequest(activeCallRequest.value!.id);
      }
    } catch (_) {
      // CallRequestController not found, continue without it
    }
    
    Get.to(
      () => CallScreen(
        callerId: callerId,
        calleeId: calleeId,
        offer: offer,
        isDoctor: role,
        // userId: userId,
        // userName: userName,
      ),
    );
    
    if (offer != null) {
      incomingSDPOffer.value = null;
    }
  }

  @override
  void onClose() {
    SignallingService.instance.socket?.off("newCall");
    super.onClose();
  }
} 