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
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned(child: Container(color: Color(0xFF17203A))),

          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                        ((1 - _sidebarAnim.value) * -30) * match.pi / 180,
                      )
                      ..translate((1 - _sidebarAnim.value) * -500),
                child: child,
              );
            },
            child: FadeTransition(
              opacity: _sidebarAnim,
              child: const SideMenu(),
            ),
          ),

          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (context, child) {
              return Transform.scale(
                scale: 1 - _sidebarAnim.value * 0.1,
                child: Transform.translate(
                  offset: Offset(_sidebarAnim.value * 265, 0),
                  child: Transform(
                    alignment: Alignment.center,
                    transform:
                        Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((_sidebarAnim.value * 30) * match.pi / 180),
                    child: child,
                  ),
                ),
              );
            },
            child: HomeView(),
          ),

          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (context, child) {
              return SafeArea(
                child: Row(
                  children: [SizedBox(width: _sidebarAnim.value * 216), child!],
                ),
              );
            },
            child: GestureDetector(
              onTap: onMenuPress,
              child: Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        18,
                        18,
                        18,
                      ).withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                child: RiveAnimation.asset(
                  'assets/menu_button.riv',
                  stateMachines: const ["State Machine"],
                  animations: ["open", "close"],
                  onInit: _onMenuIconInit,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
