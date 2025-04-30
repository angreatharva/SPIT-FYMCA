import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/health_controller.dart';
import '../models/health_tracking_model.dart';

class HealthTrackingCard extends StatefulWidget {
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
  State<HealthTrackingCard> createState() => _HealthTrackingCardState();
}

class _HealthTrackingCardState extends State<HealthTrackingCard> {
  late final HealthController healthController;
  
  @override
  void initState() {
    super.initState();
    try {
      healthController = Get.find<HealthController>();
      
      // Ensure questions are expanded by default
      if (!healthController.isHealthSectionExpanded.value) {
        healthController.toggleHealthSectionExpanded();
      }
      
      // Add listener to refresh UI when data changes
      healthController.healthTracking.listen((_) {
        if (mounted) setState(() {});
      });
      
      healthController.isLoading.listen((_) {
        if (mounted) setState(() {});
      });
    } catch (e) {
      // If there's any error finding or initializing the controller,
      // it will be handled in the build method
      print('Error initializing health controller: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle case where controller isn't initialized
    if (!GetInstance().isRegistered<HealthController>()) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 64),
            const SizedBox(height: 16),
            const Text(
              'Health tracking is not available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please try again later or contact support',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      );
    }
    
    // Safe check for late initialization error
    try {
      if (healthController.isLoading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: widget.primaryColor),
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
          mainAxisSize: MainAxisSize.min, 
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
                        color: widget.accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Track your daily health habits to stay healthy and fit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tasks are refreshed at midnight.',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Questions - Always show since we're in a tab now
            Expanded(
              child: _buildQuestionsView(),
            ),
          ],
        ),
      );
    } catch (e) {
      // Fallback for any unexpected errors
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.orange[400], size: 64),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.orange[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              e.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {}); // Force rebuild
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }
  }
  
  Widget _buildQuestionsView() {
    if (healthController.healthTracking.value.questions.isEmpty) {
      return Center(
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
              onPressed: () async {
                try {
                  await healthController.loadHealthData();
                } catch (e) {
                  // Show error message or handle gracefully
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not load health data: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Refresh Tasks'),
            ),
          ],
        ),
      );
    }
    
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: healthController.healthTracking.value.questions
          .map((question) => _buildQuestionItem(question))
          .toList(),
    );
  }

  Widget _buildQuestionItem(HealthQuestionModel question) {
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
                    healthController.updateQuestionResponse(question.id, value);
                  },
                  activeColor: widget.primaryColor,
                  activeTrackColor: widget.primaryColor.withOpacity(0.4),
                ),
          ],
        ),
      ),
    );
  }
} 