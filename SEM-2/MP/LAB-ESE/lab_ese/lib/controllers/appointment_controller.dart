import 'package:get/get.dart';
import 'package:lab_ese/constants/doctors_list.dart';
import 'package:lab_ese/models/patient_model.dart';
import 'package:lab_ese/services/firebase_service.dart';

class AppointmentController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  
  final RxString name = ''.obs;
  final RxString address = ''.obs;
  final RxString age = ''.obs;
  final RxString contactDetails = ''.obs;
  final RxString symptoms = ''.obs;
  final RxString selectedDoctor = doctors.first.name.obs;
  final Rx<DateTime> appointmentDate = DateTime.now().obs;
  
  final RxBool isLoading = false.obs;
  
  final RxList<Patient> patients = <Patient>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadPatients();
  }
  
  void setAppointmentDate(DateTime date) {
    appointmentDate.value = date;
  }
  
  void setSelectedDoctor(String doctor) {
    selectedDoctor.value = doctor;
  }
  
  Future<bool> saveAppointment() async {
    isLoading.value = true;
    
    try {
      Patient patient = Patient(
        name: name.value,
        address: address.value,
        age: int.parse(age.value),
        contactDetails: contactDetails.value,
        symptoms: symptoms.value,
        doctorName: selectedDoctor.value,
        appointmentDate: appointmentDate.value,
      );
      
      await _firebaseService.addPatient(patient);
      resetForm();
      await loadPatients();
      return true;
    } catch (e) {
      print('Error saving appointment: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> loadPatients() async {
    isLoading.value = true;
    
    try {
      final patientsList = await _firebaseService.getPatients();
      patients.value = patientsList;
    } catch (e) {
      print('Error loading patients: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  void resetForm() {
    name.value = '';
    address.value = '';
    age.value = '';
    contactDetails.value = '';
    symptoms.value = '';
    selectedDoctor.value = doctors.first.name;
    appointmentDate.value = DateTime.now();
  }
} 