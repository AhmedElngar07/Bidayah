import 'package:bidayah/OnBoardingInstruction/Onboarding_Widgets.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  
  const OnboardingScreen({Key? key, required this.onComplete}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  double _progress = 0.0;
  int _currentPage = 0;
  final int _totalPages = 4; // Updated to 4 slides
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Define the consistent background color
  final Color backgroundColor = const Color(0xFFF0F8FF);

  final List<OnboardingData> onboardingData = [
    OnboardingData(
      title: 'Timing of the Interview',
      subtitle: 'It may take estimating 2 minutes',
      imagePath: 'assets/Timing.png',
    ),
    OnboardingData(
      title: 'Optimal Environment',
      subtitle: 'you must be in a quiet place and well-lit environment.',
      imagePath: 'assets/Listening.png',
    ),
    OnboardingData(
      title: 'Face Positioning',
      subtitle: 'Position your face clearly within the camera frame for facial analysis and Dont Cover your Face (no hats or sunglasses) .',
      imagePath: 'assets/Face.png',
    ),
    OnboardingData(
      title: 'Get Started',
      subtitle: 'You are now ready to take the interview. Click the button below to begin!',
      imagePath: 'assets/GetStarted.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Set up page controller listener
    _pageController.addListener(_updateProgress);
    
    // Set up animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.removeListener(_updateProgress);
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _updateProgress() {
    final page = _pageController.page ?? 0;
    setState(() {
      _progress = page / (_totalPages - 1);
      _currentPage = page.round();
    });
  }

  void _nextPage() {
    if (_currentPage == _totalPages - 1) {
      widget.onComplete();
    } else {
      _animationController.reverse().then((_) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _animationController.forward();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      // Apply the background color to the entire scaffold
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [

            // Main content
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _totalPages,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: OnboardingPage(
                          title: onboardingData[index].title,
                          subtitle: onboardingData[index].subtitle,
                          imagePath: onboardingData[index].imagePath,
                          backgroundColor: backgroundColor,
                        ),
                      );
                    },
                  ),
                ),
                
                // Progress indicator and dots
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: [
                      // Page indicator dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _totalPages,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 8,
                            width: _currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index 
                                ? const Color(0xFF123161) 
                                : Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Next button with progress indicator
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: _progress,
                              strokeWidth: 6,
                              backgroundColor: Colors.grey.withOpacity(0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _currentPage == _totalPages - 1 
                                  ? Colors.green // Green for the last page
                                  : const Color.fromARGB(255, 0, 94, 255),
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == _totalPages - 1 
                                ? Colors.green // Green for the last page
                                : const Color(0xFF123161),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: _nextPage,
                              icon: Icon(
                                _currentPage == _totalPages - 1 
                                  ? Icons.check 
                                  : Icons.arrow_forward,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.zero,
                              splashRadius: 24,
                            ),
                          ),
                        ],
                      ),
                      // Get Started text for the last slide
                      if (_currentPage == _totalPages - 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Get Started",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

