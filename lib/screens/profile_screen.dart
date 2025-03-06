import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bidayah/Screens/skills_screen.dart'; // Import SkillsPage

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF3A47D5), Color(0xFF000000)],
          ),
        ),
        child: Stack(
          children: [
            // White Curved Section
            Positioned(
              top: screenHeight * 0.18,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.82,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      const Text(
                        'Mahinour Ashraf',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Graphic Designer - Level: Expert',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),

                      // Pressable Container for Skills
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SkillsPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 6.0,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildSkillBadge('Adobe Photoshop'),
                              _buildSkillBadge('UI/UX Design'),
                              _buildSkillBadge('Illustration'),
                              _buildSkillBadge('Branding'),
                              _buildSkillBadge('Motion Graphics'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Profile Options Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          shrinkWrap: true,
                          childAspectRatio: 2.5,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildProfileButton('Roadmap'),
                            _buildProfileButton('CV Builder'),
                            _buildProfileButton('Purchased Items'),
                            _buildProfileButton('History Chats'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Profile Picture with Badge Icon
            Positioned(
              top: screenHeight * 0.10,
              left: screenWidth * 0.5 - 70,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          _image != null
                              ? FileImage(_image!) as ImageProvider
                              : const NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCvTrUGSCZo920TjHoAvWnjoTD9LD3OL26Nw&s',
                              ),
                    ),
                  ),

                  // Badge Icon at Bottom Right
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const SkillsPage(
                                  initialTabIndex: 1,
                                ), // Open Badges Tab
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.emoji_events, // Badge Icon
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Settings Icon
            Positioned(
              top: 50,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.settings, size: 30, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Button
  Widget _buildProfileButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3A47D5),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Skill Badge
  Widget _buildSkillBadge(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
