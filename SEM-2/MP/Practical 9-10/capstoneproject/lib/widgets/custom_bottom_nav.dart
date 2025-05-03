import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/navigation_controller.dart';
import '../utils/theme_constants.dart';

class CustomBottomNav extends GetView<NavigationController> {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.085,
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * 0.04, 
        vertical: Get.height * 0.012
      ),
      decoration: BoxDecoration(
        color: ThemeConstants.mainColor,
        borderRadius: BorderRadius.circular(Get.width * 0.12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home
              _buildNavItem(
                index: NavigationController.HOME_INDEX,
                icon: Icons.home,
                label: 'Home',
                activeLottie: 'assets/lottie/Home-Active.json',
                inactiveLottie: 'assets/lottie/Home-Inactive.json',
              ),
              // Video call
              _buildNavItem(
                index: NavigationController.VIDEO_CALL_INDEX,
                icon: Icons.videocam,
                label: 'Video Call',
                activeLottie: 'assets/lottie/VideoCall-Active.json',
                inactiveLottie: 'assets/lottie/VideoCall-Inactive.json',
              ),
              _buildNavItem(
                index: NavigationController.BLOGS_INDEX,
                icon: Icons.message_outlined,
                label: 'Blogs',
                activeLottie: 'assets/lottie/Blogs-Active.json',
                inactiveLottie: 'assets/lottie/Blogs-Inactive.json',
              ),
              // Profile
              _buildNavItem(
                index: NavigationController.PROFILE_INDEX,
                icon: Icons.person,
                label: 'Profile',
                activeLottie: 'assets/lottie/Profile-Active.json',
                inactiveLottie: 'assets/lottie/Profile-Inactive.json',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required String activeLottie,
    required String inactiveLottie,
  }) {
    return Obx(() {
      final bool isSelected = controller.currentIndex.value == index;
      return InkWell(
        onTap: () => controller.changeTab(index),
        borderRadius: BorderRadius.circular(Get.width * 0.05),
        child: Container(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Get.width * 0.15,
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                  color: isSelected ? ThemeConstants.white : ThemeConstants.mainColorInActive,
                  borderRadius: BorderRadius.circular(Get.width * 0.12),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ] : null,
                ),
                padding: EdgeInsets.all(Get.width * 0.025),
                child: Lottie.asset(
                  isSelected ? activeLottie : inactiveLottie,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}