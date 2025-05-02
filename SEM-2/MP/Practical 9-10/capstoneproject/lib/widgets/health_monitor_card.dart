import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/health_controller.dart';
import 'health_heatmap_widget.dart';

class HealthMonitorCard extends StatelessWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  
  const HealthMonitorCard({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final healthController = Get.find<HealthController>();
    
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.01),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Activity Calendar',
                    style: TextStyle(
                      fontSize: Get.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Text(
              'Monitor your health habits over time with this calendar view',
              style: TextStyle(
                fontSize: Get.width * 0.035,
                color: Colors.grey[700],
              ),
            ),
          ),
          
          // Health heatmap - Use direct widget without Obx
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.01),
              child: HealthHeatmapWidget(
                primaryColor: primaryColor,
                accentColor: accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 