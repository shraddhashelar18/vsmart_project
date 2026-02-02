class SubjectPerformance {
  final String name;
  final double percentage;
  final String grade;

  SubjectPerformance({
    required this.name,
    required this.percentage,
    required this.grade,
  });
}

class DashboardData {
  final String studentName;
  final String rollNo;
  final String className;
  final int semester;
  final double attendancePercent;
  final int presentDays;
  final int absentDays;
  final List<double> monthlyTrend;
  final List<SubjectPerformance> subjects;

  DashboardData({
    required this.studentName,
    required this.rollNo,
    required this.className,
    required this.semester,
    required this.attendancePercent,
    required this.presentDays,
    required this.absentDays,
    required this.monthlyTrend,
    required this.subjects,
  });
}

// MOCK INSTANCE
DashboardData mockDashboard = DashboardData(
  studentName: "Rahul Sharma",
  rollNo: "CS-2024-001",
  className: "IF6K-A",
  semester: 6,
  attendancePercent: 87,
  presentDays: 156,
  absentDays: 24,
  monthlyTrend: [72, 75, 78, 82, 88, 86],
  subjects: [
    SubjectPerformance(name: "Data Structures", percentage: 92, grade: "A+"),
    SubjectPerformance(name: "Operating Systems", percentage: 85, grade: "A"),
    SubjectPerformance(name: "Computer Networks", percentage: 88, grade: "A"),
  ],
);
