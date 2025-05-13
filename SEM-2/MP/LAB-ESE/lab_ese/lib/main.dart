import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:lab_ese/constants/themeConstants.dart';
import 'package:lab_ese/controllers/appointment_controller.dart';
import 'package:lab_ese/screens/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  Get.put(AppointmentController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor Appointment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeConstants.primaryColor),
        useMaterial3: true,
        scaffoldBackgroundColor: ThemeConstants.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: ThemeConstants.primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ThemeConstants.primaryButtonStyle,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ThemeConstants.secondaryButtonStyle,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: ThemeConstants.cardColor,
        ),
        textTheme: const TextTheme(
          headlineLarge: ThemeConstants.headingStyle,
          headlineMedium: ThemeConstants.subheadingStyle,
          bodyLarge: ThemeConstants.bodyTextStyle,
          bodyMedium: ThemeConstants.bodyTextStyle,
          bodySmall: ThemeConstants.captionStyle,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
