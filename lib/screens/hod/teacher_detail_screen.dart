import 'package:flutter/material.dart';
import '../../models/teacher.dart';

class TeacherDetailScreen extends StatelessWidget {
  final Teacher teacher;

  const TeacherDetailScreen({
    super.key,
    required this.teacher,
  });

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Teacher Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Profile Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFEAF7F1),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: green,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      teacher.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Contact Info
            _infoCard(
              title: "Contact Information",
              children: [
                _infoRow("Email", teacher.email),
                _infoRow("Mobile", teacher.mobile),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 Teaching Assignments (Always visible)
            _infoCard(
              title: "Teaching Assignments",
              children: teacher.assignments
                  .map(
                    (a) => _infoRow(
                      a.className,
                      a.subject,
                    ),
                  )
                  .toList(),
            ),

            // 🔹 Class Teacher (Only if applicable)
            if (teacher.isClassTeacher) ...[
              const SizedBox(height: 16),
              _infoCard(
                title: "Class Teacher",
                children: [
                  _infoRow(
                    "Assigned Class",
                    teacher.classTeacherOf ?? "-",
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
