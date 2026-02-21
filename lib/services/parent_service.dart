import '../mock/mock_parent_data.dart';
import '../mock/mock_student_data.dart';
import 'student_new_service.dart';

class ParentService {
  final StudentNewService _studentService = StudentNewService();
  List<MapEntry<String, Map<String, dynamic>>> getParentsFilteredByClass(
      String className) {
    return mockParents.entries.where((p) {
      final children = p.value["children"] as List;

      for (var enroll in children) {
        if (mockStudents[enroll]?["class"] == className) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  Map<String, dynamic>? getParent(String phone) {
    return mockParents[phone];
  }

  void saveParent({
    required String phone,
    required Map<String, dynamic> data,
  }) {
    mockParents[phone] = data;
  }

  void deleteParent(String phone) {
    mockParents.remove(phone);
  }

  Future<Map<String, dynamic>?> getStudent(String enrollment) {
    return _studentService.getStudentByEnrollment(enrollment);
  }
}
