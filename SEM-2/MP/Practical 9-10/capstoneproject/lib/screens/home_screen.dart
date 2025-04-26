import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/health_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/theme_constants.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/health_tracking_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
        body: Center(
          child: CircularProgressIndicator(
            color: ThemeConstants.primaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              'Welcome ${userController.isDoctor ? "Dr." : ""} ${userController.userName}',
              style: TextStyle(
                color: ThemeConstants.accentColor,
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
              primaryColor: ThemeConstants.primaryColor,
              accentColor: ThemeConstants.accentColor,
              backgroundColor: ThemeConstants.backgroundColor,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
} 