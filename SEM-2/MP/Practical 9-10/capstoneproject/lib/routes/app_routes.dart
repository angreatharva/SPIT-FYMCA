import 'package:capstoneproject/screens/RoleSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/join_screen.dart';
import '../screens/login_screen.dart';
import '../screens/doctor_registration_screen.dart';
import '../screens/user_registration_screen.dart';
import '../screens/video_calling_screen.dart';
import '../services/storage_service.dart';
import '../services/call_request_service.dart';
import 'auth_middleware.dart';
import 'dart:developer' as dev;
import '../controllers/navigation_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/doctor_controller.dart';
import '../controllers/health_controller.dart';
import '../controllers/call_request_controller.dart';

class AppRoutes {
  static const String home = '/home';
  static const String profile = '/profile';
  static const String joinScreen = '/join';
  static const String roleSelection = '/role-selection';
  static const String videoCallingScreen = '/video-calling';
  static const String login = '/login';
  static const String userRegistration = '/user-registration';
  static const String doctorRegistration = '/doctor-registration';

  // Initialize required controllers
  static void initControllers() {
    try {
      // Register controllers as singletons to maintain state across screens
      if (!Get.isRegistered<UserController>()) {
        Get.put(UserController(), permanent: true);
      }
      
      if (!Get.isRegistered<NavigationController>()) {
        Get.put(NavigationController(), permanent: true);
      }
      
      if (!Get.isRegistered<DoctorController>()) {
        Get.put(DoctorController(), permanent: true);
      }
      
      if (!Get.isRegistered<HealthController>()) {
        Get.put(HealthController(), permanent: true);
      }
      
      if (!Get.isRegistered<CallRequestService>()) {
        Get.put(CallRequestService(), permanent: true);
      }
      
      if (!Get.isRegistered<CallRequestController>()) {
        Get.put(CallRequestController(), permanent: true);
      }
      
      dev.log("AppRoutes: Controllers initialized successfully");
    } catch (e) {
      dev.log("AppRoutes: Error initializing controllers: $e");
    }
  }

  static final List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: roleSelection,
      page: () {
        final storageService = StorageService.instance;
        final user = storageService.getUserData();
        print("User Data: ${user}");
        print("User Data: ${userRegistration}");

        if (user == null) {
          dev.log('No user data found, redirecting to login');
          Future.delayed(Duration.zero, () {
            Get.offAllNamed(login);
          });
          return const SizedBox.shrink(); // Return placeholder, redirect will happen
        }
        
        return RoleSelectionScreen(selfCallerId: storageService.getCallerId());
      },
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: videoCallingScreen,
      page: () {
        final storageService = StorageService.instance;
        final user = storageService.getUserData();
        
        if (user == null) {
          dev.log('No user data found, redirecting to login');
          Future.delayed(Duration.zero, () {
            Get.offAllNamed(login);
          });
          return const SizedBox.shrink(); // Return placeholder, redirect will happen
        }
        
        return VideoCallingScreen();
      },
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: joinScreen,
      page: () {
        final storageService = StorageService.instance;
        final user = storageService.getUserData();
        final callerId = storageService.getCallerId();
        
        if (user == null) {
          dev.log('No user data found, redirecting to login');
          Future.delayed(Duration.zero, () {
            Get.offAllNamed(login);
          });
          return const SizedBox.shrink(); // Return placeholder, redirect will happen
        }
        
        return JoinScreen(
          selfCallerId: callerId,
          role: user.isDoctor,
          // userId: user.id,
          // userName: user.name,
        );
      },
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: login,
      page: () {
        final callerId = StorageService.instance.getCallerId();
        return LoginScreen(selfCallerId: callerId);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: userRegistration,
      page: () => const UserRegistrationScreen(),
    ),
    GetPage(
      name: doctorRegistration,
      page: () => const DoctorRegistrationScreen(),
    ),
  ];
} 