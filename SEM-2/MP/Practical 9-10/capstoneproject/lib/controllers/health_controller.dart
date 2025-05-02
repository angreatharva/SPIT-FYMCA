import 'package:get/get.dart';
import '../models/health_tracking_model.dart';
import '../services/storage_service.dart';
import '../services/health_service.dart';
import 'dart:developer' as dev;

class HealthController extends GetxController {
  final Rx<HealthTrackingModel> healthTracking = HealthTrackingModel(
    questions: [],
    date: DateTime.now(),
  ).obs;
  final RxBool isHealthSectionExpanded = true.obs;
  final RxBool isLoading = false.obs;
  final RxString trackingId = ''.obs;
  final RxMap<String, dynamic> healthHeatmap = <String, dynamic>{}.obs;
  
  // Initialize with empty string to avoid late initialization error
  String userId = '';
  final HealthService _healthService = Get.find<HealthService>();

  @override
  void onInit() {
    super.onInit();
    _initializeUserId();
    loadHealthData();
  }
  
  // Helper method to create an empty health tracking model
  HealthTrackingModel createEmptyHealthTracking() {
    return HealthTrackingModel(
      questions: [],
      date: DateTime.now(),
    );
  }
  
  void _initializeUserId() {
    final StorageService storageService = StorageService.instance;
    final user = storageService.getUserData();
    if (user != null) {
      userId = user.id;
      dev.log('HealthController: Initialized userId: $userId');
    } else {
      dev.log('HealthController: Could not initialize userId, user is null');
    }
  }

  // Load health data from the server
  Future<void> loadHealthData() async {
    // If userId is empty, try to reinitialize it
    if (userId.isEmpty) {
      dev.log('HealthController: User ID is empty, attempting to re-initialize');
      _initializeUserId();
      
      // If still empty after re-initialization, use default empty data
      if (userId.isEmpty) {
        dev.log('HealthController: Unable to load health data: User ID is still empty');
        healthTracking.value = createEmptyHealthTracking();
        trackingId.value = '';
        return;
      }
    }
    
    isLoading.value = true;
    
    try {
      // Get user data from storage
      final StorageService storageService = StorageService.instance;
      final user = storageService.getUserData();
      
      // If user is null, we can't determine the type
      if (user == null) {
        dev.log('HealthController: User data is null, using default empty model');
        healthTracking.value = createEmptyHealthTracking();
        trackingId.value = '';
        isLoading.value = false;
        return;
      }
      
      // Reset trackingId when loading for new user/role to avoid using old value
      trackingId.value = '';
      
      // Determine user type using the isDoctor property
      final String userType = user.isDoctor ? 'doctor' : 'patient';
      
      dev.log('HealthController: Loading health data for user: $userId with userType: $userType');
      
      final healthTrackingData = await _healthService.getUserHealthTracking(userId, userType: userType);
      
      if (healthTrackingData != null) {
        healthTracking.value = healthTrackingData;
        if (healthTrackingData.trackingId != null) {
          trackingId.value = healthTrackingData.trackingId!;
          dev.log('HealthController: Updated trackingId to ${trackingId.value}');
        } else {
          dev.log('HealthController: Warning - received null trackingId from server');
        }
        dev.log('Health data loaded from server');
      } else {
        // Fall back to default data if server returns error
        healthTracking.value = HealthTrackingModel.createDefault(role: userType);
        trackingId.value = '';
        dev.log('Server returned error, using default health data');
      }
    } catch (e) {
      dev.log('Error loading health data from server: $e');
      
      // Get user data to determine role for default questions
      final StorageService storageService = StorageService.instance;
      final user = storageService.getUserData();
      final String userType = user != null && user.isDoctor ? 'doctor' : 'patient';
      
      // Fall back to default data
      healthTracking.value = HealthTrackingModel.createDefault(role: userType);
      trackingId.value = '';
    } finally {
      isLoading.value = false;
    }
  }

