import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'dart:convert';

import '../models/user_model.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/signalling.service.dart';
import '../services/storage_service.dart';
import '../controllers/user_controller.dart';
import '../controllers/health_controller.dart';

class LoginController extends GetxController {
  GlobalKey<FormState>? formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final isLoading = false.obs;
  final String selfCallerId;
  
  // Track whether controllers are disposed
  bool _controllersDisposed = false;
  
  LoginController({required this.selfCallerId});

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers here to avoid reusing disposed controllers
    _createControllers();
    
    // Create a default formKey if none is provided
    formKey ??= GlobalKey<FormState>();
  }
  
  // Create fresh controllers
  void _createControllers() {
    // Create new controllers
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _controllersDisposed = false;
  }
  
  // Safely dispose controllers
  void _disposeControllersSafely() {
    try {
      if (!_controllersDisposed) {
        // emailController.dispose();
        // passwordController.dispose();
        _controllersDisposed = true;
      }
    } catch (e) {
      // Ignore errors from already disposed controllers
      dev.log('Warning: Error disposing controllers: $e');
    }
  }

  // Set the form key from outside
  void setFormKey(GlobalKey<FormState> key) {
    formKey = key;
  }

  Future<void> handleLogin() async {
    if (formKey == null || !formKey!.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final response = await AuthService.instance.login(
        emailController.text,
        passwordController.text,
      );

      if (response['success']) {
        final bool isDoctor = response['role'] == 'doctor';
        final String userId = response['userId'] ?? '';
        final String userName = response['userName'] ?? '';
        final String email = response['email'] ?? '';
        
        dev.log('Login successful as ${isDoctor ? "doctor" : "patient"}');
        dev.log('User details: ID=$userId, Name=$userName');
        
        // Process image data if available
        String? imageBase64;
        if (response['image'] != null) {
          try {
            if (response['image'] is String) {
              imageBase64 = response['image'];
            } else if (response['image']['data'] != null) {
              final List<int> imageBytes = List<int>.from(response['image']['data']);
              imageBase64 = base64Encode(imageBytes);
            }
            
            if (imageBase64 != null) {
              dev.log('Image data processed successfully');
            }
          } catch (e) {
            dev.log('Error processing image data: $e');
          }
        }
        
        // Create user model and save to storage
        final userModel = UserModel(
          id: userId,
          name: userName,
          email: email,
          isDoctor: isDoctor,
          specialization: isDoctor ? response['specialization'] : null,
          imageBase64: imageBase64,
        );
        
        await StorageService.instance.saveUserData(userModel);
        dev.log('User data saved to storage');
        
        // Update the caller ID to use the user ID after login
        dev.log('Updating caller ID to use user ID: $userId');
        await StorageService.instance.saveCallerId(userId);
        
        // Verify the caller ID was saved correctly
        final savedCallerId = StorageService.instance.getCallerId();
        dev.log('Verified caller ID in storage: $savedCallerId');
        
        // Update the caller ID in the signaling service
        dev.log('Updating signaling service with new caller ID: $userId');
        SignallingService.instance.updateCallerId(userId);
        
        // Update the injected caller ID
        dev.log('Updating injected caller ID to: $userId');
        if (Get.isRegistered(tag: 'selfCallerId')) {
          Get.delete(tag: 'selfCallerId');
        }
        Get.put(userId, tag: 'selfCallerId', permanent: true);
        
        // Update the UserController
        try {
          final userController = Get.find<UserController>();
          userController.loadUserData();
          
          // Reload health data for the new user
          if (Get.isRegistered<HealthController>()) {
            final healthController = Get.find<HealthController>();
            // Reset the data first to avoid showing previous user's data
            healthController.healthTracking.value = healthController.createEmptyHealthTracking();
            healthController.trackingId.value = '';
            
            // Reinitialize the userId in the health controller
            healthController.userId = userId;
            
            // Wait longer to ensure user data is fully loaded before fetching health data
            Future.delayed(Duration(milliseconds: 300), () {
              healthController.loadHealthData();
              dev.log('Reloaded health data for new user login');
            });
          }
        } catch (e) {
          dev.log('Error updating UserController: $e');
        }
        
        // Reset loading state before navigation
        isLoading.value = false;
        
        // Use a safer navigation approach with a delay
        Future.delayed(const Duration(milliseconds: 200), () {
          Get.offAllNamed(AppRoutes.home);
        });
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Login Failed',
          response['message'] ?? 'Unknown error occurred',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      dev.log('Login error: $e');
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void goToUserRegistration() {
    Get.toNamed(AppRoutes.userRegistration);
  }

  void goToDoctorRegistration() {
    Get.toNamed(AppRoutes.doctorRegistration);
  }

  @override
  void onClose() {
    // Safely dispose controllers
    _disposeControllersSafely();
    super.onClose();
  }
} 