import '../mock/mock_student_data.dart';

class StudentNewService {
  Future<List<Map<String, dynamic>>> getStudentsByClass(
      String className) async {
    return mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((entry) => {
              "enrollment": entry.key,
              ...entry.value,
            })
        .toList();
  }

  Future<Map<String, dynamic>?> getStudentByEnrollment(
      String enrollment) async {
    final data = mockStudents[enrollment];

    if (data == null) return null;

    return {
      "enrollment": enrollment, // ✅ ADD THIS
      ...data,
    };
  }

  Future<void> addStudent({
    required String enrollment,
    required String name,
    required String email,
    required String password,
    required String phone,
    required String parentPhone,
    required String roll,
    required String className,
  }) async {
    mockStudents[enrollment] = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "parentPhone": parentPhone,
      "roll": roll,
      "class": className,
    };
  }

  Future<void> updateStudent({
    required String enrollment,
    required String name,
    required String phone,
    required String parentPhone,
    required String roll,
  }) async {
    if (!mockStudents.containsKey(enrollment)) return;

    mockStudents[enrollment]!["name"] = name;
    mockStudents[enrollment]!["phone"] = phone;
    mockStudents[enrollment]!["parentPhone"] = parentPhone;
    mockStudents[enrollment]!["roll"] = roll;
  }

  Future<void> deleteStudent(String enrollment) async {
    mockStudents.remove(enrollment);
  }

  Future<List<Map<String, dynamic>>> getStudentsByParentPhone(
      String parentPhone) async {
    return mockStudents.entries
        .where((e) => e.value["parentPhone"] == parentPhone)
        .map((entry) => {
              "enrollment": entry.key,
              ...entry.value,
            })
        .toList();
  }
}
