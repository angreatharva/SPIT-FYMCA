import 'package:capstoneproject/routes/app_routes.dart';
import 'package:capstoneproject/screens/splash_screen.dart';
import 'package:capstoneproject/utils/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep native splash screen visible until our app is fully loaded
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove the native splash screen when our app's UI is ready
    FlutterNativeSplash.remove();
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeleMed Connect',
      theme: ThemeConstants.lightTheme,
      home: const SplashScreen(),
      getPages: AppRoutes.pages,
      defaultTransition: Transition.fadeIn,
      popGesture: true, // Allow swipe to go back
      defaultGlobalState: false, // Prevent global state
      navigatorKey: Get.key,
    );
  }
}
