import 'package:flutter/material.dart';

class TestText extends StatelessWidget {
  const TestText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bidayah',
          style: TextStyle(
            
            fontWeight: FontWeight.w800,
            fontSize: 40,
          ),
        ),
        centerTitle: false, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Main Text',
              style: TextStyle(
                
                fontSize: 30,
                fontWeight: FontWeight.w600, // Semi-Bold (600)
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Subtitle',
              style: TextStyle(
                  
                fontSize: 20,
                fontWeight: FontWeight.w500, // Medium (500)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
