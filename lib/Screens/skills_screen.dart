import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import SVG package

class SkillsPage extends StatefulWidget {
  final int initialTabIndex;

  const SkillsPage({super.key, this.initialTabIndex = 0});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<bool> _isExpanded; // Ensure state persists

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

  final List<Map<String, dynamic>> skillTopics = [
    {
      "topic": "Graphic Design",
      "skills": [
        {
          "name": "Adobe Photoshop",
          "description": "Photo editing and design tool.",
          "logo": "assets/icons/photoshop.svg",
        },
        {
          "name": "Illustration",
          "description": "Creating vector-based illustrations.",
          "logo": "assets/icons/illustration.svg",
        },
        {
          "name": "Branding",
          "description": "Developing a visual brand identity.",
          "logo": "assets/icons/branding.svg",
        },
      ],
    },
    {
      "topic": "UI/UX Design",
      "skills": [
        {
          "name": "Wireframing",
          "description": "Creating layout structures for interfaces.",
          "logo": "assets/icons/wireframing.svg",
        },
        {
          "name": "Prototyping",
          "description": "Building interactive UI mockups.",
          "logo": "assets/icons/prototyping.svg",
        },
        {
          "name": "Usability Testing",
          "description": "Testing interfaces for better user experience.",
          "logo": "assets/icons/usability_testing.svg",
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> badges = [
    {
      "name": "Photoshop Mastery",
      "earned": true,
      "icon": "assets/photoshop-svgrepo-com.svg",
    },
    {
      "name": "Illustration Expert",
      "earned": true,
      "icon": "assets/pen-writer-svgrepo-com.svg",
    },
    {
      "name": "Typography Guru",
      "earned": true,
      "icon": "assets/type-svgrepo-com.svg",
    },
    {
      "name": "Motion Graphics Pro",
      "earned": true,
      "icon": "assets/panel-poster-svgrepo-com.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SKILLS & BADGES",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3A47D5),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [Tab(text: "My Skills"), Tab(text: "My Badges")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildSkillsSection(), _buildBadgesSection()],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: skillTopics.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  skillTopics[index]["topic"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  _isExpanded[index]
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                onTap: () {
                  setState(() {
                    _isExpanded[index] = !_isExpanded[index];
                  });
                },
              ),
              if (_isExpanded[index])
                Column(
                  children:
                      skillTopics[index]["skills"]
                          .map<Widget>(
                            (skill) => ListTile(
                              leading: SvgPicture.asset(
                                skill["logo"],
                                height: 30,
                                width: 30,
                              ),
                              title: Text(skill["name"]),
                              subtitle: Text(skill["description"]),
                            ),
                          )
                          .toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadgesSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SvgPicture.asset(badges[index]["icon"], height: 60, width: 60),
              const SizedBox(height: 5),
              Text(
                badges[index]["name"],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
