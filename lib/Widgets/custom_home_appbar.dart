import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                const SizedBox(height: 40),
                
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Hi, Yousef Yasser ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 236, 237, 237),
                              ),
                            ),
                            Text(
                              "👋",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const Text(
                          "Find Your Career Path",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          
          Positioned(
            top: 10,
            left: 10,
            child: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),

          // Absolute Positioned Top-Right Profile & Notification Icons
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {},
                ),
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage("assets/profile_image.png"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
