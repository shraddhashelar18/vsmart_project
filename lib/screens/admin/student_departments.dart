import 'package:flutter/material.dart';
import 'manage_students.dart';
import 'select_class_screen.dart';

class StudentDepartments extends StatelessWidget {
  const StudentDepartments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Department"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _deptCard(context, "IF"),
            _deptCard(context, "CO"),
            _deptCard(context, "EJ"),
          ],
        ),
      ),
    );
  }

  Widget _deptCard(BuildContext context, String dept) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text("$dept Department"),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SelectClassScreen(department: dept),
            ),
          );
        },
      ),
    );
  }
}
