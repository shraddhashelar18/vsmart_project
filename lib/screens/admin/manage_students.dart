import 'package:flutter/material.dart';
import 'add_student.dart';

class ManageStudents extends StatelessWidget {
  const ManageStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Manage Students"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddStudent()));
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StudentCard(name: "Emma Johnson", className: "5-A"),
          _StudentCard(name: "Liam Smith", className: "5-A"),
        ],
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String name;
  final String className;
  const _StudentCard({required this.name, required this.className});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text("Class $className"),
        trailing: const Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
