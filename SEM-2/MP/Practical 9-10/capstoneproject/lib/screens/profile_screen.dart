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
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.backgroundColor,
        toolbarHeight: Get.height * 0.08,
        title: Text(
          'Profile',
          style: TextStyle(
            color: const Color(0xFF284C1C),
            fontSize: Get.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: const Color(0xFF284C1C),
              size: Get.width * 0.06,
            ),
            onPressed: () => userController.logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Health Information',
                    style: TextStyle(
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: ThemeConstants.accentColor,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.005),
                  Text(
                    'Manage your profile and settings',
                    style: TextStyle(
                      fontSize: Get.width * 0.04,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Get.height * 0.02),

            //Image And Name
            Row(
              children: [
                // Profile image
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: Center(
                    child: _buildProfileImage(userController.imageBase64),
                  ),
                ),

                SizedBox(height: Get.height * 0.02),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User name
                    Center(
                      child: Obx(() => Text(
                        userController.userName,
                        style: TextStyle(
                          fontSize: Get.width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF284C1C),
                        ),
                      )),
                    ),

                    // User email
                    Center(
                      child: Obx(() => Text(
                        userController.email,
                        style: TextStyle(
                          fontSize: Get.width * 0.035,
                          color: Colors.grey[600],
                        ),
                      )),
                    ),
                  ],
                ),

              ],
            ),

            
            SizedBox(height: Get.height * 0.02),
            
            // Profile information card
            Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              decoration: BoxDecoration(
                color: const Color(0XFFC3DEA9),
                borderRadius: BorderRadius.circular(Get.width * 0.06),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(Get.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF284C1C),
                      ),
                    ),
                    
                    SizedBox(height: Get.height * 0.02),
                    
                    // Personal information fields
                    _buildInfoRow(
                      Icons.person,
                      'Name',
                      Obx(() => Text(
                        userController.userName,
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                    
                    Divider(height: Get.height * 0.03),
                    
                    _buildInfoRow(
                      Icons.email,
                      'Email',
                      Obx(() => Text(
                        userController.email,
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                    
                    if (userController.specialization != null && userController.specialization!.isNotEmpty) ...[
                      Divider(height: Get.height * 0.03),
                      _buildInfoRow(
                        Icons.medical_services,
                        'Specialization',
                        Obx(() => Text(
                          userController.specialization ?? '',
                          style: TextStyle(
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            SizedBox(height: Get.height * 0.03),
            
            // Doctor availability section
            if (userController.isDoctor && userController.userId.isNotEmpty) ...[
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Get.width * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(Get.width * 0.05),
                  child: _buildDoctorStatusSection(doctorController, userController.userId),
                ),
              ),
              SizedBox(height: Get.height * 0.1), // Extra padding at bottom
            ],
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, Widget content) {
    return Row(
      children: [
        Icon(
          icon,
          size: Get.width * 0.05,
          color: const Color(0xFF284C1C),
        ),
        SizedBox(width: Get.width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: Get.width * 0.035,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: Get.height * 0.004),
            content,
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage(String? imageBase64) {
    Widget fallbackWidget = Icon(
      Icons.person,
      size: Get.width * 0.15,
      color: Colors.white,
    );
    
    if (imageBase64 == null || imageBase64.isEmpty) {
      dev.log('Using default avatar - no image data provided');
      return Container(
        width: Get.width * 0.25,
        height: Get.width * 0.25,
        decoration: BoxDecoration(
          color: const Color(0xFF284C1C),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: fallbackWidget,
      );
    }

    try {
      // Clean the base64 string if it contains data URI prefix
      final cleanBase64 = imageBase64.replaceAll(RegExp(r'data:image/\w+;base64,'), '');
      dev.log('Decoding base64 image of length: ${cleanBase64.length}');
      final imageBytes = base64Decode(cleanBase64);
      
      return Container(
        width: Get.width * 0.25,
        height: Get.width * 0.25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundImage: MemoryImage(imageBytes),
          onBackgroundImageError: (exception, stackTrace) {
            dev.log('Error loading profile image: $exception');
          },
          backgroundColor: const Color(0xFF284C1C),
          child: fallbackWidget,
        ),
      );
    } catch (e) {
      dev.log('Error decoding base64 image: $e');
      return Container(
        width: Get.width * 0.25,
        height: Get.width * 0.25,
        decoration: BoxDecoration(
          color: const Color(0xFF284C1C),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: fallbackWidget,
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
          Text(
            'Doctor Availability',
            style: TextStyle(
              fontSize: Get.width * 0.045,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF284C1C),
            ),
          ),
          

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isActive ? Icons.circle : Icons.circle_outlined,
                    size: Get.width * 0.05,
                    color: isActive ? Colors.green : Colors.grey,
                  ),
                  SizedBox(width: Get.width * 0.02),
                  Text(
                    isActive ? 'Available for consultations' : 'Currently unavailable',
                    style: TextStyle(
                      fontSize: Get.width * 0.04,
                      color: isActive ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              isToggling
                ? SizedBox(
                    height: Get.width * 0.05,
                    width: Get.width * 0.05,
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
          

          Container(
            padding: EdgeInsets.all(Get.width * 0.03),
            decoration: BoxDecoration(
              color: isActive ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Get.width * 0.03),
            ),
            child: Text(
              isActive 
                  ? 'Patients can see your profile and request consultations'
                  : 'Set yourself as available to receive consultation requests',
              style: TextStyle(
                fontSize: Get.width * 0.035,
                color: isActive ? Colors.green.shade700 : Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          
          if (isToggling) ...[
            SizedBox(height: Get.height * 0.01),
            Center(
              child: Text(
                'Updating your status...',
                style: TextStyle(
                  fontSize: Get.width * 0.035,
                  color: Colors.blue[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      );
    });
  }
} 