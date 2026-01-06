import 'package:flutter/material.dart';
import 'add_teacher.dart';
import 'admin_bottom_nav.dart';

class ManageTeachers extends StatelessWidget {
  const ManageTeachers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Manage Teachers"),
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddTeacher()));
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _TeacherCard(name: "Prof Sunil Dodake", subject: "PIC"),
          _TeacherCard(name: "Mrs Sushma Pawar", subject: "DAN"),
          _TeacherCard(name: "Mrs Gauri Bobade", subject: "English"),
        ],
      ),
    );
  }
}

class _TeacherCard extends StatelessWidget {
  final String name;
  final String subject;
  const _TeacherCard({required this.name, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(name),
        subtitle: Text(subject),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.edit, color: Colors.blue),
            SizedBox(width: 10),
            Icon(Icons.delete, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
