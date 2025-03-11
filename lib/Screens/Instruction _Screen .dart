import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 18, 49, 97),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'How to Prepare for the Interview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 18, 49, 97),
                  ),
                ),
                const SizedBox(height: 8),
                
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 2,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(steps.length, (index) {
                        final step = steps[index];
                        return TimelineTile(
                          icon: step.icon,
                          title: step.title,
                          description: step.description,
                          isLeft: index.isEven,
                        );
                      }),
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const Icon(Icons.lightbulb, color: Color.fromARGB(255, 255, 200, 0)),
                //     const SizedBox(width: 8),
                //     Expanded(
                //       child: Text(
                //         'It may take estimating 2 minutes ⏱️ ',
                //         style: TextStyle(
                //           color: Colors.grey[600],
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 18, 49, 97),
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  
  }
}

class TimelineTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isLeft;

  const TimelineTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isLeft) ...[
          Expanded(child: _StepContent(icon: icon, title: title, description: description)),
          const SizedBox(width: 20),
          const Spacer(),
        ] else ...[
          const Spacer(),
          const SizedBox(width: 20),
          Expanded(child: _StepContent(icon: icon, title: title, description: description)),
        ],
      ],
    );
  }
}

class _StepContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _StepContent({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 50, color: Colors.blue),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}

class StepData {
  final IconData icon;
  final String title;
  final String description;

  StepData(this.icon, this.title, this.description);
}

final List<StepData> steps = [
  StepData(Icons.filter_center_focus_sharp, "Optimal Environment", "Ensure a quiet and well-lit environment."),
  StepData(Icons.headphones, "Clear Audio", "Use headphones for better sound clarity."),
  // StepData(Icons.face, "Face Positioning", "Position your face clearly within the camera frame."),
  StepData(Icons.mic, "Clear Speech", "Speak clearly and at a moderate pace."),
  StepData(Icons.lightbulb_circle, "Proper Lighting", "Sit with good lighting for accurate results."),
];
