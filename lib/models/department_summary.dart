class DepartmentSummary {
  final int totalStudents;
  final int totalTeachers;
  final int promoted;
  final int detained;
  final int promotedWithBacklog;

  DepartmentSummary({
    required this.totalStudents,
    required this.totalTeachers,
    required this.promoted,
    required this.detained,
    required this.promotedWithBacklog
  });
}
