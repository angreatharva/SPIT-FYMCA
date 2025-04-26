import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// A service to interact with native speech recognition capabilities
class NativeSpeechService {
  static const MethodChannel _methodChannel =
      MethodChannel('com.example.webrtc_application/speech_recognition');
  static const EventChannel _eventChannel =
      EventChannel('com.example.webrtc_application/speech_events');

  // Stream controller for recognition results
  final StreamController<String> _recognitionResultsController =
      StreamController<String>.broadcast();
  StreamSubscription? _eventChannelSubscription;

  // Public streams
  Stream<String> get recognitionResults => _recognitionResultsController.stream;
  // Alias for backward compatibility
  Stream<String> get transcriptionStream => recognitionResults;

  // State tracking
  bool _isInitialized = false;
  bool _isRecognizing = false;
  bool _isListening = false;
  
  // Singleton pattern
  static final NativeSpeechService _instance = NativeSpeechService._internal();
  factory NativeSpeechService() => _instance;
  NativeSpeechService._internal() {
    _setupEventListener();
  }
  
  /// Initialize the speech recognition service
  Future<bool> initialize() async {
    if (_isInitialized) return true;
    
    try {
      // Request microphone permission if not already granted
      final permissionStatus = await Permission.microphone.request();
      if (permissionStatus != PermissionStatus.granted) {
        debugPrint('Microphone permission denied');
        return false;
      }
      
      // Initialize the native module
      final bool isAvailable = await _methodChannel.invokeMethod('initialize');
      if (isAvailable) {
        if (!_isListening) {
          _setupEventListener();
        }
        _isInitialized = true;
      }
      return isAvailable;
    } catch (e) {
      //No implementation found for method initialize on channel com.example.webrtc_application/speech_recognition
      debugPrint('Error initializing native speech recognition: $e');
      return false;
    }
  }
  
  /// Set the recognition language
  Future<bool> setLanguage(String languageCode) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return false;
    }
    
    try {
      return await _methodChannel.invokeMethod('setLanguage', {
        'language': languageCode,
      });
    } catch (e) {
      debugPrint('Error setting language: $e');
      return false;
    }
  }
  
  /// Start speech recognition
  Future<bool> startListening() async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return false;
    }
    
    if (_isRecognizing) return true;
    
    try {
      final result = await _methodChannel.invokeMethod('start');
      _isRecognizing = result;
      return result;
    } catch (e) {
      debugPrint('Error starting speech recognition: $e');
      return false;
    }
  }
  
  // Alias for startListening to maintain compatibility
  Future<bool> startRecognition() => startListening();
  
  /// Stop speech recognition
  Future<bool> stopListening() async {
    if (!_isInitialized || !_isRecognizing) return false;
    
    try {
      final result = await _methodChannel.invokeMethod('stop');
      if (result) {
        _isRecognizing = false;
      }
      return result;
    } catch (e) {
      debugPrint('Error stopping speech recognition: $e');
      return false;
    }
  }
  
  // Alias for stopListening to maintain compatibility
  Future<bool> stopRecognition() => stopListening();
  
  /// Check if currently recognizing
  Future<bool> isRecognizing() async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return false;
    }
    
    try {
      return await _methodChannel.invokeMethod('isRecognizing');
    } catch (e) {
      debugPrint('Error checking recognition status: $e');
      return false;
    }
  }
  
  /// Set up the event listener to handle speech recognition results
  void _setupEventListener() {
    // Cancel any existing subscription to avoid duplicate listeners
    _eventChannelSubscription?.cancel();
    
    _eventChannelSubscription = _eventChannel
        .receiveBroadcastStream()
        .listen((dynamic event) {
      if (event is String) {
        _recognitionResultsController.add(event);
      }
    }, onError: (dynamic error) {
      // Handle error from the native side
      debugPrint('Speech recognition error: ${error.message}');
    });
    
    _isListening = true;
  }
  
  /// Dispose resources
  void dispose() {
    stopListening();
    _eventChannelSubscription?.cancel();
    _eventChannelSubscription = null;
    _isListening = false;
    _recognitionResultsController.close();
  }
} 