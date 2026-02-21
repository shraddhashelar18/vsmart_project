import '../../mock/mock_teacher_classes.dart';
import '../../mock/mock_teacher_subjects.dart';

class TeacherDashboardService {
  Future<List<String>> getAllocatedClasses(int teacherId) async {
    return mockTeacherClasses[teacherId] ?? [];
  }

  Future<List<String>> getSubjects(int teacherId, String className) async {
    return mockTeacherSubjects[teacherId]?[className] ?? [];
  }
}
