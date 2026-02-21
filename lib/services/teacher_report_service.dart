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
    return mockStudentReports[studentId];
  }
}
