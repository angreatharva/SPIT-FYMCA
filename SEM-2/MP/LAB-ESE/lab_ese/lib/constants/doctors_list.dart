class Doctor {
  final String name;
  final String specialization;

  Doctor({
    required this.name,
    required this.specialization,
  });
}

final List<Doctor> doctors = [
  Doctor(name: 'Dr. Adam Ansari', specialization: 'Cardiologist'),
  Doctor(name: 'Dr. Abhijeet Jadhav', specialization: 'Neurologist'),
  Doctor(name: 'Dr. Vineet Shinde', specialization: 'Orthopedic'),
  Doctor(name: 'Dr. Abhishek Jha', specialization: 'Pediatrician'),
  Doctor(name: 'Dr. Ram Verma', specialization: 'Dermatologist'),
  Doctor(name: 'Dr. Rohit Basak', specialization: 'Gynecologist'),
  Doctor(name: 'Dr. Atharva Angre', specialization: 'General Physician'),
]; 