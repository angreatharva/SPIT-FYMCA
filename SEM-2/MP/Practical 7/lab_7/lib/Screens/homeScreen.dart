import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_7/Screens/restaurant_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foodzz'),
      ),
      body: Center(
        child: RestaurantScreen()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/cart');
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
