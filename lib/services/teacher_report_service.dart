import '../mock/mock_previous_sem_data.dart';
import '../mock/mock_student_data.dart';

class TeacherReportService {
  Future<List<Map<String, dynamic>>> getStudentsByClass(
      String className) async {
    return mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
            })
        .toList();
  }

  Future<Map<String, dynamic>?> getStudentReport(String studentId) async {
    final studentBasic = mockStudents[studentId];
    final report = mockStudentReports[studentId];

    if (studentBasic == null) return null;

    return {
      ...studentBasic,
      if (report != null) ...report,
    };
  }

  // 🔥 ADD THIS METHOD
  Future<Map<String, dynamic>?> getPreviousSemesters(String studentId) async {
    return mockPreviousSemReports[studentId];
  }
}
