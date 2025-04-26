import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../routes/app_routes.dart';
import 'user_controller.dart';

/// Unified controller for managing navigation across the app
class NavigationController extends GetxController {
  static NavigationController get to => Get.find<NavigationController>();
  
  // Observable navigation state
  final RxInt currentIndex = 0.obs;
  
  // Navigation destinations
  static const int HOME_INDEX = 0;
  static const int VIDEO_CALL_INDEX = 1;
  static const int  BLOGS_INDEX= 2;
  static const int PROFILE_INDEX = 3;

  // Navigation items definition
  final List<NavigationItem> navigationItems = [
    NavigationItem(
      index: HOME_INDEX,
      route: AppRoutes.home,
      icon: 'home',
      label: 'Home',
    ),
    NavigationItem(
      index: VIDEO_CALL_INDEX,
      route: AppRoutes.videoCall,
      icon: 'videocam',
      label: 'Video Call',
    ),
    NavigationItem(
      index: BLOGS_INDEX,
      route: AppRoutes.blogs,
      icon: 'message_outlined',
      label: 'Blogs',
    ),
    NavigationItem(
      index: PROFILE_INDEX,
      route: AppRoutes.profile,
      icon: 'person',
      label: 'Profile',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    dev.log('NavigationController initialized');
    
    // Listen to route changes and update current index accordingly
    ever(currentIndex, (index) {
      dev.log('Navigation index changed to $index');
    });
  }

  /// Change the current navigation index and navigate to the corresponding screen
  void changeTab(int index) {
    // Only navigate if the index is different
    if (currentIndex.value != index) {
      dev.log('Changing tab to $index');
      
      // Update index for UI
      currentIndex.value = index;
      
      // First check if user is logged in
      if (!UserController.to.validateUser()) {
        return;
      }
      
      // Navigate to the appropriate screen
      switch (index) {
        case HOME_INDEX:
          Get.offAllNamed(AppRoutes.home);
          break;
        case BLOGS_INDEX:
          Get.offAllNamed(AppRoutes.blogs);
          break;
        case VIDEO_CALL_INDEX:
          // Navigate based on user type
          if (UserController.to.isDoctor) {
            Get.offAllNamed(AppRoutes.doctorPendingCalls);
          } else {
            Get.offAllNamed(AppRoutes.activeDoctors);
          }
          break;
        case PROFILE_INDEX:
          Get.offAllNamed(AppRoutes.profile);
          break;
      }
    }
  }

  
  /// Update current index based on the current route
  void updateIndexFromRoute(String route) {
    switch (route) {
      case AppRoutes.home:
        currentIndex.value = HOME_INDEX;
        break;
      case AppRoutes.blogs:
        currentIndex.value = BLOGS_INDEX;
        break;
      case AppRoutes.activeDoctors:
      case AppRoutes.doctorPendingCalls:
        currentIndex.value = VIDEO_CALL_INDEX;
        break;
      case AppRoutes.profile:
        currentIndex.value = PROFILE_INDEX;
        break;
    }
  }
}

/// Model class for navigation items
class NavigationItem {
  final int index;
  final String route;
  final String icon;
  final String label;
  
  NavigationItem({
    required this.index,
    required this.route,
    required this.icon,
    required this.label,
  });
} 