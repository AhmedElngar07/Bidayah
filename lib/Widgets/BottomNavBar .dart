import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: const Color(0xFFF0F3FA),
      backgroundColor: const Color(0xFFF0F3FA),
      buttonBackgroundColor: const Color(0xFF8AAEE0).withOpacity(0.7),
      index: currentIndex,
      items: const <Widget>[
        Icon(Icons.local_shipping, size: 30 , color: Color.fromARGB(255, 86, 84, 84),),
        Icon(Icons.add, size: 30, color: Color.fromARGB(255, 86, 84, 84),),
        Icon(Icons.home, size: 30, color: Color.fromARGB(255, 86, 84, 84),),
        Icon(Icons.store, size: 30, color: Color.fromARGB(255, 86, 84, 84),),
        Icon(Icons.person, size: 30, color: Color.fromARGB(255, 86, 84, 84),),
      ],
      onTap: onTap,
    );
  }
}