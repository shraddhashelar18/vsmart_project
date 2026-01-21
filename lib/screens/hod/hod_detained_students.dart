import 'package:flutter/material.dart';
import '../../mock/mock_promotion.dart'; // <- your detained mock lives here

class HodDetainedStudents extends StatelessWidget {
  final String department;
  final String className;

  const HodDetainedStudents({
    Key? key,
    required this.department,
    required this.className,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    // 🔰 Fetch detained students for the selected class
    final List<Map<String, String>> students = mockDetained[className] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("$className - Detained"),
      ),
      body: students.isEmpty
          ? const Center(
              child: Text(
                "No detained students found",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (_, i) {
                final student = students[i];
                return Card(
                  child: ListTile(
                    title: Text(
                      student["name"] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("Detained in ${student["sem"]}"),
                  ),
                );
              },
            ),
    );
  }
}
