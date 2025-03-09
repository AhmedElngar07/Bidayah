import 'dart:math' as match;
import 'package:bidayah/Widgets/Home_view.dart';
import 'package:bidayah/Widgets/Side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController? _animationController;

  late Animation<double> _sidebarAnim;

  late SMIBool _menuBtn;

  final SpringDescription _springDesc = const SpringDescription(
    mass: 0.1,
    stiffness: 40,
    damping: 5,
  );

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );

    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );
    super.initState();
  }

  void _onMenuIconInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine",
    );

    if (controller != null) {
      artboard.addController(controller);
      _menuBtn = controller.findInput<bool>("isOpen") as SMIBool;
      _menuBtn.value = true;
    }
  }

  void onMenuPress() {
    if (_menuBtn.value) {
      final springAnim = SpringSimulation(_springDesc, 0, 1, 0);
      _animationController?.animateWith(springAnim);
    } else {
      _animationController?.reverse();
    }
    _menuBtn.change(!_menuBtn.value);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
