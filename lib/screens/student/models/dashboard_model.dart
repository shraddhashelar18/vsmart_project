class SubjectModel {
  final String name;
  final double percent;
  final int obtained;
  final int total;

  SubjectModel({
    required this.name,
    required this.percent,
    required this.obtained,
    required this.total,
  });

 factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      name: json['name'] ?? "",
      percent: (json['percent'] as num).toDouble(),
      obtained: int.parse(json['obtained'].toString()),
      total: int.parse(json['total'].toString()),
    );
  }
}

class DashboardModel {
  final String studentName;
  final String rollNo;
  final String className;
  final int semester;
final String enrollment;
final String department;
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
    required this.department,
    required this.enrollment,
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
      studentName: json["studentName"],
      rollNo: json["rollNo"],
      className: json["className"],
      semester: json["semester"],
      department: json["department"],
      enrollment: "",
      attendancePercent: 0,
      presentDays: json["presentDays"],
      absentDays: json["absentDays"],
      ct1Declared: true,
      ct2Declared: true,
      performanceTrend:
          List<double>.from(json["performanceTrend"].map((x) => x.toDouble())),
      subjects: (json["subjects"] as List)
          .map((s) => SubjectModel.fromJson(s))
          .toList(),
    );
  }
}
