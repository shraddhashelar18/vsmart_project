class SubjectModel {
  final String name;
  final double percent;
  final String grade;

  SubjectModel({
    required this.name,
    required this.percent,
    required this.grade,
  });
}

class DashboardModel {
  final String studentName;
  final String rollNo;
  final String className;
  final int semester;

  final double attendancePercent;
  final int presentDays;
  final int absentDays;

  final bool ct1Declared;
  final bool ct2Declared;

  final List<double> performanceTrend;
  final List<SubjectModel> subjects;

  DashboardModel({
    required this.studentName,
    required this.rollNo,
    required this.className,
    required this.semester,
    required this.attendancePercent,
    required this.presentDays,
    required this.absentDays,
    required this.ct1Declared,
    required this.ct2Declared,
    required this.performanceTrend,
    required this.subjects,
  });
}
