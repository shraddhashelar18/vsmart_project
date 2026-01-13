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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Manage Classes"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View, add and organize classes",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ),
        ),
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
        children: [
          ClassCard(className: "IF6K-A", dept: "IT"),
          ClassCard(className: "IF6K-B", dept: "IT"),
          ClassCard(className: "CO5K-A", dept: "CO"),
        ],
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final String className;
  final String dept;

  const ClassCard({required this.className, required this.dept});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(className,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Department: $dept"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // EDIT BUTTON
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddClass()),
                );
              },
            ),

            // DELETE BUTTON
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDelete(context, className),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔴 DELETE CONFIRMATION POPUP
void _confirmDelete(BuildContext context, String className) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Confirm Delete"),
      content: Text("Delete class $className?"),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("$className deleted")));
          },
        ),
      ],
    ),
  );
}
