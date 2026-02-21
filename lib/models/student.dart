class Student {
  final String id;
  final String name;
  final String rollNo;
  final String enrollmentNo;
  final String email;
  final String phone;
  final String parentMobile;
 int backlogCount;
  final Map<String, String> ct1Marks;
  final Map<String, String> ct2Marks;
  String? promotionStatus;
Map<String, String> finalResults;
  Student({
    required this.id,
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

    required this.finalResults,
  });
}
