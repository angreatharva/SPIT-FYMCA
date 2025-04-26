import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/navigation_controller.dart';

class CustomBottomNav extends GetView<NavigationController> {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0XFF284C1C),
        borderRadius: BorderRadius.circular(50),
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
                lottieAsset: 'assets/lottie/Home.json',
              ),
              // Video call
              _buildNavItem(
                index: NavigationController.VIDEO_CALL_INDEX,
                icon: Icons.videocam,
                label: 'Video Call',
                lottieAsset: 'assets/lottie/VideoCall.json',
              ),
              _buildNavItem(
                index: NavigationController.BLOGS_INDEX,
                icon: Icons.message_outlined,
                label: 'Blogs',
                lottieAsset: 'assets/lottie/Blog.json',
              ),
              // Profile
              _buildNavItem(
                index: NavigationController.PROFILE_INDEX,
                icon: Icons.person,
                label: 'Profile',
                lottieAsset: 'assets/lottie/Profile.json',
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
    required String lottieAsset,
  }) {
    return Obx(() {
      final bool isSelected = controller.currentIndex.value == index;
      return InkWell(
        onTap: () => controller.changeTab(index),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0XFFFFFFFF) : Color(0XFF385D34),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(10), // Added padding to reduce effective size
                child: Lottie.asset(
                  lottieAsset,
                  animate: isSelected,
                  fit: BoxFit.contain,
                  repeat: isSelected,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}