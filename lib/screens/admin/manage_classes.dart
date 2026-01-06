import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';
import 'add_class.dart';

class ManageClasses extends StatelessWidget {
  const ManageClasses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Manage Classes"),
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddClass()),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ClassCard(className: "IF6K-A", dept: "IT"),
          _ClassCard(className: "IF6K-B", dept: "IT"),
          _ClassCard(className: "CO5K-A", dept: "CO"),
        ],
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  final String className;
  final String dept;

  const _ClassCard({required this.className, required this.dept});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(className),
        subtitle: Text("Department: $dept"),
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
