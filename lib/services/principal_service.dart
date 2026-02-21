import '../models/department_summary.dart';
import 'department_service.dart';

class PrincipalService {
  final DepartmentService _departmentService = DepartmentService();

  Future<DepartmentSummary> getCollegeSummary(List<String> departments) async {
    int totalStudents = 0;
    int totalTeachers = 0;
    int promoted = 0;
    int promotedWithBacklog = 0;
    int detained = 0;

    for (var department in departments) {
      final summary = await _departmentService.getSummary(department);

      totalStudents += summary.totalStudents;
      totalTeachers += summary.totalTeachers;
      promoted += summary.promoted;
      promotedWithBacklog += summary.promotedWithBacklog;
      detained += summary.detained;
    }

    return DepartmentSummary(
      totalStudents: totalStudents,
      totalTeachers: totalTeachers,
      promoted: promoted,
      promotedWithBacklog: promotedWithBacklog,
      detained: detained,
    );
  }
}
