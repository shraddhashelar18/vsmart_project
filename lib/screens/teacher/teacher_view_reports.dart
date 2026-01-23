import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';
import 'teacher_view_students.dart';

class TeacherViewReports extends StatelessWidget {
  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    final classList = mockStudents.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("View Reports"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classList.length,
        itemBuilder: (_, i) {
          String className = classList[i];
          return Card(
            child: ListTile(
              title: Text(className),
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
          );
        },
      ),
    );
  }
}
