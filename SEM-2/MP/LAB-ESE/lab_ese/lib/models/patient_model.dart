class Patient {
  final String id;
  final String name;
  final String address;
  final int age;
  final String contactDetails;
  final String symptoms;
  final String doctorName;
  final DateTime appointmentDate;

  Patient({
    this.id = '',
    required this.name,
    required this.address,
    required this.age,
    required this.contactDetails,
    required this.symptoms,
    required this.doctorName,
    required this.appointmentDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'age': age,
      'contactDetails': contactDetails,
      'symptoms': symptoms,
      'doctorName': doctorName,
      'appointmentDate': appointmentDate.toIso8601String(),
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json, String id) {
    return Patient(
      id: id,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      age: json['age'] ?? 0,
      contactDetails: json['contactDetails'] ?? '',
      symptoms: json['symptoms'] ?? '',
      doctorName: json['doctorName'] ?? '',
      appointmentDate: json['appointmentDate'] != null
          ? DateTime.parse(json['appointmentDate'])
          : DateTime.now(),
    );
  }
} 