import 'package:bidayah/Screens/RoadMap_Screen.dart';
import 'package:bidayah/Screens/Skill_selection_page.dart';
import 'package:bidayah/Widgets/BottomNavBar%20.dart';
import 'package:bidayah/Widgets/BuildIntoCard.dart';
import 'package:bidayah/Widgets/Step_Progress.dart';
import 'package:bidayah/Widgets/custom_home_appbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    SkillSelectionPage(),
    RoadMapPage(),
    const HomeView(), // Home View
    // Add other pages here
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
),
        ),
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StepProgressIndicator(
                      currentStep: 5,
                      totalSteps: 10,
                      stepDescription: "Your RoadMap",
                    ),
                    const SizedBox(height: 20),
                    _buildRoadmapCard(context),
                    const SizedBox(height: 30),
                    buildInfoCard(
                      icon: Icons.lightbulb,
                      color: Colors.orange,
                      title: "Tips & Information",
                      subtitle: "Learn about UI/UX design and interview techniques.",
                    ),
                    const SizedBox(height: 10),
                    buildInfoCard(
                      icon: Icons.description,
                      color: Colors.blue,
                      title: "CV Builder",
                      subtitle: "Create and customize your professional CV with ease.",
                    ),
                  ],
                ),
              ),
            ),
          ],
            




        ),
      ),

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        bottomNavigationKey: _bottomNavigationKey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // ✅ Navigate to the selected screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _screens[index],
            ),
          );
        },
      ),
    );
  }
}

// ✅ Reusable Roadmap Card
Widget _buildRoadmapCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(18, 49, 97, 1),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          spreadRadius: 2,
          offset: const Offset(0, 4),
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
              MaterialPageRoute(builder: (context) => RoadMapPage()),
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
  );
}



