import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'dart:developer' as dev;


class HomeController extends GetxController {
  final RxInt selectedFilterIndex = 0.obs;
  final RxInt selectedNavIndex = 0.obs; // Home is index 0
  
  // User data from constructor (will be removed later)
  final String selfCallerId;
  final String userId;
  final String userName;
  final String email;
  final bool isDoctor;
  final String? specialization;
  final String? imageBase64;

  HomeController({
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
        case 0: // Home - Already on home, do nothing
          break;
        case 4: // Profile
          dev.log('Navigating to ProfileScreen');
          Get.offAllNamed(AppRoutes.profile);
          break;
        // Add other cases as needed (index 1, 2, 3)
      }
    }
  }

  void startVideoCall() {
    dev.log('Starting video call');
    Get.toNamed(AppRoutes.roleSelection);
  }
} 