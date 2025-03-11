import 'package:flutter/material.dart';

class PageItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final String subtitle;

  const PageItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 18, 49, 97),
              ),
            ),
            const SizedBox(height: 40),

            // Centered Image
            Center(
              child: Image.asset(
                imagePath,
                width: 375,
                height: 375,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 45),

            // Subtitle positioned at the bottom
            Align(
              alignment: Alignment.center,
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                ),
              ),
            ),
            // const SizedBox(height: 20), // Space between subtitle and Row

            // Warning message with icon
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       "Don't Cover Your Face (no hats or sunglasses)",
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //     const SizedBox(width: 8), // Adds spacing between text and icon
            //     const Icon(
            //       Icons.warning,
            //       size: 50,
            //       color: Color.fromARGB(255, 255, 128, 0),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}



class OptimalEnvironment_Page extends StatelessWidget {
  const OptimalEnvironment_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return PageItem(
      imagePath: 'assets/Quite Placeee.png',
      title: 'You must be in a quiet place and well-lit environment',
      subtitle: '',
    );
  }
}



class ClearAudio_Page extends StatelessWidget {
  const ClearAudio_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return PageItem(
      imagePath: 'assets/listening.png',
      title: 'Use headphones with a microphone for better sound clarity',
      subtitle: "",
    );
  }
}






class FacePage extends StatelessWidget {
  const FacePage({super.key});
  @override
  Widget build(BuildContext context) {
    return PageItem(
          title: 'Position your face clearly within the camera frame for facial analysis',
          imagePath: 'assets/listening.png',
          subtitle: '',
        );

      
    
  }
}






// class Speech_Page extends StatelessWidget {
//   const Speech_Page({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PageItem(
//       imagePath: 'assets/Optimal Environment.png',
//       title: 'Clear Speech',
//       subtitle: 'Speak clearly and at a moderate pace',
//     );
//   }
// }




class ProperLighting_Page extends StatelessWidget {
  const ProperLighting_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return PageItem(
      imagePath: 'assets/Light.jpg',
      title: 'Make Sure you are Sit with good lighting for accurate results',
      subtitle: ' ',
    );
  }
}


class Timing_Page extends StatelessWidget {
  const Timing_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return PageItem(
      title: 'The interview Take 4 - 7 Minutes',
      imagePath: 'assets/InterviewTime.png',
      subtitle: ' ',
    );
    




  }
}