class Doctor {
  final String id;
  final String name;
  final String email;
  final String specialization;
  final String imageUrl;
  final double rating;
  final bool isActive;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.isActive,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    // Handle both 'name' and 'doctorName' fields for compatibility with different server models
    final name = json['name'] ?? json['doctorName'] ?? '';
    
    return Doctor(
      id: json['_id'] ?? '',
      name: name,
      email: json['email'] ?? '',
      specialization: json['specialization'] ?? '',
      imageUrl: json['imageUrl'] ?? 'https://picsum.photos/200',
      rating: (json['rating'] ?? 0.0).toDouble(),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'specialization': specialization,
      'imageUrl': imageUrl,
      'rating': rating,
      'isActive': isActive,
    };
  }
} 