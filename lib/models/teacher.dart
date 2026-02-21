class Teacher {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String department;

  final bool isClassTeacher;
  final String? classTeacherOf;

  final List<TeachingAssignment> assignments;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.department,
    required this.isClassTeacher,
    this.classTeacherOf,
    required this.assignments,
  });
}

class TeachingAssignment {
  final String className;
  final String subject;

  TeachingAssignment({
    required this.className,
    required this.subject,
  });
}
