import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      // height: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Color(0xFF17203A),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 48, bottom: 32),
            child: Text(
              "Bidayah",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w800,
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
                _buildMenuItem(Icons.home_rounded, "Home"),
                _buildMenuItem(Icons.explore_rounded, "Browse"),
                _buildMenuItem(Icons.video_library_rounded, "Courses"),
                _buildMenuItem(Icons.history_rounded, "History"),
                _buildMenuItem(Icons.favorite_rounded, "Favorites"),
                _buildMenuItem(Icons.help_rounded, "Help"),
                _buildMenuItem(Icons.translate_rounded, "Language", 
                  trailing: Icons.lock_outline_rounded),
              ],
            ),
          ),

          // Footer Section
          Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
            child: _buildMenuItem(
              Icons.logout_rounded, 
              "Logout",
              iconColor: Colors.red.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, 
      {Color iconColor = Colors.white, IconData? trailing}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
                Icon(trailing, 
                    color: Colors.white.withOpacity(0.6), 
                    size: 20),
            ],
          ),
        ),
      ),
    );
  }
}





























// import 'package:flutter/material.dart';

// class SideMenu extends StatefulWidget {
//   const SideMenu({super.key});

//   @override
//   State<SideMenu> createState() => _SideMenuState();
// }

// class _SideMenuState extends State<SideMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 288,
//       height: double.infinity,
//       color: const Color(0xFF17203A),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children:[
          
//           Padding(
//             padding: const EdgeInsets.only(left: 20, top: 50, bottom: 20),
//             child: Text(
//               "Bidayah",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: const Color.fromARGB(255, 245, 245, 245),
//               ),
//             ),
//           ),

//           // Drawer Menu Items
//           _buildDrawerItem(Icons.settings, "Settings"),
//           _buildDrawerItem(Icons.lock, "Privacy & Security"),
//           _buildDrawerItem(Icons.help, "Help & Support"),
//           _buildDrawerItem(Icons.info, "About App"),
//           _buildDrawerItem(Icons.history, "History",),
//           _buildDrawerItem(Icons.language, "Language", trailing: Icons.lock_outline,),
          

//           Spacer(), 

//           // Logout Button
//           _buildDrawerItem(Icons.logout_rounded, "Logout", iconColor: Colors.red),
//         ],
//       ),
//     );
//   }







// Widget _buildDrawerItem(IconData icon, String title, {IconData? trailing, Color iconColor = const Color.fromARGB(245, 246, 246, 246)}) {
//     return ListTile(
//       leading: Icon(icon, color: iconColor), 
//       title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//       trailing: trailing != null ? Icon(trailing, color: const Color.fromARGB(137, 125, 118, 118)) : null,
//       onTap: () {
        
//       },
//     );
//   }


// }















