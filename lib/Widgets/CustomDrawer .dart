import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      backgroundColor: const Color(0xFF17203A), // ✅ Custom background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 48, bottom: 32),
            child: Text(
              "Bidayah",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.95),
                letterSpacing: 0.5,
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(Icons.home_rounded, "Home", context),
                _buildMenuItem(Icons.explore_rounded, "Browse", context),
                _buildMenuItem(Icons.video_library_rounded, "Courses", context),
                _buildMenuItem(Icons.history_rounded, "History", context),
                _buildMenuItem(Icons.favorite_rounded, "Favorites", context),
                _buildMenuItem(Icons.help_rounded, "Help", context),
                _buildMenuItem(
                  Icons.translate_rounded,
                  "Language",
                  context,
                  trailing: Icons.lock_outline_rounded,
                ),
              ],
            ),
          ),

          // Footer Section
          Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
            child: _buildMenuItem(
              Icons.logout_rounded,
              "Logout",
              context,
              iconColor: Colors.red.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context,
      {Color iconColor = Colors.white, IconData? trailing}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context); // ✅ Close drawer when item is clicked
        },
        splashColor: Colors.white.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (trailing != null)
                Icon(trailing, color: Colors.white.withOpacity(0.6), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
