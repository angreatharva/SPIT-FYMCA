import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'commonBottomBarController.dart';

class CommonBottomNav extends GetView<BottomNavigationController> {
  const CommonBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller = Get.put(BottomNavigationController());


    return SizedBox(
      height: Get.height * 0.09,
      child: Obx(
            () => BottomNavigationBar(
          iconSize: 22.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'.tr,
              backgroundColor: Colors.grey[100],
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/products.png",height:25 ,width: 25,
                color:Color(0xff757175),
              ),
              label: 'Products'.tr,
              backgroundColor: Colors.grey[100],
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Profile'.tr,
              backgroundColor: Colors.grey[100],
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: 'Cart'.tr,
              backgroundColor: Colors.grey[100],
            ),

          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          elevation: 5,
        ),
      ),
    );
  }
}