class ClassModel {
  final String id;
  final String className;
  final String teacherId;
  final List<String> studentIds;

  ClassModel({
    required this.id,
    required this.className,
    required this.teacherId,
    required this.studentIds,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json, String id) {
    return ClassModel(
      id: id,
      className: json['class_name'],
      teacherId: json['teacher_id'],
      studentIds: List<String>.from(json['student_ids'] ?? []),
    );
  }
}
