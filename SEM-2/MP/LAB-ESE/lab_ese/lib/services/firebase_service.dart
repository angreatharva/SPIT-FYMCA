import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'patients';

  Future<String> addPatient(Patient patient) async {
    try {
      DocumentReference docRef = await _firestore.collection(collectionName).add(patient.toJson());
      return docRef.id;
    } catch (e) {
      print('Error adding patient: $e');
      rethrow;
    }
  }

  Future<List<Patient>> getPatients() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        return Patient.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting patients: $e');
      rethrow;
    }
  }
} 