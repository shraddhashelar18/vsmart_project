import '../models/department_summary.dart';

class DepartmentService {
  Future<DepartmentSummary> getSummary(String department) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // 🔹 MOCK DATA (Replace with API later)
    return DepartmentSummary(
      totalStudents: 350,
      totalTeachers: 18,
      promoted: 312, // progression_status == PROMOTED
      detained: 85, promotedWithBacklog: 7, // clearance_status == NOT_CLEARED
    );
  }
}
