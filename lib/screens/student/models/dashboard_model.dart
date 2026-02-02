class SubjectModel {
  final String name;
  final double percent;
  final String grade;

  SubjectModel({
    required this.name,
    required this.percent,
    required this.grade,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      name: json['name'],
      percent: json['percent'].toDouble(),
      grade: json['grade'],
    );
  }
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

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      studentName: json['studentName'],
      rollNo: json['rollNo'],
      className: json['className'],
      semester: json['semester'],
      attendancePercent: json['attendancePercent'].toDouble(),
      presentDays: json['presentDays'],
      absentDays: json['absentDays'],
      ct1Declared: json['ct1Declared'],
      ct2Declared: json['ct2Declared'],
      performanceTrend:
         (json['trend'] as List)
          .map((e) => double.parse(e.toString()))
          .toList(),

      subjects: (json['subjects'] as List)
          .map((e) => SubjectModel.fromJson(e))
          .toList(),
    );
  }
}
