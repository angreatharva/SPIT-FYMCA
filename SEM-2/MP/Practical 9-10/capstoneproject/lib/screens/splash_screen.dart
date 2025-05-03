import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:lottie/lottie.dart';

import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../services/health_service.dart';
import '../services/signalling.service.dart';
import '../services/storage_service.dart';
import '../utils/theme_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _statusMessage = "Initializing...";
  
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    // Start the initialization process
    _initializeApp();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  Future<void> _initializeApp() async {
    try {
      // Step 1: Initialize the basic services
      _updateStatus("Connecting to services...");
      await Get.putAsync(() => ApiService().init());
      await Future.delayed(const Duration(milliseconds: 400)); // Add a small delay for smooth animation
      
      _updateStatus("Loading user data...");
      await Get.putAsync(() => StorageService().init());
      await Future.delayed(const Duration(milliseconds: 400));
      
      _updateStatus("Initializing health tracking...");
      await Get.putAsync(() => HealthService().init());
      await Future.delayed(const Duration(milliseconds: 400));
      
      final storageService = StorageService.instance;
      
      // Step 2: Set up the caller ID
      _updateStatus("Setting up secure connection...");
      
      // Always get fresh caller ID from user information
      String selfCallerID = '';
      
      // Try to get the user data to use their ID
      final user = storageService.getUserData();
      if (user != null) {
        // If user is logged in, use their ID
        selfCallerID = user.id;
        dev.log('Using user ID as caller ID: ${user.id}');
      } else {
        // Generate a random ID if no user is logged in
        selfCallerID = Random().nextInt(999999).toString().padLeft(6, '0');
        dev.log('No user logged in, generated random caller ID: $selfCallerID');
      }
      
      // Save the caller ID for current session
      await storageService.saveCallerId(selfCallerID);
      
      // Step 3: Initialize signaling service
      _updateStatus("Configuring real-time communication...");
      final String websocketUrl = "${ApiService.baseUrl}";
      SignallingService.instance.init(
        websocketUrl: websocketUrl,
        selfCallerID: selfCallerID,
      );
      await Future.delayed(const Duration(milliseconds: 400));
      
      // Step 4: Initialize controllers
      _updateStatus("Preparing application...");
      try {
        // Put a clean instance of signalling service
        if (!Get.isRegistered<SignallingService>()) {
          Get.put(SignallingService.instance, permanent: true);
        }
        
        // Initialize the rest of the controllers
        AppRoutes.initControllers();
        
        // Store caller ID for access in other places
        if (!Get.isRegistered(tag: 'selfCallerId')) {
          Get.put(selfCallerID, tag: 'selfCallerId', permanent: true);
        }
      } catch (e) {
        dev.log('Error during initialization: $e');
        _updateStatus("Error during setup: $e");
        await Future.delayed(const Duration(seconds: 2));
      }
      
      // Final step: Determine the initial route and navigate
      await Future.delayed(const Duration(seconds: 1)); // Add a small delay for splash screen visibility
      _navigateToInitialRoute(storageService);
      
    } catch (e) {
      dev.log('Error during app initialization: $e');
      _updateStatus("Error: $e");
      // If there's an error, wait a bit then try to navigate to login
      await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed(AppRoutes.login);
    }
  }
  
  void _updateStatus(String message) {
    setState(() {
      _statusMessage = message;
    });
  }
  
  void _navigateToInitialRoute(StorageService storageService) {
    if (storageService.isUserLoggedIn()) {
      final user = storageService.getUserData();
      dev.log('User is logged in: ${user?.name}');
      
      if (user != null) {
        Get.offAllNamed(AppRoutes.home);
        return;
      }
    }
    
    // Default to login screen if not logged in or missing user data
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo/animation
            Container(
              width: Get.width * 0.5,
              height: Get.width * 0.5,
              decoration: const BoxDecoration(
                color: Color(0xFF284C1C),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Lottie.asset(
                  'assets/lottie/Splash-Screen.json',
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController
                      ..duration = composition.duration
                      ..forward();
                  },
                  width: Get.width * 0.4,
                  height: Get.width * 0.4,
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // App name
            Text(
              'TeleMed Connect',
              style: TextStyle(
                fontSize: Get.width * 0.08,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.mainColor,
              ),
            ),
            const SizedBox(height: 10),
            
            // App slogan
            Text(
              'Healthcare at your fingertips',
              style: TextStyle(
                fontSize: Get.width * 0.04,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 60),
            
            // Loading indicator
            SizedBox(
              width: Get.width * 0.7,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(ThemeConstants.mainColor),
              ),
            ),
            const SizedBox(height: 20),
            
            // Status message
            Text(
              _statusMessage,
              style: TextStyle(
                fontSize: Get.width * 0.04,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 