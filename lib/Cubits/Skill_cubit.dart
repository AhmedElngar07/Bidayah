import 'package:bidayah/Services/firebase_Services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'skill_state.dart';

class SkillCubit extends Cubit<SkillState> {
  final FirebaseService _firebaseService;

  SkillCubit(this._firebaseService) : super(SkillInitial()) {
    _loadSkills();
  }

  /// Load skills from Firestore
  Future<void> _loadSkills() async {
    emit(SkillLoading());
    try {
      final skills = await _firebaseService.fetchSkills();
      emit(SkillsLoaded(skills: skills));
    } catch (e) {
      emit(SkillError(message: 'Failed to load skills: $e'));
    }
  }

  /// Select a skill and fetch roadmap fields
  void selectSkill(String skill) async {
    if (state is SkillsLoaded || state is SkillSelected) {
      List<String> currentSkills = [];

      if (state is SkillsLoaded) {
        currentSkills = (state as SkillsLoaded).skills;
      } else if (state is SkillSelected) {
        currentSkills = (state as SkillSelected).skills;
      }

      emit(SkillLoading());

      try {
        final roadMapFields = await _firebaseService.fetchRoadMapFields(skill);
        emit(
          SkillSelected(
            skills: currentSkills,
            selectedSkill: skill,
            roadMapFields: roadMapFields,
            selectedRoadMapField: null,
            selectedSubSkills: [],
            selectedRelatedSkills: [],
            selectedLearningStyle: null,
          ),
        );
      } catch (e) {
        emit(SkillError(message: 'Failed to load RoadMapFields: $e'));
      }
    }
  }

  /// ✅Select a roadmap field and fetch sub-skills
  void selectRoadMapField(String roadMapField) async {
    if (state is SkillSelected) {
      final currentState = state as SkillSelected;
      emit(SkillLoading());

      try {
        final subSkills = await _firebaseService.fetchSubSkills(
          currentState.selectedSkill,
          roadMapField,
        );

        emit(
          SkillSelected(
            skills: currentState.skills,
            selectedSkill: currentState.selectedSkill,
            roadMapFields: currentState.roadMapFields,
            selectedRoadMapField: roadMapField,
            selectedSubSkills: subSkills,
            selectedRelatedSkills: [],
            selectedLearningStyle: null,
          ),
        );
      } catch (e) {
        emit(SkillError(message: 'Failed to load sub-skills: $e'));
      }
    }
  }

  /// ✅ **Toggle selection of a related skill (sub-skill)**
  void toggleRelatedSkill(String subSkill) {
    if (state is SkillSelected) {
      final currentState = state as SkillSelected;
      List<String> updatedRelatedSkills = List.from(
        currentState.selectedRelatedSkills,
      );

      if (updatedRelatedSkills.contains(subSkill)) {
        updatedRelatedSkills.remove(subSkill);
      } else {
        updatedRelatedSkills.add(subSkill);
      }

      emit(
        SkillSelected(
          skills: currentState.skills,
          selectedSkill: currentState.selectedSkill,
          roadMapFields: currentState.roadMapFields,
          selectedRoadMapField: currentState.selectedRoadMapField,
          selectedSubSkills: currentState.selectedSubSkills,
          selectedRelatedSkills: updatedRelatedSkills,
          selectedLearningStyle:
          updatedRelatedSkills.isNotEmpty
              ? currentState.selectedLearningStyle
              : null, // Clear learning style if no sub-skills are selected
        ),
      );
    }
  }

  /// ✅ **Select a static learning style**
  void selectLearningStyle(String learningStyle) {
    if (state is SkillSelected) {
      final currentState = state as SkillSelected;
      emit(
        SkillSelected(
          skills: currentState.skills,
          selectedSkill: currentState.selectedSkill,
          roadMapFields: currentState.roadMapFields,
          selectedRoadMapField: currentState.selectedRoadMapField,
          selectedSubSkills: currentState.selectedSubSkills,
          selectedRelatedSkills: currentState.selectedRelatedSkills,
          selectedLearningStyle:
          learningStyle, // ✅ Update learning style selection
        ),
      );
    }
  }
}