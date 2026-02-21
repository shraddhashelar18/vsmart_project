import '../mock/mock_student_data.dart';

class TeacherAttendanceService {
  // 🔹 Get students by class
  Future<List<Map<String, dynamic>>> getStudentsByClass(
      String className) async {
    return mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
              "status": null,
            })
        .toList();
  }

  // 🔹 Save attendance
  Future<void> submitAttendance({
    required String className,
    required String subject,
    required String dateKey,
    required List<Map<String, dynamic>> students,
  }) async {
    mockAttendance[className] ??= {};
    mockAttendance[className]![subject] ??= {};
    mockAttendance[className]![subject]![dateKey] ??= {};

    for (var s in students) {
      mockAttendance[className]![subject]![dateKey]![s["enrollment"]] =
          s["status"] ?? "A";
    }
  }
}
