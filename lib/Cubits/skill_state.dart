abstract class SkillState {}

class SkillInitial extends SkillState {}

class SkillSelected extends SkillState {
  final String skill;
  final List<String> relatedSkills;
  final Set<String> selectedRelatedSkills;
  final String? selectedLearningStyle; // 🔹 New field for learning style

  SkillSelected({
    required this.skill,
    required this.relatedSkills,
    required this.selectedRelatedSkills,
    this.selectedLearningStyle, // 🔹 Nullable, since user may not have selected yet
  });

  SkillSelected copyWith({
    String? skill,
    List<String>? relatedSkills,
    Set<String>? selectedRelatedSkills,
    String? selectedLearningStyle,
  }) {
    return SkillSelected(
      skill: skill ?? this.skill,
      relatedSkills: relatedSkills ?? this.relatedSkills,
      selectedRelatedSkills: selectedRelatedSkills ?? this.selectedRelatedSkills,
      selectedLearningStyle: selectedLearningStyle ?? this.selectedLearningStyle,
    );
  }
}