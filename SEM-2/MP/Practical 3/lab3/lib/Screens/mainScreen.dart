import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab3/Screens/cartScreen.dart';
import 'package:lab3/Screens/homeScreen.dart';
import 'package:lab3/Screens/productScreen.dart';
import 'package:lab3/Screens/profileScreen.dart';
import '../CommonWidgets/bottomNavigation/commonBottomBar.dart';
import '../CommonWidgets/bottomNavigation/commonBottomBarController.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BottomNavigationController bottomNavController = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
        children: [
          Image.asset("assets/images/brand_logo.png"),
          Text("JUST DO IT!",style: TextStyle(fontWeight: FontWeight.w900),),
        ],
      ),),
      body: Container(
        height: Get.height * 0.894,
        child: _main(),
      ),
      bottomNavigationBar: CommonBottomNav(),
    );
  }
  _main() {
    return Obx(() {
      switch (Get
          .find<BottomNavigationController>()
          .selectedIndex
          .value) {
        case 0:
          print("HomeScreen");
          print(Get
              .find<BottomNavigationController>()
              .selectedIndex
              .value);
          return HomeScreen();
        case 1:
          print("ProductScreen");
          print(Get
              .find<BottomNavigationController>()
              .selectedIndex
              .value);
          return ProductScreen();
        case 2:
          print("ProfileScreen");
          print(Get
              .find<BottomNavigationController>()
              .selectedIndex
              .value);
          return ProfileScreen();
        case 3:
          print("Cartscreen");
          print(Get
              .find<BottomNavigationController>()
              .selectedIndex
              .value);
          return CartScreen();
        default:
          return HomeScreen();
      }
    });
  }
}
