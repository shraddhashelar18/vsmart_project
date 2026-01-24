import 'package:flutter/material.dart';
import 'teacher_view_students.dart';

class TeacherViewReports extends StatelessWidget {
  final String className;
  static const green = Color(0xFF009846);

  const TeacherViewReports({Key? key, required this.className})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: green, title: Text("Reports - $className")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text("Students"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TeacherViewStudents(className: className),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
