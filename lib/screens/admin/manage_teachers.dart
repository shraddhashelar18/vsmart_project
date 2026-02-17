import 'package:flutter/material.dart';

import 'add_teacher.dart';
import 'teacher_detail_screen.dart';
import '../../mock/mock_teacher_data.dart';
import '../../mock/mock_teacher_departments.dart';
import '../../mock/mock_teacher_classes.dart';
import '../../mock/mock_teacher_subjects.dart';

class ManageTeachers extends StatelessWidget {
  final String department;

  const ManageTeachers({Key? key, required this.department}) : super(key: key);
  List<Widget> _getTeachers() {
    List<Widget> list = [];

    mockTeacherDepartments.forEach((teacherId, depts) {
      if (depts.contains(department)) {
        final teacher = mockTeachers[teacherId]!;

        list.add(
          TeacherCard(
            teacherId: teacherId,
            name: teacher["name"]!,
            email: teacher["email"]!,
            phone: teacher["phone"]!,
            department: department,
          ),
        );
      }
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // 🔹 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Manage Teachers"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View and manage teacher information",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ),
        ),
      ),

      // 🔹 ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTeacher(department: department),
            ),
          );
        },
      ),

      // 🔹 BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: "Search teachers...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 TEACHER LIST
            Expanded(
              child: ListView(
                children: _getTeachers(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 TEACHER CARD
class TeacherCard extends StatelessWidget {
  final String name;
  final int teacherId;

  final String email;
  final String phone;
  final String department;

  const TeacherCard({
    Key? key,
    required this.name,
    required this.teacherId,
    required this.email,
    required this.department,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F2E9),
                child: Icon(Icons.person, color: Color(0xFF009846)),
              ),
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              // 👇 ADD THIS
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeacherDetailScreen(
                      teacherId: teacherId, // pass id
                      name: name,
                    ),
                  ),
                );
              },

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddTeacher(
                            department: department,
                            teacherId: teacherId,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _confirmDelete(context, teacherId, name);
                    },
                  ),
                ],
              ),
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
          ],
        ),
      ),
    );
  }
}

// 🔴 DELETE CONFIRMATION DIALOG
void _confirmDelete(BuildContext context, int teacherId, String name) {
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
            // REMOVE FROM ALL MOCKS
            mockTeachers.remove(teacherId);
            mockTeacherDepartments.remove(teacherId);
            mockTeacherClasses.remove(teacherId);
            mockTeacherSubjects.remove(teacherId);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$name deleted")),
            );
          },
        ),
      ],
    ),
  );
}
