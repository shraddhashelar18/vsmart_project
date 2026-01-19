import 'package:flutter/material.dart';

class HodDetainedStudents extends StatelessWidget {
  final String department;
  final String className;

  const HodDetainedStudents({
    Key? key,
    required this.department,
    required this.className,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  final Map<String, List<String>> detainedStudents = const {
    "IF6K-A": ["Ethan Lee"],
    "IF5K-B": ["Sarah Green", "Daniel Adams"],
  };

  @override
  Widget build(BuildContext context) {
    List<String> students = detainedStudents[className] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("$className - Detained"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (_, i) {
          return Card(
            child: ListTile(
              title: Text(students[i],
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("Detained in current semester"),
            ),
          );
        },
      ),
    );
  }
}
