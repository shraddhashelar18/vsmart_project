import '../models/teacher.dart';

class TeacherService {
  final List<Teacher> _allTeachers = [
    Teacher(
      id: "1",
      name: "Prof Sunil Dodake",
      email: "sunil@college.com",
      mobile: "9876543210",
      department: "IF",
      isClassTeacher: true,
      classTeacherOf: "IF6KA",
      assignments: [
        TeachingAssignment(
          className: "IF6KA",
          subject: "PIC",
        ),
        TeachingAssignment(
          className: "IF6KA",
          subject: "DAN",
        ),
        TeachingAssignment(
          className: "IF4KB",
          subject: "Database",
        ),
      ],
    ),
    Teacher(
      id: "2",
      name: "Mrs Gauri Bobade",
      email: "gauri@college.com",
      mobile: "9876543222",
      department: "IF",
      isClassTeacher: false,
      classTeacherOf: null,
      assignments: [
        TeachingAssignment(
          className: "IF2KA",
          subject: "English",
        ),
      ],
    ),
    Teacher(
      id: "3",
      name: "Mrs Sushma Pawar",
      email: "sushma@college.com",
      mobile: "9876543333",
      department: "IF",
      isClassTeacher: false,
      classTeacherOf: null,
      assignments: [
        TeachingAssignment(
          className: "IF3KA",
          subject: "Mathematics",
        ),
      ],
    ),
  ];

  Future<List<Teacher>> getTeachersByDepartment(String department) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _allTeachers.where((t) => t.department == department).toList();
  }
}
