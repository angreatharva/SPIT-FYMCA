import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile/Screens/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ProfileScreen(),
    );
  }
}

