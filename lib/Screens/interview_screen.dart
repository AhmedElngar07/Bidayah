import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart'; // Add this import

// Make these values configurable from the UI to easily update the URL
String _ngrokBaseUrl = 'https://1396-41-35-188-247.ngrok-free.app';
String _analysisEndpoint = '/transcribe';
bool _debugMode = true; // Toggle for showing debug logs

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = DevHttpOverrides();

  // Print debug info
  if (_debugMode) {
    print("Starting app with API URL: $_ngrokBaseUrl$_analysisEndpoint");
  }

  final cameras = await availableCameras();
  runApp(MaterialApp(home: InterviewScreen(cameras: cameras)));
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (cert, host, port) => true;
}

class InterviewScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const InterviewScreen({super.key, required this.cameras});

  @override
  _InterviewScreenState createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  late CameraController _controller;
  bool _isRecording = false;
  bool _isProcessing = false;
  String _transcript = '';
  String _emotion = '';
  String _error = '';
  XFile? _videoFile;
  List<Map<String, dynamic>> _chat = [];
  Timer? _questionTimer;
  Timer? _recordingTimer;
  Timer? _stopRecordingTimer;
  VideoPlayerController? _videoPlayerController;
  TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlController.text = _ngrokBaseUrl;
    _initCamera();
    _startInterviewFlow();
  }

  Future<void> _initCamera() async {
    try {
      _controller = CameraController(
        widget.cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => widget.cameras.first,
        ),
        ResolutionPreset.medium,
        enableAudio: true,
      );
      await _controller.initialize();
      setState(() {});
      if (_debugMode) print("Camera initialized successfully");
    } catch (e) {
      _handleError('Camera Error: $e');
    }
  }

  void _startInterviewFlow() {
    _addChatMessage(
      "AI",
      "Welcome to the interview! Your first question will appear in 7 seconds...",
      null,
    );
    _questionTimer = Timer(const Duration(seconds: 7), () {
      _addChatMessage("AI", "What are your strengths and weaknesses?", null);
      _recordingTimer = Timer(const Duration(seconds: 4), () {
        _toggleRecording();
      });
    });
  }

  void _addChatMessage(String sender, String message, String? videoPath) {
    setState(() {
      _chat.add({"sender": sender, "message": message, "videoPath": videoPath});
    });
  }

  Future<void> _toggleRecording() async {
    if (!_controller.value.isInitialized) return;
    try {
      if (_isRecording) {
        if (_debugMode) print("Stopping recording...");
        setState(() => _isRecording = false);
        _stopRecordingTimer?.cancel();
        _videoFile = await _controller.stopVideoRecording();
        if (_debugMode) print("Video saved to: ${_videoFile?.path}");

        if (_videoFile != null) {
          final tempDir = await getTemporaryDirectory();
          final savedVideoPath =
              '${tempDir.path}/interview_${DateTime.now().millisecondsSinceEpoch}.mp4';
          await File(_videoFile!.path).copy(savedVideoPath);
          if (_debugMode) print("Video copied to: $savedVideoPath");

          _addChatMessage("User", "My answer:", savedVideoPath);
          await _processVideo(File(savedVideoPath));
        }
      } else {
        if (_debugMode) print("Starting recording...");
        await _controller.startVideoRecording();
        setState(() => _isRecording = true);
        _stopRecordingTimer = Timer(const Duration(seconds: 30), () {
          if (_isRecording) _toggleRecording();
        });
      }
    } catch (e) {
      _handleError('Recording Error: $e');
    }
  }

  Future<void> _processVideo(File videoFile) async {
    if (_debugMode) {
      print("Processing video: ${videoFile.path}");
      print("File exists: ${await videoFile.exists()}");
      print("File size: ${await videoFile.length()} bytes");
    }

    if (!await _validateVideo(videoFile)) return;
    setState(() {
      _isProcessing = true;
      _error = _transcript = _emotion = '';
    });

    try {
      if (_debugMode)
        print("Calling API with URL: $_ngrokBaseUrl$_analysisEndpoint");

      // Add a message to show we're calling the API
      _addChatMessage("System", "Calling API to analyze video...", null);

      final result = await _callCombinedApiService(videoFile);
      if (_debugMode) print("API result: $result");

      // Display full API response for debugging
      if (_debugMode) {
        _addChatMessage(
          "System",
          "Debug - Raw API response: ${result.toString()}",
          null,
        );
      }

      setState(() {
        _transcript = result['transcript'] ?? '';
        _emotion = result['emotion'] ?? '';
      });

      // Add more detailed feedback
      _addChatMessage("AI", "Analysis complete:", null);

      if (_emotion.isEmpty || _emotion == 'No emotion data') {
        _addChatMessage("AI", "Emotion: Could not detect emotion", null);
      } else {
        _addChatMessage("AI", "Emotion: $_emotion", null);
      }

      if (_transcript.isEmpty || _transcript == 'No transcript data') {
        _addChatMessage("AI", "Transcript: Could not transcribe audio", null);
      } else {
        _addChatMessage("AI", "Transcript: $_transcript", null);
      }
    } catch (e) {
      _handleError('Processing Error: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<bool> _validateVideo(File file) async {
    final size = await file.length();
    if (_debugMode) print("Validating video, size: $size bytes");

    if (size > 100 * 1024 * 1024) {
      _handleError('Video exceeds 100MB limit');
      return false;
    }
    if (size == 0) {
      _handleError('Video file is empty');
      return false;
    }
    return true;
  }

  // In the _callCombinedApiService method, change the field name from 'video' to 'file'
  // This is the updated function for the Flutter app to correctly parse the FastAPI response
  Future<Map<String, String>> _callCombinedApiService(File file) async {
    try {
      final uri = Uri.parse('$_ngrokBaseUrl$_analysisEndpoint');
      if (_debugMode) {
        print("Preparing API request to: $uri");
        print("File path: ${file.path}");
        print("File exists: ${await file.exists()}");
        print("File size: ${await file.length()} bytes");
      }

      // Create multipart request
      final request = http.MultipartRequest('POST', uri);

      // Use 'file' as the field name to match FastAPI parameter
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      });

      if (_debugMode) print("Sending multipart request...");
      final streamedResponse = await request.send().timeout(
        const Duration(
          seconds: 120,
        ), // Increased timeout for processing large videos
      );

      if (_debugMode) print("Response status: ${streamedResponse.statusCode}");
      final body = await streamedResponse.stream.bytesToString();

      // Detailed response logging
      if (_debugMode) {
        print("Response headers: ${streamedResponse.headers}");
        print("Response body (raw): $body");
      }

      if (streamedResponse.statusCode != 200) {
        throw Exception('Server error: ${streamedResponse.statusCode}, $body');
      }

      // Handle empty response
      if (body.isEmpty) {
        if (_debugMode) print("Warning: Empty response body");
        return {
          'transcript': 'Empty response from server',
          'emotion': 'Empty response from server',
        };
      }

      // Parse the JSON response
      Map<String, dynamic> decodedBody;
      try {
        decodedBody = jsonDecode(body);
      } catch (e) {
        if (_debugMode) print("JSON decode error: $e");
        return {
          'transcript': 'Error parsing server response: $e',
          'emotion': 'Error parsing server response: $e',
        };
      }

      // Extract data with more flexible field detection
      String transcript = 'No transcript data';
      String emotion = 'No emotion data';

      // Try different field names for transcript
      if (decodedBody.containsKey('transcript')) {
        transcript =
            decodedBody['transcript']?.toString() ?? 'No transcript data';
      } else if (decodedBody.containsKey('text')) {
        transcript = decodedBody['text']?.toString() ?? 'No transcript data';
      }

      // Try different field names for emotion
      if (decodedBody.containsKey('emotion')) {
        emotion = decodedBody['emotion']?.toString() ?? 'No emotion data';
      } else if (decodedBody.containsKey('face_reactions') &&
          decodedBody['face_reactions'] is Map &&
          decodedBody['face_reactions'].containsKey('dominant_emotion')) {
        emotion =
            decodedBody['face_reactions']['dominant_emotion']?.toString() ??
            'No emotion data';
      }

      if (_debugMode) {
        print("Extracted transcript: $transcript");
        print("Extracted emotion: $emotion");
      }

      return {'transcript': transcript, 'emotion': emotion};
    } catch (e) {
      if (_debugMode) {
        print("API call failed with error: $e");
        // Try to ping the server to check connectivity
        try {
          final response = await http
              .get(Uri.parse(_ngrokBaseUrl))
              .timeout(const Duration(seconds: 5));
          print("Server ping response: ${response.statusCode}");
        } catch (pingError) {
          print("Server ping failed: $pingError");
        }
      }
      throw Exception('API call failed: $e');
    }
  }

  void _handleError(String message) {
    print("ERROR: $message"); // Always print errors regardless of debug mode
    setState(() {
      _error = message;
      _isProcessing = false;
      _isRecording = false;
    });
    _addChatMessage("AI", "Error: $message", null);
  }

  void _updateServerUrl() {
    setState(() {
      _ngrokBaseUrl = _urlController.text.trim();
      if (_debugMode) print("Updated server URL to: $_ngrokBaseUrl");
    });
    _addChatMessage("System", "Server URL updated to: $_ngrokBaseUrl", null);
  }

  Future<void> _testServerConnection() async {
    try {
      _addChatMessage(
        "System",
        "Testing connection to $_ngrokBaseUrl...",
        null,
      );
      final response = await http
          .get(
            Uri.parse(_ngrokBaseUrl),
            headers: {'ngrok-skip-browser-warning': 'true'},
          )
          .timeout(const Duration(seconds: 10));

      _addChatMessage(
        "System",
        "Connection test result: ${response.statusCode} ${response.reasonPhrase}",
        null,
      );
      if (_debugMode) {
        print("Connection test response: ${response.statusCode}");
        print(
          "Response body: ${response.body.substring(0, min(100, response.body.length))}...",
        );
      }
    } catch (e) {
      _addChatMessage("System", "Connection test failed: $e", null);
      if (_debugMode) print("Connection test error: $e");
    }
  }

  // In the _InterviewScreenState class, add an import method to pick and upload videos

  Future<void> _pickVideoFromGallery() async {
    try {
      setState(() {
        _isProcessing = true;
        _error = '';
      });

      // Use image_picker package to select a video from gallery
      // You'll need to add this to your pubspec.yaml:
      // image_picker: ^0.8.7+5

      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 2), // Optional duration limit
      );

      if (pickedFile == null) {
        if (_debugMode) print("No video selected");
        setState(() => _isProcessing = false);
        return;
      }

      if (_debugMode) {
        print("Video picked: ${pickedFile.path}");
        print("File exists: ${await File(pickedFile.path).exists()}");
        print("File size: ${await File(pickedFile.path).length()} bytes");
      }

      _videoFile = pickedFile;
      _addChatMessage("User", "Video uploaded", pickedFile.path);

      // Process the selected video
      await _processVideo(File(pickedFile.path));
    } catch (e) {
      _handleError('Video Picking Error: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController?.dispose();
    _questionTimer?.cancel();
    _recordingTimer?.cancel();
    _stopRecordingTimer?.cancel();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Interview'),
        actions: [
          IconButton(
            icon: Icon(
              _debugMode ? Icons.bug_report : Icons.bug_report_outlined,
            ),
            onPressed: () {
              setState(() {
                _debugMode = !_debugMode;
              });
              _addChatMessage(
                "System",
                "Debug mode: ${_debugMode ? 'ON' : 'OFF'}",
                null,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Server URL configuration row
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          labelText: 'Server URL',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: _updateServerUrl,
                      tooltip: 'Update URL',
                    ),
                    IconButton(
                      icon: const Icon(Icons.network_check),
                      onPressed: _testServerConnection,
                      tooltip: 'Test Connection',
                    ),
                  ],
                ),
              ),
              Expanded(child: _buildChatView()),
              if (_isProcessing)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text('Analyzing response...'),
                      ],
                    ),
                  ),
                ),
              _buildControls(),
            ],
          ),
          if (_isRecording && _controller.value.isInitialized)
            GestureDetector(
              onTap: _toggleRecording,
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8 * 4 / 3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: ClipOval(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.width * 0.7,
                                child: Transform.scale(
                                  scale: _getCameraScale(),
                                  child: Center(
                                    child: CameraPreview(_controller),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'REC',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: ElevatedButton.icon(
                                onPressed: _toggleRecording,
                                icon: const Icon(
                                  Icons.stop,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Stop Recording',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  double _getCameraScale() {
    if (!_controller.value.isInitialized) return 1.0;
    final double cameraAspectRatio = _controller.value.aspectRatio;
    final double targetWidth = MediaQuery.of(context).size.width * 0.7;
    final double targetHeight = targetWidth;
    return cameraAspectRatio > 1
        ? targetHeight / (targetWidth / cameraAspectRatio)
        : targetWidth / (targetHeight * cameraAspectRatio);
  }

  Widget _buildChatView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _chat.length,
      itemBuilder: (context, index) {
        final msg = _chat[index];
        final isAI = msg["sender"] == "AI";
        final isSystem = msg["sender"] == "System";
        final videoPath = msg["videoPath"];
        return Column(
          crossAxisAlignment:
              isAI
                  ? CrossAxisAlignment.start
                  : isSystem
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color:
                    isAI
                        ? Colors.grey[300]
                        : isSystem
                        ? Colors.amber[100]
                        : Colors.blue[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                msg["message"]!,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: isSystem ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
            if (videoPath != null)
              Container(
                margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                child: VideoPlayerWidget(videoPath: videoPath),
              ),
          ],
        );
      },
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Upload Video button
          FloatingActionButton(
            heroTag: "uploadButton",
            onPressed:
                _isProcessing || _isRecording ? null : _pickVideoFromGallery,
            backgroundColor:
                _isProcessing ? Colors.grey.withOpacity(0.5) : Colors.green,
            child: const Icon(Icons.upload_file, color: Colors.white),
            tooltip: 'Upload video',
          ),
          const SizedBox(width: 24),
          // Record button (existing functionality)
          FloatingActionButton(
            heroTag: "recordButton",
            onPressed: _isProcessing || _isRecording ? null : _toggleRecording,
            backgroundColor:
                _isRecording ? Colors.grey.withOpacity(0.5) : Colors.blue,
            child: Icon(
              _isRecording ? Icons.stop : Icons.videocam,
              color: Colors.white,
            ),
            tooltip: 'Record video',
          ),
        ],
      ),
    );
  }
}

// Import min function
int min(int a, int b) {
  return a < b ? a : b;
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  const VideoPlayerWidget({Key? key, required this.videoPath})
    : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      if (_debugMode)
        print("Initializing video player for: ${widget.videoPath}");
      _controller = VideoPlayerController.file(File(widget.videoPath))
        ..addListener(() => setState(() {}));

      await _controller.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout:
            () => throw TimeoutException('Video initialization timed out'),
      );

      if (_debugMode) print("Video player initialized successfully");
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      if (_debugMode) print("Video player error: $e");
      if (mounted) setState(() => _hasError = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) return _errorWidget();
    if (!_isInitialized) return _loadingWidget();

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(_controller),
          VideoProgressIndicator(_controller, allowScrubbing: true),
          Center(
            child: IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 50,
                color: Colors.white.withOpacity(0.7),
              ),
              onPressed:
                  () => setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorWidget() => Container(
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          const Text(
            'Error loading video',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Text(
            'File path: ${widget.videoPath}',
            style: const TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );

  Widget _loadingWidget() => Container(
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text('Loading video...'),
        ],
      ),
    ),
  );
}
