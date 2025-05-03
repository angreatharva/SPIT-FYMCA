import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  // instance of Socket
  Socket? socket;
  String? _currentCallerId;

  SignallingService._();
  static final instance = SignallingService._();

  init({required String websocketUrl, required String selfCallerID}) {
    _currentCallerId = selfCallerID;
    log("Initializing SignallingService with caller ID: $selfCallerID");
    
    // init Socket
    socket = io(websocketUrl, {
      "transports": ['websocket'],
      "query": {"callerId": selfCallerID}
    });

    // listen onConnect event
    socket!.onConnect((data) {
      log("Socket connected with caller ID: $_currentCallerId !!");
      
      // Emit an event to verify our caller ID on the server
      socket!.emit('verifyCallerId', {"callerId": _currentCallerId});
    });

    // listen onConnectError event
    socket!.onConnectError((data) {
      log("Connect Error with caller ID $_currentCallerId: $data");
    });

    // connect socket
    socket!.connect();
  }
  
  // Method to update the caller ID after login
  void updateCallerId(String newCallerId) {
    if (_currentCallerId == newCallerId) {
      // No change needed
      log("Caller ID is already set to: $newCallerId - no change needed");
      return;
    }
    
    log("Updating caller ID from: $_currentCallerId to: $newCallerId");
    _currentCallerId = newCallerId;
    
    // Disconnect the current socket
    if (socket != null) {
      log("Disconnecting current socket to update caller ID");
      socket!.disconnect();
      
      // Create a new socket with the updated caller ID
      socket = io(socket!.io.uri, {
        "transports": ['websocket'],
        "query": {"callerId": newCallerId}
      });
      
      // Re-register event listeners
      socket!.onConnect((data) {
        log("Socket reconnected with new caller ID: $newCallerId");
        
        // Emit an event to verify our caller ID on the server
        socket!.emit('verifyCallerId', {"callerId": newCallerId});
      });
      
      socket!.onConnectError((data) {
        log("Connect Error with new caller ID: $data");
      });
      
      // Connect the new socket
      log("Connecting new socket with caller ID: $newCallerId");
      socket!.connect();
    }
  }
}
