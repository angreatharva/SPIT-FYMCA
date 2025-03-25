import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_7/routes.dart';
import 'package:lab_7/theme.dart';

import 'Screens/splashScreen.dart';
import 'controller/RestaurantMenuController.dart';

void main() {
  Get.put(RestaurantMenuController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      getPages: AppRoutes.routes,
    );
  }
}