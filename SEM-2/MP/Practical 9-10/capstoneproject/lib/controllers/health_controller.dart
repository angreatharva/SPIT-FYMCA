import 'package:get/get.dart';
import '../models/health_tracking_model.dart';
import '../services/storage_service.dart';
import '../services/health_service.dart';
import 'dart:developer' as dev;

class HealthController extends GetxController {
  final Rx<HealthTrackingModel> healthTracking = HealthTrackingModel.createDefault().obs;
  final RxBool isHealthSectionExpanded = true.obs;
  final RxBool isLoading = false.obs;
  final RxString trackingId = ''.obs;
  final RxMap<String, dynamic> healthHeatmap = <String, dynamic>{}.obs;
  
  late String userId;
  final HealthService _healthService = Get.find<HealthService>();

  @override
  void onInit() {
    super.onInit();
    _initializeUserId();
    loadHealthData();
  }
  
  void _initializeUserId() {
    final StorageService storageService = StorageService.instance;
    final user = storageService.getUserData();
    if (user != null) {
      userId = user.id;
    }
  }

  // Load health data from the server
  Future<void> loadHealthData() async {
    if (userId.isEmpty) {
      dev.log('Cannot load health data: User ID is empty');
      return;
    }
    
    isLoading.value = true;
    
    try {
      final healthTrackingData = await _healthService.getUserHealthTracking(userId);
      
      if (healthTrackingData != null) {
        healthTracking.value = healthTrackingData;
        if (healthTrackingData.trackingId != null) {
          trackingId.value = healthTrackingData.trackingId!;
        }
        dev.log('Health data loaded from server');
      } else {
        // Fall back to default data if server returns error
        healthTracking.value = HealthTrackingModel.createDefault();
        dev.log('Server returned error, using default health data');
      }
    } catch (e) {
      dev.log('Error loading health data from server: $e');
      // Fall back to default data
      healthTracking.value = HealthTrackingModel.createDefault();
    } finally {
      isLoading.value = false;
    }
  }

  // Update a question's response
  Future<void> updateQuestionResponse(String questionId, bool response) async {
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
      if (userId.isEmpty || healthTracking.value.trackingId == null) {
        dev.log('Cannot update question: User ID or tracking ID is empty');
        return;
      }
      
      try {
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
      final heatmapData = await _healthService.getHealthActivityHeatmap(
        userId,
        startDate: startDate,
        endDate: endDate,
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