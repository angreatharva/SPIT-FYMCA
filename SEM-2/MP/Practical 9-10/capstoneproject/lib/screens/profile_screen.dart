import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/theme_constants.dart';
import '../widgets/custom_bottom_nav.dart';

class ProfileScreen extends GetView<NavigationController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get controllers
    final userController = Get.find<UserController>();
    final doctorController = Get.find<DoctorController>();
    
    // Update navigation index
    controller.updateIndexFromRoute('/profile');
    
    // Validate user is logged in
    if (!userController.validateUser()) {
      return const SizedBox.shrink(); // User will be redirected by the controller
    }
    
    // Fetch doctor status if user is a doctor
    if (userController.isDoctor && userController.userId.isNotEmpty) {
      doctorController.fetchDoctorStatus(userController.userId);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile', style: TextStyle(
          color: ThemeConstants.accentColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => userController.logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: _buildProfileImage(userController.imageBase64),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.all(16),
              color: Color(0XFFC3DEA9),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      'Name: ${userController.userName}',
                      style: const TextStyle(fontSize: 18),
                    )),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                      'Email: ${userController.email}',
                      style: const TextStyle(fontSize: 18),
                    )),
                    if (userController.specialization != null && userController.specialization!.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Obx(() => Text(
                        'Specialization: ${userController.specialization}',
                        style: const TextStyle(fontSize: 18),
                      )),
                    ],
                    if (userController.isDoctor && userController.userId.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      _buildDoctorStatusSection(doctorController, userController.userId),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  Widget _buildProfileImage(String? imageBase64) {
    if (imageBase64 == null || imageBase64.isEmpty) {
      dev.log('Using default avatar - no image data provided');
      return const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, size: 50, color: Colors.white),
      );
    }

    try {
      // Clean the base64 string if it contains data URI prefix
      final cleanBase64 = imageBase64.replaceAll(RegExp(r'data:image/\w+;base64,'), '');
      dev.log('Decoding base64 image of length: ${cleanBase64.length}');
      final imageBytes = base64Decode(cleanBase64);
      
      return CircleAvatar(
        radius: 50,
        backgroundImage: MemoryImage(imageBytes),
        onBackgroundImageError: (exception, stackTrace) {
          dev.log('Error loading profile image: $exception');
        },
        backgroundColor: Colors.grey[200],
        child: const Icon(Icons.person, size: 50, color: Colors.grey),
      );
    } catch (e) {
      dev.log('Error decoding base64 image: $e');
      return const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, size: 50, color: Colors.white),
      );
    }
  }

  Widget _buildDoctorStatusSection(DoctorController controller, String userId) {
    return Obx(() {
      final isActive = controller.doctorStatus.value;
      final isToggling = controller.isToggling.value;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Availability Status:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isActive ? 'You are currently available' : 'You are currently unavailable',
                style: TextStyle(
                  color: isActive ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isToggling
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isActive ? Colors.green : Colors.grey,
                      ),
                    ),
                  ) 
                : Switch(
                    value: isActive,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      dev.log('Toggling doctor status for ID: $userId');
                      controller.toggleDoctorStatus(userId);
                    },
                  ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            isActive 
                ? 'Patients can see your profile and request consultations'
                : 'Set yourself as available to receive consultation requests',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          if (isToggling) ...[
            const SizedBox(height: 8),
            Text(
              'Updating your status...',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      );
    });
  }
} 