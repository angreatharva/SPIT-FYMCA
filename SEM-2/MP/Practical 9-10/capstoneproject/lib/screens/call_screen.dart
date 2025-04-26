import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart' as getx;
import '../controllers/user_controller.dart';
import '../services/signalling.service.dart';
import '../services/native_speech_service.dart';
import '../controllers/calling_controller.dart';

class CallScreen extends StatefulWidget {
  final String callerId;
  final String calleeId;
  final dynamic offer;
  final bool isDoctor;
  final String? requestId;

  const CallScreen({
    super.key,
    this.offer,
    required this.callerId,
    required this.calleeId,
    required this.isDoctor,
    this.requestId,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with WidgetsBindingObserver {
  // WebRTC related variables
  final socket = SignallingService.instance.socket;
  final _localRTCVideoRenderer = RTCVideoRenderer();
  final _remoteRTCVideoRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  RTCPeerConnection? _rtcPeerConnection;
  List<RTCIceCandidate> rtcIceCadidates = [];
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  bool _isConnected = false;
  bool _webrtcInitialized = false;

  // UI variables
  final Color _primaryColor = const Color(0xFF2A7DE1); // Medical blue
  final Color _accentColor = const Color(0xFF1E5BB6); // Darker medical blue
  final Color _backgroundColor = const Color(0xFFF5F9FC); // Light blue-tinted white
  final Color _secondaryColor = const Color(0xFF10B981); // Teal/green for positive actions
  final Color _dangerColor = const Color(0xFFEF4444); // Red for ending call/negative actions
  Timer? _callDurationTimer;
  String _callDuration = "00:00";
  DateTime? _callStartTime;

  // Speech recognition
  final NativeSpeechService _speechService = NativeSpeechService();
  bool _isSpeechEnabled = false;
  bool _isTranscribing = false;
  String _recognizedText = '';
  StreamSubscription? _transcriptionSubscription;
  
  // Calling controller
  final CallingController _callingController = getx.Get.find<CallingController>();

  final UserController _userController = getx.Get.find<UserController>();


  @override
  void initState() {
    _checkMicPermission();
    WidgetsBinding.instance.addObserver(this);
    _localRTCVideoRenderer.initialize();
    _remoteRTCVideoRenderer.initialize();
    _setupPeerConnection();
    _startCallTimer();
    super.initState();
  }

  void _startCallTimer() {
    _callStartTime = DateTime.now();
    _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        final duration = DateTime.now().difference(_callStartTime!);
        setState(() {
          _callDuration = _formatDuration(duration);
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> _initializeSpeechRecognition() async {
    // Only initialize speech recognition after WebRTC is fully set up
    // This ensures the audio pipeline is established first
    if (!_webrtcInitialized) {
      debugPrint('Cannot initialize speech recognition: WebRTC not initialized');
      return;
    }

    // Make sure audio is available
    if (_localStream == null || _localStream!.getAudioTracks().isEmpty) {
      debugPrint('Cannot initialize speech recognition: No audio tracks available');
      return;
    }

    final isInitialized = await _speechService.initialize();

    if (isInitialized) {
      _transcriptionSubscription = _speechService.transcriptionStream.listen(
              (text) {
            setState(() {
              _recognizedText = text;
            });
          },
          onError: (error) {
            debugPrint('Transcription error: $error');
          }
      );

      // Set English as default language - can be changed based on user preference
      await _speechService.setLanguage('en-US');

      setState(() {
        _isSpeechEnabled = true;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Pause transcription when app is in background
    if (state == AppLifecycleState.paused) {
      if (_isTranscribing) {
        _stopTranscription();
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _checkMicPermission() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      debugPrint('Microphone permission denied');
    } else {
      debugPrint('Microphone permission allowed');
    }
  }

  // WebRTC setup code
  _setupPeerConnection() async {
    debugPrint("🔧 Creating Peer Connection...");
    _rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        },
        {
          'urls': "stun:stun.relay.metered.ca:80",
        },
        {
          'urls': "turn:global.relay.metered.ca:80",
          'username': "c0bff27b06d608b3c25fd6e9",
          'credential': "1nviIBKZFFqW64IH",
        },
        {
          'urls': "turn:global.relay.metered.ca:80?transport=tcp",
          'username': "c0bff27b06d608b3c25fd6e9",
          'credential': "1nviIBKZFFqW64IH",
        },
        {
          'urls': "turn:global.relay.metered.ca:443",
          'username': "c0bff27b06d608b3c25fd6e9",
          'credential': "1nviIBKZFFqW64IH",
        },
        {
          'urls': "turns:global.relay.metered.ca:443?transport=tcp",
          'username': "c0bff27b06d608b3c25fd6e9",
          'credential': "1nviIBKZFFqW64IH",
        },
      ]
    });

    debugPrint("🌐 Peer connection created. TURN/STUN setup done!");

    _rtcPeerConnection!.onIceConnectionState = (state) {
      debugPrint("📶 ICE Connection State: $state");
    };

    _rtcPeerConnection!.onConnectionState = (state) {
      debugPrint("🔄 PeerConnectionState: $state");
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        debugPrint("✅ Connected to peer successfully! 🎉");
        setState(() => _isConnected = true);
      }
    };

    _rtcPeerConnection!.onTrack = (event) {
      debugPrint("🎥 Remote track received!");
      _remoteRTCVideoRenderer.srcObject = event.streams[0];
      setState(() {
        _isConnected = true;
      });
    };

    // Configure optimal audio settings for speech recognition
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': {
        'echoCancellation': true,
        'noiseSuppression': true,
        'autoGainControl': true,
        'sampleRate': 44100,
      },
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });

    _localStream!.getTracks().forEach((track) {
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });

    _localRTCVideoRenderer.srcObject = _localStream;
    debugPrint("📷 Local stream setup done");

    if (widget.offer != null) {
      debugPrint("📞 Incoming call detected...");

      socket!.on("IceCandidate", (data) {
        debugPrint("❄️ ICE Candidate received");
        String candidate = data["iceCandidate"]["candidate"];
        String sdpMid = data["iceCandidate"]["id"];
        int sdpMLineIndex = data["iceCandidate"]["label"];

        _rtcPeerConnection!.addCandidate(RTCIceCandidate(
          candidate,
          sdpMid,
          sdpMLineIndex,
        ));
      });

      await _rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(widget.offer["sdp"], widget.offer["type"]),
      );

      debugPrint("📩 Remote offer set. Creating answer...");

      RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();
      await _rtcPeerConnection!.setLocalDescription(answer);

      socket!.emit("answerCall", {
        "callerId": widget.callerId,
        "sdpAnswer": answer.toMap(),
      });

      debugPrint("📨 Answer sent to caller");
    } else {
      debugPrint("📤 Outgoing call... Creating offer");

      _rtcPeerConnection!.onIceCandidate =
          (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);

      socket!.on("callAnswered", (data) async {
        debugPrint("📥 Call answered. Setting remote description");

        await _rtcPeerConnection!.setRemoteDescription(
          RTCSessionDescription(
            data["sdpAnswer"]["sdp"],
            data["sdpAnswer"]["type"],
          ),
        );

        for (RTCIceCandidate candidate in rtcIceCadidates) {
          socket!.emit("IceCandidate", {
            "calleeId": widget.calleeId,
            "iceCandidate": {
              "id": candidate.sdpMid,
              "label": candidate.sdpMLineIndex,
              "candidate": candidate.candidate
            }
          });
        }
        debugPrint("🚀 All ICE candidates sent");
      });

      RTCSessionDescription offer = await _rtcPeerConnection!.createOffer();
      await _rtcPeerConnection!.setLocalDescription(offer);

      socket!.emit('makeCall', {
        "calleeId": widget.calleeId,
        "sdpOffer": offer.toMap(),
      });

      debugPrint("📞 Offer sent to callee");
    }

    // Mark WebRTC as initialized and ready to share with speech recognition
    setState(() {
      _webrtcInitialized = true;
    });

    // Initialize speech recognition after WebRTC is set up
    // This ensures proper audio pipeline coordination
    await _initializeSpeechRecognition();
  }

  _leaveCall() {
    _showEndCallDialog();
  }

  // Clean up resources when call ends
  Future<void> _cleanupCall() async {
    // Stop timers
    _callDurationTimer?.cancel();
    
    // Stop speech recognition
    if (_isTranscribing) {
      await _stopTranscription();
    }
    _transcriptionSubscription?.cancel();
    
    // Close WebRTC connection
    _localStream?.getTracks().forEach((track) => track.stop());
    await _rtcPeerConnection?.close();
    await _localRTCVideoRenderer.dispose();
    await _remoteRTCVideoRenderer.dispose();
    
    // If this is a doctor and we have a request ID, mark the call as completed
    if (widget.isDoctor && widget.requestId != null) {
      await _completeCallRequest();
    }
  }
  
  // Mark call as completed on the server
  Future<void> _completeCallRequest() async {
    if (widget.requestId != null) {
      await _callingController.updateCallRequestStatus(
        widget.requestId!,
        'completed'
      );
      debugPrint("📝 Call marked as completed on server");
    }
  }

  _showEndCallDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('End Consultation'),
          content: const Text('Are you sure you want to end this consultation?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel', style: TextStyle(color: _primaryColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _dangerColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                
                // Clean up resources
                await _cleanupCall();
                
                // If doctor, refresh pending calls first
                if (widget.isDoctor && widget.requestId != null) {
                  await _callingController.fetchPendingRequests(_callingController.doctorId.value);
                }
                
                // Leave call screen
                getx.Get.back();
              },
              child: const Text('End Call'),
            ),
          ],
        );
      },
    );
  }

  _toggleMic() {
    // Update WebRTC audio track state
    isAudioOn = !isAudioOn;
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });

    // If microphone is turned off, also stop transcription
    if (!isAudioOn && _isTranscribing) {
      _stopTranscription();
    }

    debugPrint(isAudioOn ? "🎤 Mic ON" : "🔇 Mic OFF");
    setState(() {});
  }

  _toggleCamera() {
    isVideoOn = !isVideoOn;
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
    debugPrint(isVideoOn ? "📸 Camera ON" : "📷 Camera OFF");
    setState(() {});
  }

  _switchCamera() {
    isFrontCameraSelected = !isFrontCameraSelected;
    _localStream?.getVideoTracks().forEach((track) {
      track.switchCamera();
    });
    debugPrint("🔁 Switched Camera");
    setState(() {});
  }

  _toggleTranscription() async {
    // Ensure WebRTC is initialized before attempting transcription
    if (!_webrtcInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for call connection before enabling transcription'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check if audio track is available and active
    bool audioAvailable = _localStream != null &&
        _localStream!.getAudioTracks().isNotEmpty &&
        _localStream!.getAudioTracks().first.enabled;

    if (!audioAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Audio track is not available for transcription'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (!_isSpeechEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Speech recognition is not available on this device'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Can't transcribe if audio is muted
    if (!isAudioOn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please turn on microphone to use transcription'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_isTranscribing) {
      await _stopTranscription();
    } else {
      await _startTranscription();
    }
  }

  Future<void> _startTranscription() async {
    if (!_isSpeechEnabled || _isTranscribing || !isAudioOn) return;

    final success = await _speechService.startRecognition();
    if (success) {
      setState(() {
        _isTranscribing = true;
        _recognizedText = 'Listening...';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to start speech recognition'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _stopTranscription() async {
    if (!_isTranscribing) return;

    final success = await _speechService.stopRecognition();
    if (success) {
      setState(() {
        _isTranscribing = false;
      });
    }
  }

  void _clearTranscription() {
    setState(() {
      _recognizedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final roleText = widget.isDoctor ? "Doctor" : "Patient";

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              widget.isDoctor ? Icons.medical_services : Icons.person,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "Teleconsultation",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  _callDuration,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                // Remote video as main content
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RTCVideoView(
                    _remoteRTCVideoRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),

                // Connection status indicator
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: !_isConnected
                      ? Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  _primaryColor),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Establishing secure connection...",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _secondaryColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.shield,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Secure Connection Established",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Local video feed with elegant design
                Positioned(
                  right: 16,
                  bottom: 20,
                  child: Container(
                    height: 180,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RTCVideoView(
                        _localRTCVideoRenderer,
                        mirror: isFrontCameraSelected,
                        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      ),
                    ),
                  ),
                ),

                // Role indicator
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: widget.isDoctor ? _accentColor : _secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          widget.isDoctor ? Icons.medical_services : Icons.person,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          roleText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Transcription display
                if (_recognizedText.isNotEmpty)
                  Positioned(
                    top: 70,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _isTranscribing ? Icons.mic : Icons.mic_none,
                                color: _isTranscribing ? _secondaryColor : _primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _isTranscribing ? 'Live Transcription' : 'Transcription',
                                style: TextStyle(
                                  color: _isTranscribing ? _secondaryColor : _primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: _clearTranscription,
                                child: Icon(Icons.close, color: Colors.grey, size: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _recognizedText,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ]),
            ),

            // Call controls with enhanced design
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildControlButton(
                    icon: isAudioOn ? Icons.mic : Icons.mic_off,
                    label: isAudioOn ? "Mute" : "Unmute",
                    color: isAudioOn ? _primaryColor : Colors.grey,
                    onPressed: _toggleMic,
                  ),
                  _buildControlButton(
                    icon: Icons.call_end,
                    label: "End",
                    color: _dangerColor,
                    onPressed: _leaveCall,
                    isEndCall: true,
                  ),
                  _buildControlButton(
                    icon: Icons.cameraswitch,
                    label: "Switch",
                    color: _primaryColor,
                    onPressed: _switchCamera,
                  ),
                  _buildControlButton(
                    icon: isVideoOn ? Icons.videocam : Icons.videocam_off,
                    label: isVideoOn ? "Hide" : "Show",
                    color: isVideoOn ? _primaryColor : Colors.grey,
                    onPressed: _toggleCamera,
                  ),
                  _buildControlButton(
                    icon: _isTranscribing ? Icons.record_voice_over : Icons.voice_over_off,
                    label: _isTranscribing ? "Stop" : "Transcribe",
                    color: _isTranscribing ? _secondaryColor : (_isSpeechEnabled ? _primaryColor : Colors.grey),
                    onPressed: _toggleTranscription,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    bool isEndCall = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: isEndCall ? color : color.withOpacity(0.1),
            shape: BoxShape.circle,
            boxShadow: isEndCall
                ? [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
                : null,
          ),
          child: IconButton(
            icon: Icon(icon),
            color: isEndCall ? Colors.white : color,
            iconSize: isEndCall ? 26 : 22,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isEndCall ? color : Colors.black87,
            fontWeight: isEndCall ? FontWeight.bold : FontWeight.normal,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    debugPrint("🧹 Cleaning up call resources");
    _callDurationTimer?.cancel();
    _transcriptionSubscription?.cancel();
    _localStream?.getTracks().forEach((track) => track.stop());
    _rtcPeerConnection?.close();
    _localRTCVideoRenderer.dispose();
    _remoteRTCVideoRenderer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Join Call (handles both outgoing and incoming calls)
  void _joinCall({
    required String callerId,
    required String calleeId,
    dynamic offer,
    String? requestId,
  }) {
    // Navigate to call screen
    getx.Get.to(() => CallScreen(
      callerId: callerId,
      calleeId: calleeId,
      offer: offer,
      isDoctor: _userController.isDoctor,
      requestId: requestId,
    ));
    
    // Clear incoming call offer
    _callingController.clearIncomingCall();
  }
}