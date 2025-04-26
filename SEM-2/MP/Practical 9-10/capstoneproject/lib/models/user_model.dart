
class UserModel {
  final String id;
  final String name;
  final String email;
  final bool isDoctor;
  final String? specialization;
  final String? imageBase64;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isDoctor,
    this.specialization,
    this.imageBase64,
  });

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      isDoctor: json['isDoctor'] ?? false,
      specialization: json['specialization'],
      imageBase64: json['imageBase64'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isDoctor': isDoctor,
      'specialization': specialization,
      'imageBase64': imageBase64,
    };
  }

  // Convert to string for debugging
  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isDoctor: $isDoctor, specialization: $specialization)';
  }
} 