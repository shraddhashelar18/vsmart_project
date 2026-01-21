import 'package:flutter/material.dart';
import '../../mock/mock_promotion.dart'; // <-- Uses centralized mock data

class HodPromotedStudents extends StatelessWidget {
  final String department;
  final String className;

  const HodPromotedStudents({
    Key? key,
    required this.department,
    required this.className,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> students = mockPromotions[className] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("$className - Promoted"),
      ),
      body: students.isEmpty
          ? const Center(
              child: Text(
                "No promoted students found",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (_, i) {
                final student = students[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      student["name"] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${student["from"]} → ${student["to"]}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
