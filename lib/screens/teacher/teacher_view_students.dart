import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';
import 'teacher_student_report.dart';

class TeacherViewStudents extends StatelessWidget {
  final String className;
  const TeacherViewStudents({required this.className});

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    final students = mockStudents[className] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("$className Students"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (_, i) {
          final student = students[i];
          return Card(
            child: ListTile(
              title: Text(student['name']),
              subtitle: Text("Roll: ${student['roll']}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        TeacherStudentReport(studentId: student['id']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
