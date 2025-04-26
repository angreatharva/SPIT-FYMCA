import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'dart:convert';

import '../models/user_model.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../controllers/user_controller.dart';

class LoginController extends GetxController {
  // Change from final to a regular variable that can be updated
  GlobalKey<FormState>? formKey;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final String selfCallerId;
  
  LoginController({required this.selfCallerId});

  @override
  void onInit() {
    super.onInit();
    // Create a default formKey if none is provided
    formKey ??= GlobalKey<FormState>();
    // Clear form fields on init to avoid stale data
    emailController.clear();
    passwordController.clear();
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
        
        // Update the UserController
        try {
          final userController = Get.find<UserController>();
          userController.loadUserData();
        } catch (e) {
          dev.log('Error updating UserController: $e');
        }
        
        // Reset loading state and navigate to home
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
} 