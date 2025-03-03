import 'package:bidayah/Widgets/BottomNavBar%20.dart';
import 'package:bidayah/Widgets/Step_Progress.dart';
import 'package:bidayah/Widgets/custom_home_appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/BackGround.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            children: [
              
              CustomAppBar(),

              
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 0.5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Step progress indicator at the top
                        StepProgressIndicator(
                          currentStep: 2,
                          totalSteps: 6,
                          stepDescription: "Overview of UI/UX",
                        ),
                        const SizedBox(height: 20),

                        // Information Cards
                        _buildInfoCard(
                          icon: Icons.lightbulb,
                          color: Colors.orange,
                          title: "Tips & Information",
                          subtitle: "Learn about user interface and experience design And How To Make InterView.",
                        ),
                        _buildInfoCard(
                          icon: Icons.lightbulb,
                          color: Colors.orange,
                          title: "Tips & Information",
                          subtitle: "Learn about user interface and experience design And How To Make InterView.",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Card Widget (Icon-Based)**
  Widget _buildInfoCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Card Widget (Image-Based)**
  Widget _buildInfoCardWithImage({
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(imagePath, width: 50, height: 50),
        ],
      ),
    );
  }
}
