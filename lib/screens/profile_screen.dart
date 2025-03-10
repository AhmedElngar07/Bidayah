import 'dart:io';
import 'package:bidayah/Widgets/BottomNavBar%20.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bidayah/Screens/skills_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  int _currentIndex = 3; // Profile is the 4th item in the BottomNavBar
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  final List<Widget> _screens = [
    Placeholder(), // Replace with actual screen widgets
    Placeholder(),
    Placeholder(),
    const ProfileScreen(),
  ];

  Future<void> _pickImage() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permission denied. Enable it in settings."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // **Background Color**
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 18, 49, 97),
          ),

          Column(
            children: [
              const SizedBox(height: 10),

              // **Settings Icon**
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),

              // **Main White Section**
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),

                        // **Profile Picture**
                        Center(
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      _image != null
                                          ? FileImage(_image!) as ImageProvider
                                          : const NetworkImage(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCvTrUGSCZo920TjHoAvWnjoTD9LD3OL26Nw&s',
                                          ),
                                ),
                              ),

                              // **Badge Icon**
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const SkillsPage(
                                              initialTabIndex: 1,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 252, 221, 48),
                                          Color.fromARGB(255, 211, 133, 17),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.emoji_events,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),
                        const Text(
                          'Mahinour Ashraf',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Graphic Designer - Level: Expert',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),

                        const SizedBox(height: 8),

                        // **Skills Badges**
                        Wrap(
                          spacing: -10,
                          runSpacing: -10,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildSkillBadge(Icons.brush, [
                              Colors.pink.shade200,
                              Colors.orange.shade200,
                            ]),
                            _buildSkillBadge(Icons.design_services, [
                              Colors.blue.shade200,
                              Colors.purple.shade200,
                            ]),
                            _buildSkillBadge(Icons.palette, [
                              Colors.green.shade200,
                              Colors.yellow.shade200,
                            ]),
                            _buildSkillBadge(Icons.business, [
                              Colors.teal.shade200,
                              Colors.blue.shade200,
                            ]),
                            _buildSkillBadge(Icons.movie, [
                              Colors.red.shade200,
                              Colors.purple.shade300,
                            ]),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // **Profile Options**
                        Column(
                          children: [
                            _buildProfileOptionButton(
                              Icons.map,
                              "Roadmap",
                              "Track your learning journey.",
                              Colors.blue.shade200,
                            ),
                            _buildProfileOptionButton(
                              Icons.description,
                              "CV Builder",
                              "Build a professional resume.",
                              Colors.orange.shade200,
                            ),
                            _buildProfileOptionButton(
                              Icons.shopping_cart,
                              "Purchased Items",
                              "View your purchased courses.",
                              Colors.green.shade200,
                            ),
                            _buildProfileOptionButton(
                              Icons.chat,
                              "History Chats",
                              "Access your past conversations.",
                              Colors.purple.shade200,
                            ),
                          ],
                        ),

                        const SizedBox(height: 40), // Extra padding
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        bottomNavigationKey: _bottomNavigationKey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index < _screens.length) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => _screens[index]),
            );
          }
        },
      ),
    );
  }

  /// **Pressable Skill Badge**
  Widget _buildSkillBadge(IconData icon, List<Color> gradientColors) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SkillsPage(initialTabIndex: 0),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  /// **Profile Option Button**
  Widget _buildProfileOptionButton(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor,
  ) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
