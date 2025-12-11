class Student {
  final String id;
  final String userId;
  final String rollNo;
  final String classId;
  final String parentId;
  final String phone;

  Student({
    required this.id,
    required this.userId,
    required this.rollNo,
    required this.classId,
    required this.parentId,
    required this.phone,
  });

  factory Student.fromJson(Map<String, dynamic> json, String id) {
    return Student(
      id: id,
      userId: json['user_id'],
      rollNo: json['roll_no'],
      classId: json['class_id'],
      parentId: json['parent_id'],
      phone: json['phone'],
    );
  }
}
