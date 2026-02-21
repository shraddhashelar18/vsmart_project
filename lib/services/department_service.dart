import '../models/department_summary.dart';
import 'student_service.dart';
import 'promotion_service.dart';

class DepartmentService {
  final StudentService _studentService = StudentService();
  final PromotionService _promotionService = PromotionService();

  Future<DepartmentSummary> getSummary(String department) async {
    final classes = _getClassesForDepartment(department);

    int totalStudents = 0;
    int promoted = 0;
    int promotedWithBacklog = 0;
    int detained = 0;

    for (var className in classes) {
      final students = await _studentService.getStudentsByClass(className);

      final evaluated = await _promotionService.evaluatePromotion(students);

      totalStudents += evaluated.length;

      for (var s in evaluated) {
        if (s.promotionStatus == "PROMOTED") promoted++;
        if (s.promotionStatus == "PROMOTED_WITH_ATKT") promotedWithBacklog++;
        if (s.promotionStatus == "DETAINED") detained++;
      }
    }

    return DepartmentSummary(
      totalStudents: totalStudents,
      totalTeachers: 18, // mock for now
      promoted: promoted,
      promotedWithBacklog: promotedWithBacklog,
      detained: detained,
    );
  }

  List<String> _getClassesForDepartment(String dept) {
    switch (dept) {
      case "IF":
        return ["IF1KA", "IF3KA"];
      case "CO":
        return ["CO1KA", "CO3KA"];
      case "EJ":
        return ["EJ1KA", "EJ3KA"];
      default:
        return [];
    }
  }
}
