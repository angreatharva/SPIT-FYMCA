import 'dart:convert';
import 'dart:developer' as dev;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class StorageService extends GetxService {
  static StorageService get instance => Get.find<StorageService>();
  
  final GetStorage _box = GetStorage();
  
  // Storage keys
  static const String _userKey = 'user_data';
  static const String _callerIdKey = 'caller_id';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _healthDataKey = 'health_data';
  
  // Observable user data
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxString callerId = ''.obs;
  final RxBool isLoggedIn = false.obs;
  
  // Initialize the service
  Future<StorageService> init() async {
    await GetStorage.init();
    _loadUserData();
    return this;
  }
  
  // Load user data from storage
  void _loadUserData() {
    try {
      // Load caller ID
      final storedCallerId = _box.read<String>(_callerIdKey);
      if (storedCallerId != null) {
        callerId.value = storedCallerId;
        dev.log('Loaded caller ID: $storedCallerId');
      }
      
      // Load login status
      final loggedIn = _box.read<bool>(_isLoggedInKey) ?? false;
      isLoggedIn.value = loggedIn;
      
      // Load user data
      final userData = _box.read<String>(_userKey);
      if (userData != null) {
        final userJson = jsonDecode(userData);
        currentUser.value = UserModel.fromJson(userJson);
        dev.log('Loaded user data: ${currentUser.value}');
      }
    } catch (e) {
      dev.log('Error loading user data: $e');
      // Clear corrupted data
      clearUserData();
    }
  }
  
  // Save caller ID
  Future<void> saveCallerId(String id) async {
    callerId.value = id;
    await _box.write(_callerIdKey, id);
    dev.log('Saved caller ID: $id');
  }
  
  // Get caller ID
  String getCallerId() {
    return callerId.value;
  }
  
  // Save user data
  Future<void> saveUserData(UserModel user) async {
    try {
      currentUser.value = user;
      await _box.write(_userKey, jsonEncode(user.toJson()));
      await _box.write(_isLoggedInKey, true);
      isLoggedIn.value = true;
      dev.log('Saved user data: $user');
    } catch (e) {
      dev.log('Error saving user data: $e');
    }
  }
  
  // Get user data
  UserModel? getUserData() {
    return currentUser.value;
  }
  
  // Check if user is logged in
  bool isUserLoggedIn() {
    return isLoggedIn.value;
  }
  
  // Clear user data (logout)
  Future<void> clearUserData() async {
    try {
      currentUser.value = null;
      isLoggedIn.value = false;
      await _box.remove(_userKey);
      await _box.write(_isLoggedInKey, false);
      dev.log('User data cleared');
    } catch (e) {
      dev.log('Error clearing user data: $e');
    }
  }
  
  // Save health tracking data
  Future<void> saveHealthData(Map<String, dynamic> healthData) async {
    try {
      await _box.write(_healthDataKey, jsonEncode(healthData));
      dev.log('Health data saved');
    } catch (e) {
      dev.log('Error saving health data: $e');
    }
  }
  
  // Get health tracking data
  String? getHealthData() {
    try {
      return _box.read<String>(_healthDataKey);
    } catch (e) {
      dev.log('Error getting health data: $e');
      return null;
    }
  }
  
  // Clear health tracking data
  Future<void> clearHealthData() async {
    try {
      await _box.remove(_healthDataKey);
      dev.log('Health data cleared');
    } catch (e) {
      dev.log('Error clearing health data: $e');
    }
  }
  
  // Helper method to decode JSON
  dynamic jsonDecode(String data) {
    return json.decode(data);
  }
} 