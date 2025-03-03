import 'package:bidayah/Cubits/Skill_cubit.dart';
import 'package:bidayah/Cubits/skill_state.dart';
import 'package:bidayah/Screens/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SkillSelectionPage extends StatelessWidget {
  const SkillSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Scrollable Content**
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Customize Your Roadmap',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// First container - Skill Selection
                    const SkillSelectionWidget(),

                    const SizedBox(height: 16),

                    /// Second container - RoadMap Fields (No Sub-Skills)
                    BlocBuilder<SkillCubit, SkillState>(
                      builder: (context, state) {
                        if (state is SkillSelected) {
                          return const SkillDetailsWidget();
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// **Button at the Bottom**
            BlocBuilder<SkillCubit, SkillState>(
              builder: (context, state) {
                bool isEnabled = state is SkillSelected && state.selectedLearningStyle != null;

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  color: Colors.white, // Optional: Add background color if needed
                  child: ElevatedButton(
                    onPressed: isEnabled
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  HomeScreen(),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEnabled
                          ? const Color.fromARGB(255, 18, 49, 97)
                          : Colors.grey[400],
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Customize your RoadMap',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.auto_fix_high, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget to display the list of skills
class SkillSelectionWidget extends StatelessWidget {
  const SkillSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillCubit, SkillState>(
      builder: (context, state) {
        if (state is SkillLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SkillError) {
          return Center(
            child: Text(state.message, style: const TextStyle(color: Colors.red)),
          );
        } else if (state is SkillsLoaded || state is SkillSelected) {
          List<String> skills = state is SkillsLoaded
              ? state.skills
              : (state as SkillSelected).skills;

          return CustomContainer(
            title: "Select a Field",
            child: Wrap(
              spacing: 15,
              runSpacing: 10,
              children: skills.map((skill) {
                return SkillButton(
                  text: skill,
                  isSelected: state is SkillSelected && state.selectedSkill == skill,
                  onTap: () => context.read<SkillCubit>().selectSkill(skill),
                );
              }).toList(),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

/// Widget to display roadmap fields & learning style (No Sub-Skills)
class SkillDetailsWidget extends StatelessWidget {
  const SkillDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillCubit, SkillState>(
      builder: (context, state) {
        if (state is SkillSelected) {
          return Column(
            children: [
              CustomContainer(
                title: "RoadMap Fields for ${state.selectedSkill}",
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: state.roadMapFields.map((field) {
                    return SkillButton(
                      text: field,
                      isSelected: state.selectedRoadMapField == field,
                      onTap: () => context.read<SkillCubit>().selectRoadMapField(field),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Learning Style Selection (Appears only after selecting a RoadMap field)
              if (state.selectedRoadMapField != null)
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
          );
        }
        return const SizedBox();
      },
    );
  }
}

/// Custom container for displaying selections
class CustomContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF8AAEE0).withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:  TextStyle(
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Custom button for selecting skills and roadmap fields
class SkillButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? const Color.fromARGB(49, 9, 68, 247)
            : const Color(0xFFF0F3FA).withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFFF0F3FA), fontSize: 16),
      ),
    );
  }
}
