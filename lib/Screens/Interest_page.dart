import 'package:flutter/material.dart';

class InterestPage extends StatelessWidget {
  const InterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> interests = [
      'Information System', 'Networking', 'Marketing', 'Accounting', 'Finance', 'Human Resource',
    ];

    final ValueNotifier<String?> selectedInterest = ValueNotifier(null);

    return Scaffold(
      body: Stack(
        children: [
          // Background Container
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1D2522), 
                  Color.fromARGB(255, 52, 69, 63), 
                  Color.fromARGB(255, 55, 93, 80), 
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Choose your interests',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Minimum one option',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70, 
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1), 
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                        ),

                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 25.0,
                            runSpacing: 30.0,
                            children: interests.map((interest) {
                              return ValueListenableBuilder<String?>(
                                valueListenable: selectedInterest,
                                builder: (context, selected, child) {
                                  final isSelected = selected == interest;
                                  return ChoiceChip(
                                    label: Text(
                                      interest,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (bool selected) {
                                      selectedInterest.value = selected ? interest : null;
                                    },
                                    selectedColor: const Color(0xFF355E49), 
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Colors.white.withOpacity(0.5)),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Button Positioned at the Bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: 32, 
            child: ValueListenableBuilder<String?>(
              valueListenable: selectedInterest,
              builder: (context, selected, child) {
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: selected == null ? null : () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selected == null ? Colors.grey[600] : Colors.black,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
