import 'package:flutter/material.dart';
import 'add_student.dart';
import '../../mock/mock_student_data.dart';

class ManageStudents extends StatelessWidget {
  final String className;

  const ManageStudents({Key? key, required this.className}) : super(key: key);

  static const green = Color(0xFF009846);

  List<Widget> _getStudents() {
    return mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((entry) {
      final s = entry.value;
      final enrollment = entry.key;

      return _StudentCard(
        enrollment: enrollment,
        name: s["name"] ?? "",
        email: s["email"] ?? "",
        phone: s["phone"] ?? "",
        className: s["class"] ?? "",
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final students = _getStudents();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Manage Students - $className"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View and manage student information",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ),
        ),
      ),

      // 🔹 ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddStudent(className: className),
            ),
          );
        },
      ),

      // 🔹 BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search by name, email, phone or ID...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${students.length} students found",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(children: students),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String enrollment;
  final String name;
  final String email;
  final String phone;
  final String className;

  const _StudentCard({
    Key? key,
    required this.enrollment,
    required this.name,
    required this.email,
    required this.phone,
    required this.className,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFEAF7F1),
                  child: Icon(Icons.person, color: Color(0xFF009846)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    // 🔹 EDIT
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddStudent(
                              enrollment: enrollment,
                              className: className,
                            ),
                          ),
                        );
                      },
                    ),

                    // 🔹 DELETE
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(context),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.email, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(email),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(phone),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.badge, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(className),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔴 DELETE CONFIRMATION
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Delete $name?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
            onPressed: () {
              mockStudents.remove(enrollment);

              Navigator.pop(context); // close dialog

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ManageStudents(className: className),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
