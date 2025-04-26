import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/health_controller.dart';
import '../models/health_tracking_model.dart';

class HealthTrackingCard extends StatelessWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  
  const HealthTrackingCard({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final healthController = Get.find<HealthController>();
    
    return Obx(() {
      if (healthController.isLoading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: primaryColor),
              const SizedBox(height: 16),
              Text(
                'Loading your daily health tasks...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        );
      }
      
      return Container(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Daily Health Check',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      healthController.isHealthSectionExpanded.value
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: accentColor,
                      size: 32,
                    ),
                    onPressed: () => healthController.toggleHealthSectionExpanded(),
                  ),
                ],
              ),
            ),
            
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Track your daily health habits to stay healthy and fit',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Refresh time note
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Tasks are refreshed at very midnight.',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Questions
            if (healthController.isHealthSectionExpanded.value)
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: healthController.healthTracking.value.questions
                      .map((question) => _buildQuestionItem(question, healthController, context))
                      .toList(),
                ),
              ),
              
            // Pull to refresh
            if (healthController.isHealthSectionExpanded.value && healthController.healthTracking.value.questions.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.task_alt, color: Colors.grey[400], size: 64),
                      const SizedBox(height: 16),
                      Text(
                        'No health tasks available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => healthController.loadHealthData(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Refresh Tasks'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildQuestionItem(
    HealthQuestionModel question,
    HealthController controller,
    BuildContext context,
  ) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      // Use different background color for completed tasks
      color: question.response ? Colors.green.shade50 : Color(0XFFC3DEA9),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Completed icon for completed tasks
            if (question.response)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              
            Expanded(
              child: Text(
                question.question,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  // Use slightly different text style for completed tasks
                  color: question.response ? Colors.green.shade800 : Colors.black87,
                  decoration: question.response ? TextDecoration.none : TextDecoration.none,
                ),
              ),
            ),
            
            // Show switch only if not completed, otherwise show completed text
            question.response
              ? Text(
                  'Completed',
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              : Switch(
                  value: question.response,
                  onChanged: (value) {
                    controller.updateQuestionResponse(question.id, value);
                  },
                  activeColor: primaryColor,
                  activeTrackColor: primaryColor.withOpacity(0.4),
                ),
          ],
        ),
      ),
    );
  }
} 