import '../mock/mock_student_data.dart';
import '../mock/mock_student_dashboard.dart';
import '../screens/student/models/dashboard_model.dart';

class StudentDashboardService {
  Future<DashboardModel> getDashboard(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // 🔥 Find student by email
    final studentEntry = mockStudents.entries.firstWhere(
      (e) => e.value["email"] == email,
      orElse: () => throw Exception("Student not found"),
    );

    final enrollment = studentEntry.key;
    final student = studentEntry.value;

    return DashboardModel(
      studentName: student["name"],
      rollNo: student["roll"],
      enrollment: enrollment,
      className: student["class"],
      semester: 6,
      department: "IF",
      attendancePercent: (student["attendance"] as double) * 100,
      presentDays: 156,
      absentDays: 24,
      ct1Declared: true,
      ct2Declared: true,
      performanceTrend: mockDashboard.performanceTrend,
      subjects: mockDashboard.subjects,
    );
  }
}
