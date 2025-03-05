import 'package:flutter/material.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({super.key, required this.press});

  final VoidCallback press;
  


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Positioned(
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
    );
  }
}