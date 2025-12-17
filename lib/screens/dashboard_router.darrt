import 'package:flutter/material.dart';

// Import dashboards (we will create these next)
import 'student_dashboard.dart';
import 'teacher_dashboard.dart';
import 'parent_dashboard.dart';
import 'admin_dashboard.dart';

class DashboardRouter extends StatelessWidget {
  final String uid;
  final String role;

  const DashboardRouter({
    super.key,
    required this.uid,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (role) {
      case "student":
        screen = StudentDashboard(uid: uid);
        break;

      case "teacher":
        screen = TeacherDashboard(uid: uid);
        break;

      case "parent":
        screen = ParentDashboard(uid: uid);
        break;

      case "admin":
        screen = AdminDashboard(uid: uid);
        break;

      default:
        screen = const Scaffold(
          body: Center(
            child: Text(
              "Invalid Role. Please contact admin.",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        );
    }

    return screen;
  }
}
