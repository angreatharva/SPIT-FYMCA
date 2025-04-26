import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/storage_service.dart';
import 'dart:developer' as dev;

class ProfileController extends GetxController {
  final RxInt selectedNavIndex = 4.obs;  // Profile is index 4
  
  ProfileController() {
    dev.log('ProfileController initialized');
  }

  @override
  void onInit() {
    super.onInit();
    _validateUserData();
  }
  
  // Validate that we have user data, redirect to login if not
  void _validateUserData() {
    final storageService = StorageService.instance;
    if (!storageService.isUserLoggedIn()) {
      dev.log('User not logged in, redirecting to login screen');
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void changeNavIndex(int index) {
    // Only navigate if the index is different
    if (selectedNavIndex.value != index) {
      // Update the index first for UI
      selectedNavIndex.value = index;
      
      // Navigate to the appropriate page without stacking
      switch (index) {
        case 0: // Home
          Get.offAllNamed(AppRoutes.home);
          break;
        // Add other cases as needed (index 1, 2, 3)
        case 4: // Profile - Already on profile, do nothing
          break;
      }
    }
  }

  void startVideoCall() {
    dev.log('Starting video call from profile');
    Get.toNamed(AppRoutes.roleSelection);
  }
  
  // Method to log out the user
  void logout() {
    dev.log('User logging out');
    StorageService.instance.clearUserData();
    Get.offAllNamed(AppRoutes.login);
  }
}