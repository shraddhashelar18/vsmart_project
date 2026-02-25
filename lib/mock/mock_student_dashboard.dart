import '../screens/student/models/dashboard_model.dart';

DashboardModel mockDashboard = DashboardModel(
  studentName: "Rahul Sharma",
  rollNo: "CS-2024-001",
  className: "IF6K-A",
  semester: 6,
  attendancePercent: 87,
  presentDays: 156,
  absentDays: 24,
  ct1Declared: true,
  ct2Declared: true,
  performanceTrend: [72, 75, 78, 82, 88, 86],
  subjects: [
    SubjectModel(name: "Data Structures", percent: 92, grade: "A+"),
    SubjectModel(name: "Operating Systems", percent: 85, grade: "A"),
    SubjectModel(name: "Computer Networks", percent: 88, grade: "A"),
  ],
);
