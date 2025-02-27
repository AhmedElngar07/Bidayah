import 'package:flutter_bloc/flutter_bloc.dart';
import 'skill_state.dart';

class SkillCubit extends Cubit<SkillState> {
  SkillCubit() : super(SkillInitial());

  void selectSkill(String skill) {
    final relatedSkills = _getRelatedSkills(skill);
    emit(SkillSelected(
      skill: skill,
      relatedSkills: relatedSkills,
      selectedRelatedSkills: {},
      selectedLearningStyle: null,
    ));
  }

  void toggleRelatedSkill(String subSkill) {
    if (state is SkillSelected) {
      final currentState = state as SkillSelected;
      final updatedSelectedSkills = Set<String>.from(currentState.selectedRelatedSkills);

      if (updatedSelectedSkills.contains(subSkill)) {
        updatedSelectedSkills.remove(subSkill);
      } else {
        updatedSelectedSkills.add(subSkill);
      }

      emit(SkillSelected(
        skill: currentState.skill,
        relatedSkills: currentState.relatedSkills,
        selectedRelatedSkills: updatedSelectedSkills,
        selectedLearningStyle: currentState.selectedLearningStyle,
      ));
    }
  }

  void selectLearningStyle(String learningStyle) {
    if (state is SkillSelected) {
      final currentState = state as SkillSelected;
      emit(SkillSelected(
        skill: currentState.skill,
        relatedSkills: currentState.relatedSkills,
        selectedRelatedSkills: currentState.selectedRelatedSkills,
        selectedLearningStyle: learningStyle,
      ));
    }
  }

  List<String> _getRelatedSkills(String skill) {
    switch (skill) {
      case 'Programming':
        return ['Python', 'Dart', 'JavaScript', 'C++'];
      case 'Design':
        return ['UI/UX', 'Graphic Design', 'Illustration', 'Typography'];
      case 'Marketing':
        return ['SEO', 'Social Media', 'Branding', 'Advertising'];
      default:
        return [];
    }
  }
}