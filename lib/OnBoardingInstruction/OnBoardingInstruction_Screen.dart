import 'package:bidayah/OnBoardingInstruction/PageView_Widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingInstructionScreen extends StatefulWidget {
  const OnBoardingInstructionScreen({super.key});

  @override
  State<OnBoardingInstructionScreen> createState() =>
      _OnBoardingInstructionScreenState();
}

class _OnBoardingInstructionScreenState
    extends State<OnBoardingInstructionScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // PageView for onboarding pages
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  onLastPage = (index == 4);
                });
              },
              children: const [
                Timing_Page(),
                OptimalEnvironment_Page(),
                ClearAudio_Page(),
                FacePage(),
                ProperLighting_Page(),
                 // Last Page
              ],
            ),

            // ✅ Dots Indicator, Navigation Buttons & "Start the interview" Button
            Align(
              alignment: const Alignment(0, 0.85), // Positioned near the bottom
              child: Column(
                mainAxisSize: MainAxisSize.min, // Avoids extra spacing
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Back Button (Hidden on First Page)
                      if (currentPage > 0)
                    GestureDetector(
                      onTap: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back, color:Color.fromARGB(255, 120, 121, 122)), // Back icon
                          const SizedBox(width: 5), // Spacing between icon and text
                          const Text(
                            "Previous",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 120, 121, 122),
                            ),
                          ),
                        ],
                      ),
                    )

                      else
                        const SizedBox(width: 60), // Keeps alignment

                      // Dots Indicator (Centered)
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 5,
                        // effect: const WormEffect(
                        //   dotHeight: 10,
                        //   dotWidth: 10,
                        //   activeDotColor: Colors.blue,
                        // ),
                      ),

                      // Next / Done Button
                      GestureDetector(
                        onTap: () {
                          if (onLastPage) {
                            // Navigate to another screen
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                child: onLastPage
                    ? const SizedBox() // Hide text on the last page
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 18, 49, 97),
                            ),
                          ),
                          const SizedBox(width: 5), // Space between text and icon
                          const Icon(Icons.arrow_forward, color: const Color.fromARGB(255, 18, 49, 97)), // Forward icon
                        ],
                      ),
              ),

                    ],
                  ),

                  // Spacing between buttons and "Start the interview"
                  const SizedBox(height: 30), 

                  //  "Start the interview" Button (Only on last page)

                  if (onLastPage)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF123161),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Start the interview',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
