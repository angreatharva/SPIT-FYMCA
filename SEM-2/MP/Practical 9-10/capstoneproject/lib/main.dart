import 'dart:math';
import 'package:capstoneproject/routes/app_routes.dart';
import 'package:capstoneproject/services/api_service.dart';
import 'package:capstoneproject/services/health_service.dart';
import 'package:capstoneproject/services/signalling.service.dart';
import 'package:capstoneproject/services/storage_service.dart';
import 'package:capstoneproject/utils/theme_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Services
  await Get.putAsync(() => ApiService().init());
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => HealthService().init());
  
  runApp(VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  VideoCallApp({super.key});

  // WebSocket signaling server URL
  final String websocketUrl = "${ApiService.baseUrl}";

  @override
  Widget build(BuildContext context) {
    final storageService = StorageService.instance;
    
    // Always get fresh caller ID from user information
    // We'll clear any previously stored caller ID to force using the user ID
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
    storageService.saveCallerId(selfCallerID);

    // Initialize signaling service
    SignallingService.instance.init(
      websocketUrl: websocketUrl,
      selfCallerID: selfCallerID,
    );
    
    // Initialize controllers before creating the app
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
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeleMed Connect',
      theme: ThemeConstants.lightTheme,
      initialRoute: _getInitialRoute(storageService),
      getPages: AppRoutes.pages,
      initialBinding: BindingsBuilder(() {
        // Controllers are already initialized
      }),
      defaultTransition: Transition.fadeIn,
      popGesture: true, // Allow swipe to go back
      defaultGlobalState: false, // Prevent global state
      navigatorKey: Get.key,
      onInit: () {
        // Ensure controllers are initialized
        AppRoutes.initControllers();
      },
    );
  }
  
  // Determine the initial route based on login status
  String _getInitialRoute(StorageService storageService) {
    if (storageService.isUserLoggedIn()) {
      final user = storageService.getUserData();
      dev.log('User is logged in: ${user?.name}');
      
      if (user != null) {
        return AppRoutes.home;
      }
    }
    
    // Default to login screen if not logged in or missing user data
    return AppRoutes.login;
  }
}
