class BlogModel {
  final String? id;
  final String authorName;
  final String title;
  final String description;
  final String content;
  final List<String> tags;
  final String? imageUrl;
  final String createdAt;
  final String updatedAt;

  BlogModel({
    this.id,
    required this.authorName,
    required this.title,
    required this.description,
    required this.content,
    required this.tags,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create from JSON
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['_id'],
      authorName: json['authorName'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['updatedAt'] ?? DateTime.now().toIso8601String(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'authorName': authorName,
      'title': title,
      'description': description,
      'content': content,
      'tags': tags,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a new blog for posting (without ID and dates)
  Map<String, dynamic> toCreateJson(String userId, String createdByModel) {
    return {
      'title': title,
      'description': description,
      'content': content,
      'tags': tags,
      'userId': userId,
      'createdByModel': createdByModel,
    };
  }
} 