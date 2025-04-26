class CallRequest {
  final String id;
  final String patientId;
  final String patientName;
  final String patientCallerId;
  final String doctorId;
  final String doctorName;
  final String doctorCallerId;
  final String status; // "pending", "accepted", "rejected", "completed"
  final DateTime createdAt;

  CallRequest({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientCallerId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorCallerId,
    required this.status,
    required this.createdAt,
  });

  factory CallRequest.fromJson(Map<String, dynamic> json) {
    return CallRequest(
      id: json['_id'] ?? '',
      patientId: json['patientId'] ?? '',
      patientName: json['patientName'] ?? '',
      patientCallerId: json['patientCallerId'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorCallerId: json['doctorCallerId'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'patientName': patientName,
      'patientCallerId': patientCallerId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorCallerId': doctorCallerId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 