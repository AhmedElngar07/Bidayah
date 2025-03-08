import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiverMenuBtn extends StatefulWidget {
  // final VoidCallback onPress;

  const RiverMenuBtn({
    super.key,
    //  required this.onPress
  });

  @override
  _RiverMenuBtnState createState() => _RiverMenuBtnState();
}

class _RiverMenuBtnState extends State<RiverMenuBtn>
    with TickerProviderStateMixin {
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
    // Initialize Animation Controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );

    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
    super.initState();
  }

  // Rive Animation Initialization
  void _onMenuIconInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine",
    );
    artboard.addController(controller!);
    _menuBtn = controller.findInput<bool>("isOpen") as SMIBool;
    _menuBtn.value = true;

    // if (controller != null) {
    //   artboard.addController(controller);
    //   _menuBtn = controller.findInput<bool>("isOpen") as SMIBool;
    //   _menuBtn.value = false;
    // }
  }

  // Toggle Menu Function
  void onMenuPress() {
    _menuBtn.value = !_menuBtn.value;
    // _animationController.isCompleted
    //     ? _animationController.reverse()
    //     : _animationController.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMenuPress,
      child: Container(
        padding: const EdgeInsets.all(8),

        child: SizedBox(
          width: 44,
          height: 44,
          child: RiveAnimation.asset(
            'assets/menu_button.riv',
            stateMachines: const ["State Machine"],
            animations: ["open", "close"],
            onInit: _onMenuIconInit,
          ),
        ),
      ),
    );
  }
}
