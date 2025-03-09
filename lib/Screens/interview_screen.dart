// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:video_compress/video_compress.dart';
import 'dart:convert';
import 'dart:io';

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({super.key});
  @override
  _InterviewScreenState createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  String transcriptionResult = '';
  bool isLoading = false;
  String errorMessage = '';

  // Function to show transcription result
  void showTranscriptionResult(String result) {
    setState(() {
      transcriptionResult = result;
    });
  }

  // Function to show error message
  void showError(String error) {
    setState(() {
      errorMessage = error;
    });
  }

  // Pick video and transcribe
  Future<void> handleVideoSelection() async {
    XFile? videoFile = await pickVideo();
    if (videoFile != null) {
      await transcribeVideo(videoFile);
    }
  }

  // Function to pick a video file
  Future<XFile?> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
    ); // or ImageSource.camera
    return video;
  }

  Future<void> transcribeVideo(XFile? videoFile) async {
    if (videoFile == null) {
      showError("No video selected.");
      return;
    }

    // Validate video file size (max 50MB for example)
    if (await videoFile.length() > 50 * 1024 * 1024) {
      // 50MB
      showError(
        "The selected video file is too large. Please choose a smaller file.",
      );
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = ''; // Clear previous error messages
    });

    var uri = Uri.parse(
      'https://3e04-41-35-188-247.ngrok-free.app/transcribe',
    ); // Update to ngrok URL if needed
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', videoFile.path));

    try {
      var response = await request.send();

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final result = await response.stream.bytesToString();
        final responseJson = json.decode(result);
        showTranscriptionResult(responseJson["text"]);
      } else {
        showError("Failed to transcribe. Status code: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showError("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interview Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: handleVideoSelection,
              child: Text('Pick Video for Transcription'),
            ),
            SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  errorMessage,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            Text(
              'Transcription Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Text(
                    transcriptionResult.isNotEmpty
                        ? transcriptionResult
                        : 'No transcription yet.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
