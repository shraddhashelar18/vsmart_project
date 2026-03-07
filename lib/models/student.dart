class Student {
  final String id;
  final String name;
  final String rollNo;
  final String enrollmentNo;
  final String email;
  final String phone;
  final String parentMobile;
  int backlogCount;
  String? promotionStatus;
  final double? percentage;
  final List<String> ktSubjects;
  final Map<String, String> ct1Marks;
  final Map<String, String> ct2Marks;
  Map<String, String> finalResults;
  final String? oldClass;
  final String? newClass;

  Student(
      {required this.id,
      required this.name,
      required this.rollNo,
      required this.enrollmentNo,
      required this.email,
      required this.phone,
      required this.parentMobile,
      required this.ct1Marks,
      required this.ct2Marks,
      required this.backlogCount,
      this.promotionStatus,
      required this.ktSubjects,
      required this.percentage,
      required this.finalResults,
      this.oldClass,
      this.newClass});
}
