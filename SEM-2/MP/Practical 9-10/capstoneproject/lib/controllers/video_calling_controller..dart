import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'dart:developer' as dev;

import '../screens/profile_screen.dart';

class VideoCallingController extends GetxController {
  final RxInt selectedFilterIndex = 1.obs;
  final RxInt selectedNavIndex = 1.obs; // Home is index 0
  final String selfCallerId;
  final String userId;
  final String userName;
  final String email;
  final bool isDoctor;
  final String? specialization;
  final String? imageBase64;

  VideoCallingController({
    required this.selfCallerId,
    required this.userId,
    required this.userName,
    required this.email,
    required this.isDoctor,
    this.specialization,
    this.imageBase64,
  }) {
    // Log all parameters for debugging
    dev.log('HomeController initialized with:');
    dev.log('userId: $userId, userName: $userName');
    dev.log('email: $email, isDoctor: $isDoctor');
    dev.log('specialization: $specialization');
    dev.log('Has image data: ${imageBase64 != null && imageBase64!.isNotEmpty}');
  }

  void changeFilter(int index) {
    selectedFilterIndex.value = index;
  }

  void changeNavIndex(int index) {
    // Only navigate if the index is different
    if (selectedNavIndex.value != index) {
      // Update the index first for UI
      selectedNavIndex.value = index;

      // Navigate to the appropriate page without stacking
      switch (index) {
        case 0:
          Get.offAllNamed(AppRoutes.home);
          break;
        case 4: // Profile
          dev.log('Navigating to ProfileScreen with:');
          dev.log('isDoctor: $isDoctor, userId: $userId');
          dev.log('email: $email, specialization: $specialization');
          dev.log('Has image data: ${imageBase64 != null && imageBase64!.isNotEmpty}');

          final args = {
            'userId': userId,
            'name': userName,
            'email': email,
            'isDoctor': isDoctor,
            'specialization': specialization,
            'selfCallerId': selfCallerId,
            'imageBase64': imageBase64,
          };

          Get.offAllNamed(
            AppRoutes.profile,
            arguments: args,
          );
          break;
      // Add other cases as needed (index 1, 2, 3)
      }
    }
  }

  void startVideoCall() {
    dev.log('Starting video call with:');
    dev.log('selfCallerId: $selfCallerId, isDoctor: $isDoctor');
    dev.log('userId: $userId, userName: $userName');

    Get.toNamed(
      AppRoutes.joinScreen,
      arguments: {
        'selfCallerId': selfCallerId,
        'role': isDoctor,
        'userId': userId,
        'userName': userName,
      },
    );
  }
}