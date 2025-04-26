import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../routes/app_routes.dart';

/// Global controller for managing user data across the app
class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();

  // Observable user data
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxString callerId = ''.obs;
  final RxBool isLoggedIn = false.obs;
  
  // Used to prevent redirect loops
  bool _isRedirecting = false;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  /// Load user data from storage service
  void loadUserData() {
    final storageService = StorageService.instance;
    
    // Load caller ID
    callerId.value = storageService.getCallerId();
    
    // Load user data and login status
    user.value = storageService.getUserData();
    isLoggedIn.value = storageService.isUserLoggedIn();
    
    dev.log('UserController: User data loaded');
    if (user.value != null) {
      dev.log('UserController: Logged in as ${user.value!.name}, isDoctor: ${user.value!.isDoctor}');
    } else {
      dev.log('UserController: No user data found');
    }
  }

  /// Check if the user is logged in and redirect to login if not
  bool validateUser() {
    if (user.value == null || !isLoggedIn.value) {
      dev.log('UserController: User validation failed');
      
      // Prevent redirect loops
      if (!_isRedirecting) {
        _isRedirecting = true;
        
        // Use Future.delayed to ensure this happens outside the build phase
        Future.delayed(Duration.zero, () {
          if (Get.currentRoute != AppRoutes.login) {
            dev.log('UserController: Redirecting to login screen');
            Get.offAllNamed(AppRoutes.login);
          }
          _isRedirecting = false;
        });
      }
      return false;
    }
    return true;
  }

  /// Get user ID safely
  String get userId => user.value?.id ?? '';

  /// Get user name safely
  String get userName => user.value?.name ?? '';

  /// Get user email safely
  String get email => user.value?.email ?? '';

  /// Check if user is a doctor
  bool get isDoctor => user.value?.isDoctor ?? false;

  /// Get user specialization safely
  String? get specialization => user.value?.specialization;

  /// Get user image data safely
  String? get imageBase64 => user.value?.imageBase64;

  /// Handle user logout
  Future<void> logout() async {
    dev.log('UserController: Logging out user');
    await StorageService.instance.clearUserData();
    user.value = null;
    isLoggedIn.value = false;
    
    // Prevent redirect loops
    if (!_isRedirecting) {
      _isRedirecting = true;
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(AppRoutes.login);
        _isRedirecting = false;
      });
    }
  }
} 