import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

import '../controllers/health_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/health_tracking_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // UI variables
  final Color _primaryColor = const Color(0xFF2A7DE1);
  final Color _accentColor = const Color(0xFF1E5BB6);
  final Color _backgroundColor = const Color(0xFFE8EDDE);
  
  final UserController userController = Get.find<UserController>();
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    // Initialize health controller if not already done
    if (!Get.isRegistered<HealthController>()) {
      Get.put(HealthController());
    }
    
    // Update navigation index
    Get.find<NavigationController>().updateIndexFromRoute('/home');
    
    // Validate user outside of build method
    _checkAuthentication();
  }
  
  void _checkAuthentication() {
    // Check authentication status
    isAuthenticated = userController.user.value != null && userController.isLoggedIn.value;
    
    if (!isAuthenticated) {
      // Use Future.delayed to push validation outside of current execution cycle
      Future.delayed(Duration.zero, () {
        if (mounted) userController.validateUser();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      // Show a loading indicator while authentication is checked
      return Scaffold(
        backgroundColor: _backgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: _primaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              'Welcome ${userController.isDoctor ? "Dr." : ""} ${userController.userName}',
              style: TextStyle(
                color: _accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
            const Text(
              'Daily Health Tracker',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Health Tracking Card
          Expanded(
            child: HealthTrackingCard(
              primaryColor: _primaryColor,
              accentColor: _accentColor,
              backgroundColor: _backgroundColor,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
} 