import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color backgroundColor;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    
    return Container(
      // Ensure this container uses the same background color
      color: backgroundColor,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Hero(
              tag: imagePath,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 40),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color:  const Color(0xFF123161),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Text(
              subtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color:  Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}