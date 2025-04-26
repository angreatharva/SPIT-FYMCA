import 'package:capstoneproject/screens/blogs_screen.dart';
import 'package:capstoneproject/screens/role_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/active_doctors_screen.dart';
import '../screens/pending_calls_screen.dart';
import '../screens/call_screen.dart';
import '../screens/login_screen.dart';
import '../screens/doctor_registration_screen.dart';
import '../screens/user_registration_screen.dart';
import '../services/storage_service.dart';
import 'auth_middleware.dart';
import 'dart:developer' as dev;
import '../controllers/navigation_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/doctor_controller.dart';
import '../controllers/health_controller.dart';
import '../controllers/calling_controller.dart';

class AppRoutes {
  static const String home = '/home';
  static const String profile = '/profile';
  static const String joinScreen = '/join';
  static const String roleSelection = '/role-selection';
  static const String videoCall = '/video-call'; // General route identifier
  static const String activeDoctors = '/active-doctors';
  static const String doctorPendingCalls = '/pending-calls';
  static const String login = '/login';
  static const String userRegistration = '/user-registration';
  static const String doctorRegistration = '/doctor-registration';
  static const String blogs = '/blogs';

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
      
      if (!Get.isRegistered<CallingController>()) {
        Get.put(CallingController(), permanent: true);
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
      name: activeDoctors,
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
        
        // If user is a doctor, redirect to doctor pending calls
        if (user.isDoctor) {
          Future.delayed(Duration.zero, () {
            Get.offAllNamed(doctorPendingCalls);
          });
          return const SizedBox.shrink();
        }
        
        return ActiveDoctorsScreen(selfCallerId: storageService.getCallerId());
      },
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: doctorPendingCalls,
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
        
        // If user is not a doctor, redirect to active doctors
        if (!user.isDoctor) {
          Future.delayed(Duration.zero, () {
            Get.offAllNamed(activeDoctors);
          });
          return const SizedBox.shrink();
        }
        
        return PendingCallsScreen(selfCallerId: storageService.getCallerId());
      },
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: blogs,
      page: () => const BlogsScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
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