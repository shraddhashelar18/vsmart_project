import 'package:flutter/material.dart';
import '../mock/mock_student_data.dart';

class TeacherMarksService {
  /// Get students of a class
  List<Map<String, dynamic>> getStudentsByClass(String className) {
    return mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
            })
        .toList();
  }

  /// Get marks for specific student / subject / exam
  Map<String, dynamic>? getExamData({
    required String studentId,
    required String subject,
    required String exam,
  }) {
    return mockStudentReports[studentId]?["marks"]?[subject]?[exam];
  }

  /// Save marks (draft or publish)
  void saveMarks({
    required String className,
    required String subject,
    required String exam,
    required int maxMarks,
    required bool isDraft,
    required Map<String, TextEditingController> controllers,
  }) {
    final students = getStudentsByClass(className);

    for (var s in students) {
      final sid = s["enrollment"];
      final score = int.tryParse(controllers[sid]!.text) ?? 0;

      mockStudentReports[sid] ??= {
        "name": s["name"],
        "roll": s["roll"],
        "marks": {},
      };

      final marks = mockStudentReports[sid]!["marks"] as Map;
      marks[subject] ??= {};

      marks[subject][exam] = {
        "score": score,
        "max": maxMarks,
        "status": isDraft ? "draft" : "published",
      };
    }
  }
}
