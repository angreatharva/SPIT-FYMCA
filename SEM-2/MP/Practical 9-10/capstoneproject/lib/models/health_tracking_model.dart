
class HealthQuestionModel {
  final String id;
  final String question;
  final bool response; // Represents the 'completed' field from server
  final DateTime date; // Represents the 'completedAt' field from server

  HealthQuestionModel({
    required this.id,
    required this.question,
    required this.response,
    required this.date,
  });

  // Create from JSON
  factory HealthQuestionModel.fromJson(Map<String, dynamic> json) {
    return HealthQuestionModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      response: json['completed'] ?? false, // Match server field name
      date: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : DateTime.now(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'completed': response, // Match server field name
      'completedAt': date.toIso8601String(),
    };
  }
}

class HealthTrackingModel {
  final List<HealthQuestionModel> questions;
  final DateTime date;
  final String? trackingId;

  HealthTrackingModel({
    required this.questions,
    required this.date,
    this.trackingId,
  });
  
  // Create from JSON
  factory HealthTrackingModel.fromJson(Map<String, dynamic> json) {
    List<HealthQuestionModel> questionsList = [];
    
    if (json['questions'] != null) {
      for (var q in json['questions']) {
        questionsList.add(HealthQuestionModel.fromJson({
          'id': q['_id'],
          'question': q['question'],
          'completed': q['completed'],
          'completedAt': q['completedAt'],
        }));
      }
    }
    
    return HealthTrackingModel(
      questions: questionsList,
      trackingId: json['_id'],
      date: json['date'] != null 
          ? DateTime.parse(json['date']) 
          : DateTime.now(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((q) => q.toJson()).toList(),
      'date': date.toIso8601String(),
      if (trackingId != null) '_id': trackingId,
    };
  }

  // Create default health tracking model with predefined questions
  factory HealthTrackingModel.createDefault() {
    return HealthTrackingModel(
      questions: [
        HealthQuestionModel(
          id: '1',
          question: 'Did you drink 3 liters of water today?',
          response: false,
          date: DateTime.now(),
        ),
        HealthQuestionModel(
          id: '2',
          question: 'Did you work out today?',
          response: false,
          date: DateTime.now(),
        ),
        HealthQuestionModel(
          id: '3',
          question: 'Did you take your medications?',
          response: false,
          date: DateTime.now(),
        ),
        HealthQuestionModel(
          id: '4',
          question: 'Did you eat healthy today?',
          response: false,
          date: DateTime.now(),
        ),
      ],
      date: DateTime.now(),
    );
  }
} 