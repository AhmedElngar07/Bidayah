import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;
import 'package:bidayah/Screens/profile_screen.dart'; // Import ProfileScreen

class SkillsPage extends StatefulWidget {
  final int initialTabIndex;
  final Offset? heroOffset;

  const SkillsPage({super.key, this.initialTabIndex = 0, this.heroOffset});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

// Changed from SingleTickerProviderStateMixin to TickerProviderStateMixin
// This fixes the "multiple tickers were created" error
class _SkillsPageState extends State<SkillsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<bool> _isExpanded;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );

    _isExpanded = List.generate(skillTopics.length, (index) => false);

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    );

    _animationController.forward();

    // Simulate loading time for skills data
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> skillTopics = [
    {
      "topic": "Graphic Design",
      "icon": Icons.brush,
      "color": Color(0xFF3A47D5).withOpacity(0.8),
      "progress": 0.85,
      "skills": [
        {
          "name": "Adobe Photoshop",
          "description": "Photo editing and design tool.",
          "logo": "assets/icons/photoshop.svg",
          "level": 90,
        },
        {
          "name": "Illustration",
          "description": "Creating vector-based illustrations.",
          "logo": "assets/icons/illustration.svg",
          "level": 85,
        },
        {
          "name": "Color Theory",
          "description": "Understanding color harmonies and palettes.",
          "logo": "assets/icons/color.svg",
          "level": 80,
        },
      ],
    },
    {
      "topic": "UI/UX Design",
      "icon": Icons.design_services,
      "color": Color(0xFF2962FF).withOpacity(0.8),
      "progress": 0.76,
      "skills": [
        {
          "name": "Wireframing",
          "description": "Creating layout structures for interfaces.",
          "logo": "assets/icons/wireframing.svg",
          "level": 88,
        },
        {
          "name": "Prototyping",
          "description": "Building interactive UI mockups.",
          "logo": "assets/icons/prototyping.svg",
          "level": 75,
        },
        {
          "name": "User Research",
          "description": "Gathering insights about user needs.",
          "logo": "assets/icons/research.svg",
          "level": 65,
        },
      ],
    },
    {
      "topic": "Animation",
      "icon": Icons.movie,
      "color": Color(0xFF0D47A1).withOpacity(0.8),
      "progress": 0.62,
      "skills": [
        {
          "name": "Motion Graphics",
          "description": "Creating animated visual elements.",
          "logo": "assets/icons/motion.svg",
          "level": 70,
        },
        {
          "name": "Character Animation",
          "description": "Bringing characters to life through movement.",
          "logo": "assets/icons/character.svg",
          "level": 55,
        },
      ],
    },
    {
      "topic": "3D Modeling",
      "icon": Icons.view_in_ar,
      "color": Color(0xFF1565C0).withOpacity(0.8),
      "progress": 0.45,
      "skills": [
        {
          "name": "Blender",
          "description": "Creating 3D models and animations.",
          "logo": "assets/icons/blender.svg",
          "level": 50,
        },
        {
          "name": "Texturing",
          "description": "Adding surface details to 3D models.",
          "logo": "assets/icons/texture.svg",
          "level": 40,
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> badges = [
    {
      "name": "Photoshop Master",
      "earned": true,
      "description": "Completed advanced Photoshop techniques",
      "icon": "assets/photoshop-svgrepo-com.svg",
      "color": Color(0xFF0D47A1),
      "date": "Jan 2023",
    },
    {
      "name": "Illustration Expert",
      "earned": true,
      "description": "Created 50+ professional illustrations",
      "icon": "assets/pen-writer-svgrepo-com.svg",
      "color": Color(0xFF4A148C),
      "date": "Mar 2023",
    },
    {
      "name": "UI Designer",
      "earned": true,
      "description": "Designed 10+ user interfaces",
      "icon": "assets/icons/ui.svg",
      "color": Color(0xFF1B5E20),
      "date": "May 2023",
    },
    {
      "name": "Animation Pro",
      "earned": false,
      "description": "Complete 5 animation projects",
      "icon": "assets/icons/animation.svg",
      "color": Color(0xFFE65100).withOpacity(0.5),
      "progress": 0.6,
    },
    {
      "name": "Design Thinker",
      "earned": true,
      "description": "Applied design thinking to 3+ projects",
      "icon": "assets/icons/think.svg",
      "color": Color(0xFFD32F2F),
      "date": "Aug 2023",
    },
    {
      "name": "Color Wizard",
      "earned": false,
      "description": "Master color theory techniques",
      "icon": "assets/icons/color.svg",
      "color": Color(0xFFFF6F00).withOpacity(0.5),
      "progress": 0.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 49, 97),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _animation.value.clamp(
            0.0,
            1.0,
          ), // Ensure opacity is between 0.0 and 1.0
          duration: const Duration(milliseconds: 500),
          child: const Text(
            "SKILLS & BADGES",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 1.2,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Hero(
          tag: 'back_button',
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _animateExit(context);
              },
            ),
          ),
        ),
        actions: [
          // Profile picture in the top right with navigation to profile page
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to profile page with animation
                _navigateToProfilePage();
              },
              child: Hero(
                tag: 'profile_picture',
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: const NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCvTrUGSCZo920TjHoAvWnjoTD9LD3OL26Nw&s',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - _animation.value.clamp(0.0, 1.0))),
            child: Opacity(
              opacity: _animation.value.clamp(
                0.0,
                1.0,
              ), // Ensure opacity is between 0.0 and 1.0
              child: child,
            ),
          );
        },
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child:
                    _isLoading
                        ? _buildLoadingState()
                        : TabBarView(
                          controller: _tabController,
                          children: [
                            _buildSkillsSection(),
                            _buildBadgesSection(),
                          ],
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _animateExit(BuildContext context) async {
    await _animationController.reverse();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Use CircularProgressIndicator as a fallback if Lottie animations aren't loading
          Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child:
                _tabController.index == 0
                    ? CircularProgressIndicator(
                      color: const Color(0xFF3A47D5),
                      strokeWidth: 3,
                    )
                    : CircularProgressIndicator(
                      color: const Color(0xFF2962FF),
                      strokeWidth: 3,
                    ),
          ),
          const SizedBox(height: 20),
          Text(
            _tabController.index == 0
                ? "Loading skills..."
                : "Loading badges...",
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Method to navigate to profile page
  void _navigateToProfilePage() async {
    // Animate elements out before navigation
    await _animationController.reverse();

    if (mounted) {
      // Navigate to profile page with animation
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child:
                  const ProfileScreen(), // Import this at the top of the file
            );
          },
        ),
      );
    }
  }

  /// Header section (without name, made shorter)
  Widget _buildHeader() {
    // Returning minimal sized container to lift everything up
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      height: 60, // Reduced height significantly
    );
  }

  /// Custom tab bar
  Widget _buildTabBar() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - _animation.value.clamp(0.0, 1.0))),
          child: Opacity(
            opacity: _animation.value.clamp(
              0.0,
              1.0,
            ), // Ensure opacity is between 0.0 and 1.0
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          labelColor: const Color(0xFF3A47D5),
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12, // Made smaller (was 14)
          ),
          tabs: const [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, size: 18),
                  SizedBox(width: 6),
                  Text("Skills"),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events, size: 18),
                  SizedBox(width: 6),
                  Text("Badges"),
                ],
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _isLoading = true;
            });
            Future.delayed(const Duration(milliseconds: 400), () {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            });
          },
        ),
      ),
    );
  }

  /// Skills Section with Toggle List
  // For the skills section animations
  Widget _buildSkillsSection() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: skillTopics.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final delay = index * 0.2;
            final startValue = delay;
            final endValue = 1.0;
            final currentValue =
                _animation.value < startValue
                    ? 0.0
                    : (_animation.value - startValue) / (endValue - startValue);
            final animValue = Curves.easeOutQuart.transform(
              currentValue.clamp(0.0, 1.0),
            );

            return Transform.translate(
              offset: Offset(100 * (1 - animValue), 0),
              child: Opacity(
                opacity: animValue.clamp(
                  0.0,
                  1.0,
                ), // Ensure opacity is between 0.0 and 1.0
                child: child,
              ),
            );
          },
          child: _buildSkillCard(index),
        );
      },
    );
  }

  Widget _buildSkillCard(int index) {
    final topic = skillTopics[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12), // Made smaller (was 16)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Made smaller (was 20)
        boxShadow: [
          BoxShadow(
            color: topic["color"].withOpacity(0.3),
            blurRadius: 8, // Made smaller (was 10)
            offset: const Offset(0, 3), // Made smaller (was 0, 4)
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded[index] = !_isExpanded[index];
              });
            },
            borderRadius: BorderRadius.circular(16), // Made smaller (was 20)
            child: Container(
              padding: const EdgeInsets.all(12), // Made smaller (was 16)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16,
                ), // Made smaller (was 20)
                gradient: LinearGradient(
                  colors: [topic["color"], topic["color"].withOpacity(0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8), // Made smaller (was 10)
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Made smaller (was 12)
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3, // Made smaller (was 4)
                          offset: const Offset(0, 1), // Made smaller (was 0, 2)
                        ),
                      ],
                    ),
                    child: Icon(
                      topic["icon"],
                      color: topic["color"],
                      size: 20, // Made smaller (was 24)
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      topic["topic"],
                      style: const TextStyle(
                        fontSize: 16, // Made smaller (was 18)
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6), // Made smaller (was 8)
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Made smaller (was 12)
                    ),
                    child: Icon(
                      _isExpanded[index]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 18, // Made smaller (was not specified)
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0),
            secondChild: _buildSkillDetails(topic),
            crossFadeState:
                _isExpanded[index]
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillDetails(Map<String, dynamic> topic) {
    return Container(
      padding: const EdgeInsets.all(12), // Made smaller (was 16)
      child: Column(
        children:
            topic["skills"].map<Widget>((skill) {
              return Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ), // Made smaller (was 12)
                padding: const EdgeInsets.all(10), // Made smaller (was 12)
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Made smaller (was 16)
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3, // Made smaller (was 4)
                      offset: const Offset(0, 1), // Made smaller (was 0, 2)
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6), // Made smaller (was 8)
                      decoration: BoxDecoration(
                        color: topic["color"].withOpacity(0.15),
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Made smaller (was 10)
                      ),
                      child: SvgPicture.asset(
                        skill["logo"],
                        height: 20, // Made smaller (was 24)
                        width: 20, // Made smaller (was 24)
                        colorFilter: ColorFilter.mode(
                          topic["color"],
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Made smaller (was 12)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skill["name"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14, // Made smaller (was 16)
                            ),
                          ),
                          Text(
                            skill["description"],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11, // Made smaller (was 12)
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Show skill info
                      },
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Made smaller (was 20)
                      child: Container(
                        padding: const EdgeInsets.all(
                          4,
                        ), // Made smaller (was 6)
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.info_outline,
                          color: topic["color"],
                          size: 14, // Made smaller (was 16)
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  /// Badges Section with GridView
  Widget _buildBadgesSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 25,
            left: 20,
            right: 20,
          ), // Made smaller (was top: 30)
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - _animation.value.clamp(0.0, 1.0))),
                child: Opacity(
                  opacity: _animation.value.clamp(
                    0.0,
                    1.0,
                  ), // Ensure opacity is between 0.0 and 1.0
                  child: child,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Achievements",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ), // Made smaller (was 20)
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10, // Made smaller (was 12)
                    vertical: 5, // Made smaller (was 6)
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A47D5).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(
                      15,
                    ), // Made smaller (was 20)
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3A47D5).withOpacity(0.3),
                        blurRadius: 6, // Made smaller (was 8)
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 14, // Made smaller (was 16)
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${badges.where((b) => b["earned"] == true).length}/${badges.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12, // Made smaller
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15), // Made smaller (was 20)
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12, // Made smaller (was 15)
              mainAxisSpacing: 12, // Made smaller (was 15)
              childAspectRatio: 0.8,
            ),
            itemCount: badges.length,
            itemBuilder: (context, index) {
              final badge = badges[index];

              return AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final delay = 0.2 + (index * 0.1);
                  final startValue = delay;
                  final endValue = 1.0;
                  final currentValue =
                      _animation.value < startValue
                          ? 0.0
                          : (_animation.value - startValue) /
                              (endValue - startValue);
                  final animValue = Curves.easeOutQuart.transform(
                    currentValue.clamp(0.0, 1.0),
                  );

                  return Transform(
                    transform:
                        Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(math.pi * (1 - animValue)),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: animValue.clamp(
                        0.0,
                        1.0,
                      ), // Ensure opacity is between 0.0 and 1.0
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    if (badge["earned"]) {
                      _showBadgeDetails(badge);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Made smaller (was 20)
                      boxShadow: [
                        BoxShadow(
                          color:
                              badge["earned"]
                                  ? badge["color"].withOpacity(0.3)
                                  : Colors.grey.withOpacity(0.2),
                          blurRadius: 8, // Made smaller (was 10)
                          offset: const Offset(0, 3), // Made smaller (was 0, 4)
                        ),
                      ],
                      border:
                          badge["earned"]
                              ? Border.all(color: badge["color"], width: 2)
                              : Border.all(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                14,
                              ), // Made smaller (was 16)
                              decoration: BoxDecoration(
                                color:
                                    badge["earned"]
                                        ? badge["color"].withOpacity(0.1)
                                        : Colors.grey.shade100,
                                shape: BoxShape.circle,
                                boxShadow:
                                    badge["earned"]
                                        ? [
                                          BoxShadow(
                                            color: badge["color"].withOpacity(
                                              0.2,
                                            ),
                                            blurRadius:
                                                6, // Made smaller (was 8)
                                            spreadRadius: 1,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                        : null,
                              ),
                              child: SvgPicture.asset(
                                badge["icon"],
                                height: 36, // Made smaller (was 40)
                                width: 36, // Made smaller (was 40)
                                colorFilter: ColorFilter.mode(
                                  badge["earned"]
                                      ? badge["color"]
                                      : Colors.grey.shade400,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            if (badge["earned"])
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(
                                    3,
                                  ), // Made smaller (was 4)
                                  decoration: BoxDecoration(
                                    color: badge["color"],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: badge["color"].withOpacity(0.3),
                                        blurRadius: 3, // Made smaller (was 4)
                                        spreadRadius: 0,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12, // Made smaller (was 14)
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8), // Made smaller (was 10)
                        Text(
                          badge["name"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                badge["earned"]
                                    ? Colors.black
                                    : Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 13, // Made smaller (was 14)
                          ),
                        ),
                        const SizedBox(height: 3), // Made smaller (was 4)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            badge["description"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 9, // Made smaller (was 10)
                            ),
                          ),
                        ),
                        if (badge["earned"])
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 6,
                            ), // Made smaller (was 8)
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6, // Made smaller (was 8)
                                vertical: 2, // Made smaller (was 3)
                              ),
                              decoration: BoxDecoration(
                                color: badge["color"].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // Made smaller (was 10)
                              ),
                              child: Text(
                                "Earned: ${badge["date"]}",
                                style: TextStyle(
                                  color: badge["color"],
                                  fontSize: 9, // Made smaller (was 10)
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showBadgeDetails(Map<String, dynamic> badge) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Badge icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: badge["color"].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      badge["icon"],
                      height: 60,
                      width: 60,
                      colorFilter: ColorFilter.mode(
                        badge["color"],
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Badge title
                  Text(
                    badge["name"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),

                  // Badge description
                  Text(
                    badge["description"],
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),

                  // Earned date
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: badge["color"].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: badge["color"],
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Earned: ${badge["date"]}",
                          style: TextStyle(
                            color: badge["color"],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Close button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: badge["color"],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Close",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
