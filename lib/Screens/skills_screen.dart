import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillsPage extends StatefulWidget {
  final int initialTabIndex;

  const SkillsPage({super.key, this.initialTabIndex = 0});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );

    _isExpanded = List.generate(skillTopics.length, (index) => false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> skillTopics = [
    {
      "topic": "Graphic Design",
      "icon": Icons.brush,
      "color": Color.fromARGB(255, 219, 103, 235), // Darker red
      "skills": [
        {
          "name": "Adobe Photoshop",
          "description": "Photo editing and design tool.",
          "logo": "assets/icons/photoshop.svg",
          "level": 0.9,
        },
        {
          "name": "Illustration",
          "description": "Creating vector-based illustrations.",
          "logo": "assets/icons/illustration.svg",
          "level": 0.85,
        },
        {
          "name": "Color Theory",
          "description": "Understanding color harmonies and palettes.",
          "logo": "assets/icons/color.svg",
          "level": 0.75,
        },
      ],
    },
    {
      "topic": "UI/UX Design",
      "icon": Icons.design_services,
      "color": Color.fromARGB(255, 68, 211, 216), // Darker blue
      "skills": [
        {
          "name": "Wireframing",
          "description": "Creating layout structures for interfaces.",
          "logo": "assets/icons/wireframing.svg",
          "level": 0.8,
        },
        {
          "name": "Prototyping",
          "description": "Building interactive UI mockups.",
          "logo": "assets/icons/prototyping.svg",
          "level": 0.7,
        },
        {
          "name": "User Research",
          "description": "Gathering insights about user needs.",
          "logo": "assets/icons/research.svg",
          "level": 0.65,
        },
      ],
    },
    {
      "topic": "Animation",
      "icon": Icons.movie,
      "color": Color.fromARGB(255, 117, 90, 150), // Darker purple
      "skills": [
        {
          "name": "Motion Graphics",
          "description": "Creating animated visual elements.",
          "logo": "assets/icons/motion.svg",
          "level": 0.75,
        },
        {
          "name": "Character Animation",
          "description": "Bringing characters to life through movement.",
          "logo": "assets/icons/character.svg",
          "level": 0.6,
        },
      ],
    },
    {
      "topic": "3D Modeling",
      "icon": Icons.view_in_ar,
      "color": Color.fromARGB(255, 105, 219, 113), // Darker green
      "skills": [
        {
          "name": "Blender",
          "description": "Creating 3D models and animations.",
          "logo": "assets/icons/blender.svg",
          "level": 0.7,
        },
        {
          "name": "Texturing",
          "description": "Adding surface details to 3D models.",
          "logo": "assets/icons/texture.svg",
          "level": 0.65,
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
      "color": Color(0xFF0D47A1), // Darker blue
    },
    {
      "name": "Illustration Expert",
      "earned": true,
      "description": "Created 50+ professional illustrations",
      "icon": "assets/pen-writer-svgrepo-com.svg",
      "color": Color(0xFF4A148C), // Darker purple
    },
    {
      "name": "UI Designer",
      "earned": true,
      "description": "Designed 10+ user interfaces",
      "icon": "assets/icons/ui.svg",
      "color": Color(0xFF1B5E20), // Darker green
    },
    {
      "name": "Animation Pro",
      "earned": false,
      "description": "Complete 5 animation projects",
      "icon": "assets/icons/animation.svg",
      "color": Color(0xFFE65100).withOpacity(0.5), // Darker orange
    },
    {
      "name": "Design Thinker",
      "earned": true,
      "description": "Applied design thinking to 3+ projects",
      "icon": "assets/icons/think.svg",
      "color": Color(0xFFD32F2F), // Darker red
    },
    {
      "name": "Color Wizard",
      "earned": false,
      "description": "Master color theory techniques",
      "icon": "assets/icons/color.svg",
      "color": Color(0xFFFF6F00).withOpacity(0.5), // Darker amber
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 49, 97),
      appBar: AppBar(
        title: const Text(
          "SKILLS & BADGES",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 49, 97),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
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
              child: TabBarView(
                controller: _tabController,
                children: [_buildSkillsSection(), _buildBadgesSection()],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 18, 49, 97),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// Custom header section with futuristic design
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mahinour Ashraf",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            132,
                            154,
                            180,
                          ), // Darker amber
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Level: Expert",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            132,
                            154,
                            180,
                          ), // Darker blue
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "5 Badges",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: const NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCvTrUGSCZo920TjHoAvWnjoTD9LD3OL26Nw&s',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Custom tab bar - no white underline
  Widget _buildTabBar() {
    return Container(
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
        ),
        labelColor: const Color(0xFF3A47D5),
        unselectedLabelColor: Colors.white,
        // Removed the white underline by setting indicatorSize to tab and indicatorColor to transparent
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.transparent,
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_awesome),
                SizedBox(width: 5),
                Text("Skills"),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events),
                SizedBox(width: 5),
                Text("Badges"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Skills Section with Toggle List
  Widget _buildSkillsSection() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
      itemCount: skillTopics.length,
      itemBuilder: (context, index) {
        return _buildSkillCard(index);
      },
    );
  }

  Widget _buildSkillCard(int index) {
    final topic = skillTopics[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: topic["color"].withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [topic["color"], topic["color"].withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(topic["icon"], color: topic["color"], size: 24),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      topic["topic"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _isExpanded[index]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expanded content
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
            topic["skills"].map<Widget>((skill) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: topic["color"].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            skill["logo"],
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              topic["color"],
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                skill["name"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                skill["description"],
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          color: topic["color"],
                          onPressed: () {
                            // Show skill info
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Skill progress bar
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: skill["level"],
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        topic["color"],
                                        topic["color"].withOpacity(0.7),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${(skill["level"] * 100).toInt()}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: topic["color"],
                          ),
                        ),
                      ],
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
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Achievements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A47D5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${badges.where((b) => b["earned"] == true).length}/${badges.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.9,
            ),
            itemCount: badges.length,
            itemBuilder: (context, index) {
              final badge = badges[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border:
                      badge["earned"]
                          ? Border.all(color: badge["color"], width: 2)
                          : Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                badge["earned"]
                                    ? badge["color"].withOpacity(0.1)
                                    : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            badge["icon"],
                            height: 40,
                            width: 40,
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
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: badge["color"],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      badge["name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            badge["earned"]
                                ? Colors.black
                                : Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        badge["description"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
