import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SkillsPage extends StatefulWidget {
  final int initialTabIndex;

  const SkillsPage({super.key, this.initialTabIndex = 0});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

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
    List<Map<String, String>> skills = [
      {"name": "Adobe Photoshop", "description": "Photo editing software."},
      {
        "name": "UI/UX Design",
        "description": "Designing user-friendly interfaces.",
      },
      {
        "name": "Illustration",
        "description": "Creating digital illustrations.",
      },
      {"name": "Branding", "description": "Developing brand identity."},
      {"name": "Motion Graphics", "description": "Animating graphics."},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        return Tooltip(
          message: skills[index]["description"]!,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(color: Colors.white, fontSize: 14),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                skills[index]["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadgesSection() {
    List<Map<String, dynamic>> badges = [
      {
        "name": "Photoshop Mastery",
        "earned": true,
        "icon": FontAwesomeIcons.brush,
        "color": Colors.blueAccent,
      },
      {
        "name": "Advanced Illustrator",
        "earned": true,
        "icon": LineAwesomeIcons.draw_polygon,
        "color": Colors.orange,
      },
      {
        "name": "Typography Expert",
        "earned": false,
        "icon": FontAwesomeIcons.font,
        "color": Colors.grey,
      },
      {
        "name": "Logo Design Pro",
        "earned": true,
        "icon": FontAwesomeIcons.shapes,
        "color": Colors.purple,
      },
      {
        "name": "Motion Graphics Specialist",
        "earned": false,
        "icon": FontAwesomeIcons.video,
        "color": Colors.grey,
      },
      {
        "name": "UI/UX Innovator",
        "earned": true,
        "icon": FontAwesomeIcons.pencilRuler,
        "color": Colors.green,
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 30), // Moves the first row down
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
              FaIcon(
                badges[index]["icon"],
                color:
                    badges[index]["earned"]
                        ? badges[index]["color"]
                        : Colors.black45,
                size: 40,
              ),
              const SizedBox(height: 5),
              Text(
                badges[index]["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      badges[index]["earned"]
                          ? badges[index]["color"]
                          : Colors.black45,
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
