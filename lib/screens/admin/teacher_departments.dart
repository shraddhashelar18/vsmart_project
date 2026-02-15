import 'package:flutter/material.dart';
import 'manage_teachers.dart';
import 'admin_bottom_nav.dart';

class TeacherDepartments extends StatelessWidget {
  const TeacherDepartments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Department"),
        backgroundColor: const Color(0xFF009846),
      ),
    // 🔹 BOTTOM NAV
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _deptCard(context, "IT"),
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
              builder: (_) => ManageTeachers(department: dept),
            ),
          );
        },
      ),
    );
  }
}
