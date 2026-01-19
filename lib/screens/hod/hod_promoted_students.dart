import 'package:flutter/material.dart';

class HodPromotedStudents extends StatelessWidget {
  final String department;
  final String className;

  const HodPromotedStudents({
    Key? key,
    required this.department,
    required this.className,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  // Mock student list
  final Map<String, List<String>> promotedStudents = const {
    "IF6K-A": ["Emma Johnson", "Liam Smith"],
    "IF6K-B": ["Olivia Brown"],
    "IF5K-A": ["Noah Davis", "Sophia Patel"],
  };

  @override
  Widget build(BuildContext context) {
    List<String> students = promotedStudents[className] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("$className - Promoted"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (_, i) {
          return Card(
            child: ListTile(
              title: Text(students[i],
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("Promoted to next semester"),
            ),
          );
        },
      ),
    );
  }
}
