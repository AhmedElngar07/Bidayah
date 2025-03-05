




































import 'package:bidayah/Screens/RoadMap_Screen.dart';
import 'package:bidayah/Widgets/BottomNavBar%20.dart';
import 'package:bidayah/Widgets/CustomDrawer%20.dart';
import 'package:bidayah/Widgets/Side_menu.dart';
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
      
      drawer: SideMenu(),
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/BackGround.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
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
                      child: SingleChildScrollView( // Enables Scrolling
                        child: Column(
                          children: [
                            
                            StepProgressIndicator(
                              currentStep: 5,
                              totalSteps: 10,
                              stepDescription: "Your RoadMap",
                            ),
                            const SizedBox(height: 20),

                            
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(18, 49, 97, 1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "My Roadmap",
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 239, 240, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RoadMapPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "View",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(239, 239, 240, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Information Cards
                            _buildInfoCard(
                              icon: Icons.lightbulb,
                              color: Colors.orange,
                              title: "Tips & Information",
                              subtitle:
                                  "Learn about user interface and experience design And How To Make Interview.",
                            ),
                            const SizedBox(height: 10),
                            _buildInfoCard(
                              icon: Icons.description, 
                              color: Colors.blue, 
                              title: "CV Builder",
                              subtitle: "Create and customize your professional CV with ease.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
}




