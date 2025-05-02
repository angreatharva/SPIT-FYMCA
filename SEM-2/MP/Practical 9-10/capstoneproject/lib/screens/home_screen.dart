import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/health_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/theme_constants.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/health_tracking_card.dart';
import '../widgets/health_monitor_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.find<UserController>();
  bool isAuthenticated = false;
  
  // Selected tab index - using state instead of RxInt
  int _selectedTabIndex = 0;

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
        backgroundColor: ThemeConstants.backgroundColor,
        elevation: 0,
        toolbarHeight: Get.height * 0.08,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              'Welcome ${userController.isDoctor ? "Dr." : ""} ${userController.userName}',
              style: TextStyle(
                color: ThemeConstants.accentColor,
                fontSize: Get.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            )),
            Text(
              'Health Dashboard',
              style: TextStyle(
                color: ThemeConstants.mainColor,
                fontSize: Get.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.01, bottom: Get.height * 0.01),
        child: Column(
          children: [
            // Tab chips
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, 
                vertical: Get.height * 0.01
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTabChip(0, 'Health Tracking'),
                  SizedBox(width: Get.width * 0.03),
                  _buildTabChip(1, 'Health Monitor'),
                ],
              ),
            ),
            
            // Card content based on selected tab
            Expanded(
              child: _selectedTabIndex == 0
                ? HealthTrackingCard(
                    primaryColor: ThemeConstants.primaryColor,
                    accentColor: ThemeConstants.accentColor,
                    backgroundColor: ThemeConstants.backgroundColor,
                  )
                : HealthMonitorCard(
                    primaryColor: ThemeConstants.primaryColor,
                    accentColor: ThemeConstants.accentColor,
                    backgroundColor: ThemeConstants.backgroundColor,
                  )
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
  
  Widget _buildTabChip(int index, String label) {
    final isSelected = _selectedTabIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04, 
          vertical: Get.height * 0.01
        ),
        decoration: BoxDecoration(
          color: isSelected ? ThemeConstants.mainColor : ThemeConstants.greyInActive,
          borderRadius: BorderRadius.circular(Get.width * 0.05),
          border: Border.all(
            color: isSelected ? ThemeConstants.mainColor : ThemeConstants.greyInActive,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: Get.width * 0.035,
          ),
        ),
      ),
    );
  }
} 