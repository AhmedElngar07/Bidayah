import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

//firebase imports
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

//supabase imports
import 'package:supabase_flutter/supabase_flutter.dart';

//Import the interview_screen;
import 'Screens/interview_screen.dart'; // Adjust the import path as necessary

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://thtuxfwmyucmgvjknfho.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRodHV4ZndteXVjbWd2amtuZmhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2MDY5NjYsImV4cCI6MjA1NjE4Mjk2Nn0.VHaCQ-QSEgb1Alwr3prWMIh5GuCu5JA2ObPAd2ZEKxE',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateToInterviewScreen(BuildContext context) async {
    var status = await Permission.camera.request();
    var micStatus = await Permission.microphone.request();

    if (status.isGranted && micStatus.isGranted) {
      try {
        final cameras = await availableCameras();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InterviewScreen(cameras: cameras),
          ),
        );
      } catch (e) {
        print('Error accessing cameras: $e');
      }
    } else {
      print("Camera or Microphone permission denied.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: () => _navigateToInterviewScreen(context),
              child: const Text('Go to Interview Screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