  // Update a question's response
  Future<void> updateQuestionResponse(String questionId, bool response) async {
    // Skip if user is not logged in or userId is empty
    if (userId.isEmpty) {
      dev.log('HealthController: Cannot update question - user not logged in (userId is empty)');
      return;
    }

    // Skip if trying to unmark a completed question
    final questionIndex = healthTracking.value.questions.indexWhere((q) => q.id == questionId);
    
    if (questionIndex == -1) {
      dev.log('Question not found');
      return;
    }
    
    final existingQuestion = healthTracking.value.questions[questionIndex];
    
    // If the question is already completed and trying to set it to incomplete, ignore
    if (existingQuestion.response && !response) {
      dev.log('Cannot unmark a completed question');
      return;
    }
    
    // If no change, do nothing
    if (existingQuestion.response == response) {
      return;
    }
    
    // Only allow changing from incomplete to complete
    if (!existingQuestion.response && response) {
      // Local update of UI for immediate feedback
      final List<HealthQuestionModel> updatedQuestions = [];
      
      for (var question in healthTracking.value.questions) {
        if (question.id == questionId) {
          updatedQuestions.add(HealthQuestionModel(
            id: question.id,
            question: question.question,
            response: true,
            date: DateTime.now(),
          ));
        } else {
          updatedQuestions.add(question);
        }
      }
      
      healthTracking.value = HealthTrackingModel(
        questions: updatedQuestions,
        date: healthTracking.value.date,
        trackingId: healthTracking.value.trackingId,
      );
      
      // Server update
      if (userId.isEmpty || healthTracking.value.trackingId == null || healthTracking.value.trackingId!.isEmpty) {
        dev.log('HealthController: Cannot update question: User ID or tracking ID is empty/null');
        dev.log('HealthController: Current userId: $userId, trackingId: ${healthTracking.value.trackingId}');
        dev.log('HealthController: Attempting to reload health data to get trackingId');
        
        // Wait a moment to ensure any in-progress operations complete
        await Future.delayed(Duration(milliseconds: 100));
        await loadHealthData();
        
        // Check if we now have a trackingId
        if (healthTracking.value.trackingId == null || healthTracking.value.trackingId!.isEmpty) {
          dev.log('HealthController: Reload failed, trackingId still null/empty');
          Get.snackbar(
            'Action Not Saved', 
            'Unable to save your action. Please try again later.',
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        } else {
          dev.log('HealthController: Successfully retrieved trackingId: ${healthTracking.value.trackingId}');
        }
      }
      
      try {
        dev.log('HealthController: Attempting to update question $questionId to $response');
        dev.log('HealthController: Using trackingId: ${healthTracking.value.trackingId}');
        
        final success = await _healthService.completeHealthQuestion(
          userId, 
          healthTracking.value.trackingId!, 
          questionId
        );
        
        if (success) {
          dev.log('Question marked as completed on server');
        } else {
          // Handle API error
          dev.log('API error updating question');
          // Refresh from server to sync data
          await loadHealthData();
        }
      } catch (e) {
        dev.log('Error updating question on server: $e');
        // Refresh from server to sync data
        await loadHealthData();
      }
    }
  }

  // Load health activity heatmap data
  Future<void> loadHealthHeatmap({String? startDate, String? endDate}) async {
    if (userId.isEmpty) {
      dev.log('Cannot load health heatmap: User ID is empty');
      return;
    }
    
    try {
      // Get user data to determine type
      final StorageService storageService = StorageService.instance;
      final user = storageService.getUserData();
      
      // Determine user type using the isDoctor property
      final String userType = user != null && user.isDoctor ? 'doctor' : 'patient';
      
      dev.log('HealthController: Loading health heatmap for user: $userId with userType: $userType');
      
      final heatmapData = await _healthService.getHealthActivityHeatmap(
        userId,
        startDate: startDate,
        endDate: endDate,
        userType: userType,
      );
      
      if (heatmapData != null) {
        healthHeatmap.value = heatmapData;
        dev.log('Health heatmap data loaded');
      } else {
        dev.log('Failed to load health heatmap data');
      }
    } catch (e) {
      dev.log('Error loading health heatmap: $e');
    }
  }

  // Toggle health section expanded state
  void toggleHealthSectionExpanded() {
    isHealthSectionExpanded.value = !isHealthSectionExpanded.value;
  }
}