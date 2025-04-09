class Theatre {
  final String id;
  final String name;
  final String location;

  Theatre({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Theatre.fromJson(Map<String, dynamic> json) {
    return Theatre(
      id: json['_id'],
      name: json['name'],
      location: json['location'] ?? '',
    );
  }
}