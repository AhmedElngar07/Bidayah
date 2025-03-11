abstract class SkillState {}

class SkillInitial extends SkillState {}

class SkillLoading extends SkillState {}

class SkillsLoaded extends SkillState {
  final List<String> skills;
  SkillsLoaded({required this.skills});
}

class SkillSelected extends SkillState {
  final List<String> skills;
  final String selectedSkill;
  final List<String> roadMapFields;
  final String? selectedRoadMapField;
  final List<String> selectedSubSkills;
  final List<String> selectedRelatedSkills;
  final String? selectedLearningStyle;

  SkillSelected({
    required this.skills,
    required this.selectedSkill,
    required this.roadMapFields,
    this.selectedRoadMapField,
    required this.selectedSubSkills,
    required this.selectedRelatedSkills,
    this.selectedLearningStyle,
  });
}

class SkillError extends SkillState {
  final String message;
  SkillError({required this.message});
}