import 'package:get/get.dart';
import '../models/doctor.dart';
import '../services/doctor_service.dart';
import '../services/storage_service.dart';
import 'dart:developer' as dev;
import 'dart:async';

class DoctorController extends GetxController {
  final RxList<Doctor> availableDoctors = <Doctor>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool doctorStatus = false.obs;
  final RxBool isToggling = false.obs;
  final RxInt selectedFilterIndex = 0.obs;
  
  final RxList<Doctor> _allDoctors = <Doctor>[].obs;

  late final DoctorService _doctorService;
  var debouncer = Debounce(Duration(milliseconds: 500));

  @override
  void onInit() {
    super.onInit();
    dev.log('DoctorController initialized');
    
    // Initialize the doctor service
    _doctorService = DoctorService();
    
    // Fetch available doctors on initialization
    fetchAvailableDoctors();
    
    // Check if current user is a doctor
    final storageService = StorageService.instance;
    final user = storageService.getUserData();
    
    if (user != null && user.isDoctor) {
      dev.log('User is a doctor, fetching status for doctor: ${user.id}');
      fetchDoctorStatus(user.id);
    }
  }

  Future<void> fetchAvailableDoctors() async {
    try {
      isLoading.value = true;
      dev.log('Fetching available doctors');
      final doctors = await _doctorService.getAvailableDoctors();
      _allDoctors.assignAll(doctors);
      _applyFilter();
      dev.log('Fetched ${doctors.length} available doctors');
    } catch (e) {
      dev.log('Error fetching doctors: $e');
      _allDoctors.clear();
      availableDoctors.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void changeFilter(int index) {
    selectedFilterIndex.value = index;
    _applyFilter();
  }

  void _applyFilter() {
    final index = selectedFilterIndex.value;
    
    if (index == 0) {
      availableDoctors.assignAll(_allDoctors);
    } else if (index == 1) {
      availableDoctors.assignAll(
        _allDoctors.where((doctor) => 
          doctor.specialization.toLowerCase() == 'general' ||
          doctor.specialization.toLowerCase() == 'general medicine' ||
          doctor.specialization.toLowerCase() == 'general physician'
        ).toList()
      );
    } else if (index == 2) {
      availableDoctors.assignAll(
        _allDoctors.where((doctor) => 
          doctor.specialization.toLowerCase() != 'general' &&
          doctor.specialization.toLowerCase() != 'general medicine' &&
          doctor.specialization.toLowerCase() != 'general physician'
        ).toList()
      );
    }
    
    dev.log('Applied filter $index, showing ${availableDoctors.length} doctors');
  }

  Future<void> fetchDoctorStatus(String doctorId) async {
    try {
      dev.log('Fetching status for doctor: $doctorId');
      final status = await _doctorService.getDoctorStatus(doctorId);
      doctorStatus.value = status;
      dev.log('Doctor status: ${status ? 'active' : 'inactive'}');
    } catch (e) {
      dev.log('Error fetching doctor status: $e');
      // Keep existing status on error
    }
  }

  Future<void> toggleDoctorStatus(String doctorId) async {
    if (isToggling.value) {
      dev.log('Already toggling status, ignoring request');
      return;
    }
    
    isToggling.value = true;
    
    try {
      dev.log('Toggling status for doctor: $doctorId');
      final newStatus = await _doctorService.toggleActiveStatus(doctorId);
      doctorStatus.value = newStatus;
      dev.log('New doctor status: ${newStatus ? 'active' : 'inactive'}');
    } catch (e) {
      dev.log('Error toggling doctor status: $e');
      // Don't update status on error
    } finally {
      isToggling.value = false;
    }
  }

  @override
  void onClose() {
    debouncer.dispose();
    dev.log('DoctorController disposed');
    super.onClose();
  }
}

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce(this.delay);

  call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  dispose() {
    _timer?.cancel();
    _timer = null;
  }
}