import 'package:flutter/material.dart';
import 'student/student_dashboard.dart';
import 'teacher/teacher_dashboard.dart';
import 'parent/parent_dashboard.dart';
import 'admin/admin_dashboard.dart';

class RoleRouter extends StatelessWidget {
  final String role;

  const RoleRouter({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case "Student":
        return const StudentDashboard();
      case "Teacher":
        return const TeacherDashboard();
      case "Parent":
        return const ParentDashboard();
      case "Admin":
        return const AdminDashboard();
      default:
        return const Scaffold(
          body: Center(child: Text("Invalid role")),
        );
    }
  }
}
