import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue[700]),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get the available dimensions
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          
          // Calculate responsive sizes
          final cloudTextSize = maxWidth > 600 ? 24.0 : 20.0;
          
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(
                'assets/Image 2025.jpg',
                fit: BoxFit.cover,
              ),
              
              // Cloud text overlay - positioned lower
              Positioned(
                bottom: maxHeight * 0.15, // Positioned lower
                left: maxWidth * 0.01,
                width: maxWidth * 0.5,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: maxHeight * 0.01,
                    horizontal: maxWidth * 0.01,
                  ),
                  child: Text(
                    "Tailor your roadmap to be the bidayah",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: cloudTextSize, // Larger text
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ),
              
              // Gradient overlay at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: maxHeight * 0.25,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // Custom floating action button instead of the Get Started button
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Placeholder(),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 18, 101, 169),
          mini: false,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Square corners with slight rounding
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bidayah App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
      // Screen-size aware builder
      builder: (context, child) {
        // Adapt to different device sizes and orientations
        final mediaQuery = MediaQuery.of(context);
        final width = mediaQuery.size.width;
        final height = mediaQuery.size.height;
        final aspectRatio = width / height;
        
        // Calculate appropriate text scale factor
        double textScaleFactor;
        if (aspectRatio < 0.5) {
          // Very tall and narrow (like folding phones)
          textScaleFactor = 0.85;
        } else if (aspectRatio < 0.7) {
          // Phone portrait
          textScaleFactor = 1.0;
        } else if (aspectRatio < 1.3) {
          // Tablet portrait or phone landscape
          textScaleFactor = 1.15;
        } else {
          // Tablet landscape or desktop
          textScaleFactor = 1.25;
        }
        
        return MediaQuery(
          data: mediaQuery.copyWith(textScaleFactor: textScaleFactor),
          child: child!,
        );
      },
    );
  }
}