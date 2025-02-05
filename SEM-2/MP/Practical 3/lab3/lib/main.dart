import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CommonWidgets/bottomNavigation/commonBottomBarController.dart';
import 'Screens/mainScreen.dart';

void main() {
  Get.put(BottomNavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MainScreen(),
    );
  }
}

