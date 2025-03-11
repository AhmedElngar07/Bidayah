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

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  File? _image;
  int _currentIndex = 3; // Profile is the 4th item in the BottomNavBar
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  late AnimationController _animationController;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();

  final List<Widget> _screens = [
    Placeholder(), // Replace with actual screen widgets
    Placeholder(),
    Placeholder(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for profile elements
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation when profile screen loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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

  void _navigateToSkillsPage(int initialTabIndex) async {
    // Animate elements out before navigation
    await _animationController.reverse();

    if (mounted) {
      // Get the profile picture position for hero animation starting point
      final RenderBox? box = context.findRenderObject() as RenderBox?;
      final Offset? offset = box?.localToGlobal(Offset.zero);

      // Navigate to skills page with animation
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: SkillsPage(
                initialTabIndex: initialTabIndex,
                heroOffset: offset,
              ),
            );
          },
        ),
      ).then((_) {
        // Restart animation when returning to profile
        if (mounted) {
          _animationController.forward();
        }
      });
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

          // Use a Stack instead of Column to better control positioning
          Stack(
            children: [
              // **Main White Section** - using Stack positioning instead of negative margin
              Positioned(
                left: 0,
                right: 0,
                top:
                    120, // Adjust this value to move the white section up or down
                bottom: 0,
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
                  child: Column(
                    children: [
                      // Scrollable section for profile content
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ), // Space for the bottom half of the profile picture
                              // User name with Hero tag
                              Hero(
                                tag: 'user_name',
                                child: Material(
                                  color: Colors.transparent,
                                  child: const Text(
                                    'Mahinour Ashraf',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              // User level with animation
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _animation.value,
                                    child: Transform.translate(
                                      offset: Offset(
                                        0,
                                        10 * (1 - _animation.value),
                                      ),
                                      child: child,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Graphic Designer - Level: Expert',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // **Skills Badges** with staggered animation
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _animation.value,
                                      child: Transform.translate(
                                        offset: Offset(
                                          0,
                                          20 * (1 - _animation.value),
                                        ),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Wrap(
                                    spacing: -10,
                                    runSpacing: -10,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      _buildSkillBadge(Icons.brush, [
                                        Colors.pink.shade200,
                                        Colors.orange.shade200,
                                      ], 0),
                                      _buildSkillBadge(Icons.design_services, [
                                        Colors.blue.shade200,
                                        Colors.purple.shade200,
                                      ], 0),
                                      _buildSkillBadge(Icons.palette, [
                                        Colors.green.shade200,
                                        Colors.yellow.shade200,
                                      ], 0),
                                      _buildSkillBadge(Icons.business, [
                                        Colors.teal.shade200,
                                        Colors.blue.shade200,
                                      ], 0),
                                      _buildSkillBadge(Icons.movie, [
                                        Colors.red.shade200,
                                        Colors.purple.shade300,
                                      ], 0),
                                    ],
                                  ),
                                ),
                              ),

                              // Add extra padding at bottom to allow scrolling past the fixed buttons
                              const SizedBox(height: 300),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // **Fixed Buttons Container** - invisible container
              Positioned(
                left: 30,
                right: 30,
                bottom: 5, // Changed from 20 to 5 to lower the position
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _animation.value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - _animation.value)),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0), // Removed padding
                    color: Colors.transparent, // Made container transparent
                    child: Column(
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
                  ),
                ),
              ),

              // **Settings Icon**
              Positioned(
                top: 15,
                right: 15,
                child: IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {},
                ),
              ),

              // Position profile picture in the blue section
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    children: [
                      // Profile picture with Hero tag for smooth transition
                      Hero(
                        tag: 'profile_picture',
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 0.8 + (0.2 * _animation.value),
                                child: child,
                              );
                            },
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
                        ),
                      ),

                      // **Badge Icon** with Hero tag
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Hero(
                          tag: 'badge_icon',
                          child: Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () {
                                _navigateToSkillsPage(
                                  1,
                                ); // Navigate to badges tab
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
                        ),
                      ),
                    ],
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

  /// **Pressable Skill Badge** with added index for staggered animations
  Widget _buildSkillBadge(
    IconData icon,
    List<Color> gradientColors,
    int index,
  ) {
    // Calculate a delay based on the index
    final delay = 0.15 * index;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Create a delayed animation value based on index
        final delayedAnimValue = (_animation.value - delay).clamp(0.0, 1.0);

        return Transform.scale(
          scale: 0.7 + (0.3 * delayedAnimValue),
          child: Opacity(opacity: delayedAnimValue, child: child),
        );
      },
      child: GestureDetector(
        onTap: () {
          _navigateToSkillsPage(0); // Navigate to skills tab
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
      ),
    );
  }

  /// **Profile Option Button** with hover effect
  Widget _buildProfileOptionButton(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor,
  ) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
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
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
