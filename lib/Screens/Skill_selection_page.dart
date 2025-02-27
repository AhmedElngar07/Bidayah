import 'package:bidayah/Cubits/Skill_cubit.dart';
import 'package:bidayah/Cubits/skill_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SkillSelectionPage extends StatelessWidget {
  const SkillSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // 🔹 Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      'Customize your RoadMap',
                      style: TextStyle(
                        color: Color(0xFF4F3C75),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const SkillSelectionWidget(), // 🔹 Skill selection widget
                  const SizedBox(height: 20),

                  const Expanded(child: SkillDetailsWidget()), // 🔹 Related skills & learning style
                ],
              ),
            ),

            // 🔹 Button at the bottom of the page (Enabled when learning style is selected)
            Positioned(
              left: 16,
              right: 16,
              bottom: 32,
              child: BlocBuilder<SkillCubit, SkillState>(
                builder: (context, state) {
                  bool isEnabled = state is SkillSelected && state.selectedLearningStyle != null;

                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: isEnabled
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const VisitorPage()),
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEnabled ? Colors.black : Colors.grey[600],
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Customize your RoadMap',
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
      ),
    );
  }
}

/// 🔹 Widget for Skill Selection
class SkillSelectionWidget extends StatelessWidget {
  const SkillSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: "Select a Field",
      child: BlocBuilder<SkillCubit, SkillState>(
        builder: (context, state) {
          return Wrap(
            spacing: 15,
            runSpacing: 10,
            children: ['Programming', 'Design', 'Marketing'].map((skill) {
              return SkillButton(
                text: skill,
                isSelected: state is SkillSelected && state.skill == skill,
                onTap: () => context.read<SkillCubit>().selectSkill(skill),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

/// 🔹 Widget for Related Skills & Learning Style Selection
class SkillDetailsWidget extends StatelessWidget {
  const SkillDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillCubit, SkillState>(
      builder: (context, state) {
        if (state is SkillSelected) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Related Skills
                CustomContainer(
                  title: "Related Skills for ${state.skill}",
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: state.relatedSkills.map((subSkill) {
                      return SkillButton(
                        text: subSkill,
                        isSelected: state.selectedRelatedSkills.contains(subSkill),
                        onTap: () => context.read<SkillCubit>().toggleRelatedSkill(subSkill),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // Learning Style Selection (Only show if a related skill is selected)
                if (state.selectedRelatedSkills.isNotEmpty)
                  CustomContainer(
                    title: "Choose a Learning Style",
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: ['Reading', 'Video', 'Audio'].map((learningStyle) {
                        return SkillButton(
                          text: learningStyle,
                          isSelected: state.selectedLearningStyle == learningStyle,
                          onTap: () => context.read<SkillCubit>().selectLearningStyle(learningStyle),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

/// 🔹 Reusable Container Widget
class CustomContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9F23).withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Color(0xFF4F3C75),
                fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// 🔹 Reusable Skill Button Widget
class SkillButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillButton({super.key, required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFFB87770) : Colors.white.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

/// 🔹 Visitor Page (Next Page)
class VisitorPage extends StatelessWidget {
  const VisitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visitor Page")),
      body: const Center(child: Text("Welcome, Visitor!")),
    );
  }
}