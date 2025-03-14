import 'package:bidayah/Styles/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.bottomNavigationKey, // ✅ Added GlobalKey
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(

      height: 65,
      color: AppColors.backgroundColor,
      backgroundColor: const Color(0xFFF0F3FA),
      buttonBackgroundColor: AppColors.PrimaryColor,
      index: currentIndex,
      items: const <Widget>[
        Icon(Icons.local_shipping, size: 30 , color: Color.fromARGB(255, 86, 84, 84),),
        Icon(Icons.add, size: 30, color: Color.fromARGB(255, 102, 101, 101),),
        Icon(Icons.home, size: 30, color: Color.fromARGB(255, 255, 255, 255),),
        Icon(Icons.store, size: 30, color: Color.fromARGB(255, 86, 84, 84),),
        Icon(Icons.person, size: 30, color: Color.fromARGB(255, 86, 84, 84),),
      ],
      onTap: (index) {
        onTap(index);
      },
    );
  }
}