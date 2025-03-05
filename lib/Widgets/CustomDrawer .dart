import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50, bottom: 20),
            child: Text(
              "Bidayah",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Drawer Menu Items
          _buildDrawerItem(Icons.settings, "Settings"),
          _buildDrawerItem(Icons.lock, "Privacy & Security"),
          _buildDrawerItem(Icons.help, "Help & Support"),
          _buildDrawerItem(Icons.info, "About App"),
          _buildDrawerItem(Icons.language, "Language", trailing: Icons.lock_outline,),

          Spacer(), 

          // Logout Button
          _buildDrawerItem(Icons.logout_rounded, "Logout", iconColor: Colors.red),
        ],
      ),
    );
  }

  /// Reusable Drawer Item
  Widget _buildDrawerItem(IconData icon, String title, {IconData? trailing, Color iconColor = Colors.black54}) {
    return ListTile(
      leading: Icon(icon, color: iconColor), 
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: trailing != null ? Icon(trailing, color: const Color.fromARGB(137, 125, 118, 118)) : null,
      onTap: () {
        
      },
    );
  }
}
