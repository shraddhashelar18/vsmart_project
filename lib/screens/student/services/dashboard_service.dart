import '../models/dashboard_model.dart';

class DashboardService {
  static Future<DashboardModel> fetchDashboard() async {
    // simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return DashboardModel(
      studentName: "Rahul Sharma",
      rollNo: "CS001",
      className: "IF6K-A",
      semester: 6,
      attendancePercent: 87,
      presentDays: 156,
      absentDays: 24,
      ct1Declared: true,
      ct2Declared: false,
      performanceTrend: [72, 75, 78, 82, 88, 90],
      subjects: [
        SubjectModel(name: "Data Structures", percent: 92, grade: "A+"),
        SubjectModel(name: "Operating Systems", percent: 85, grade: "A"),
        SubjectModel(name: "Networks", percent: 88, grade: "A"),
      ],
    );
  }
}
