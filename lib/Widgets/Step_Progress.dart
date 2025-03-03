import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepDescription;

  const StepProgressIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text section now on the left
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Step $currentStep", // Dynamic step number
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                stepDescription,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          
          // Circular indicator now on the right
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 6.0,
            percent: currentStep / totalSteps,
            center: Text(
              "$currentStep of $totalSteps",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            progressColor: const Color(0xFF1A5CFF),
            backgroundColor: const Color(0xFFE6F0FF),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}