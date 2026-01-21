import 'package:flutter/material.dart';
import '../hod/hod_students.dart';
import '../hod/hod_teachers.dart';
import '../hod/hod_promoted_classes.dart';
import '../hod/hod_detained_classes.dart';
import 'principal_bottom_nav.dart';


class PrincipalDepartmentView extends StatelessWidget {
  final String department;
  const PrincipalDepartmentView({Key? key, required this.department})
      : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("$department Department"),
      ),
      bottomNavigationBar: const PrincipalBottomNav(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _button(context, "View Students", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => HodStudents(department: department)),
              );
            }),
            _button(context, "View Teachers", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => HodTeachers(department: department)),
              );
            }),
            _button(context, "View Promoted List", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => HodPromotedClasses(department: department)),
              );
            }),
            _button(context, "View Detained List", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => HodDetainedClasses(department: department)),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _button(BuildContext context, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
