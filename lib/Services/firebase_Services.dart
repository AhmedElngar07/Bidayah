import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch all skills from 'Skills' collection
  Future<List<String>> fetchSkills() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Skills').get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      throw Exception('Error fetching skills: $e');
    }
  }

  /// Fetch roadmap fields for a specific skill
  Future<List<String>> fetchRoadMapFields(String skill) async {
    try {
      DocumentSnapshot skillDoc =
      await _firestore.collection('Skills').doc(skill).get();

      if (!skillDoc.exists) {
        throw Exception("Skill not found.");
      }

      Map<String, dynamic>? roadMapFields =
      skillDoc.data() as Map<String, dynamic>?;

      if (roadMapFields != null && roadMapFields.containsKey("RoadMapField")) {
        return (roadMapFields["RoadMapField"] as Map<String, dynamic>).keys
            .toList();
      }

      return [];
    } catch (e) {
      throw Exception('Error fetching RoadMapFields: $e');
    }
  }

  /// Fetch sub-skills from a specific roadmap field
  Future<List<String>> fetchSubSkills(String skill, String roadMapField) async {
    try {
      DocumentSnapshot skillDoc =
      await _firestore.collection('Skills').doc(skill).get();

      if (!skillDoc.exists) {
        throw Exception("Skill not found.");
      }

      Map<String, dynamic>? roadMapFields =
      skillDoc.data() as Map<String, dynamic>?;

      if (roadMapFields != null &&
          roadMapFields["RoadMapField"] != null &&
          roadMapFields["RoadMapField"][roadMapField] != null) {
        return List<String>.from(roadMapFields["RoadMapField"][roadMapField]);
      }

      return [];
    } catch (e) {
      throw Exception('Error fetching sub-skills: $e');
    }
  }
}