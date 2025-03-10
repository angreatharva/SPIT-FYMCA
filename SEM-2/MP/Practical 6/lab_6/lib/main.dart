import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/splashScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kids Learning App',
      theme: ThemeData(
        primaryColor: Color(0xFF4A90E2),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFFA726),
          background: Color(0xFFF5F5F5)
        ),
        fontFamily: 'ComicSans'
      ),
      home: SplashScreen(),
    );
  }
}
