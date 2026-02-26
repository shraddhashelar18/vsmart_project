import 'package:flutter/material.dart';
import '../../services/subjects_service.dart';

class SubjectsScreen extends StatelessWidget {
  final String className;

  const SubjectsScreen({Key? key, required this.className}) : super(key: key);

  static const Color green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    final subjects = SubjectsService().getSubjectsByClass(className);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text(
          "Subjects - $className",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: subjects.isEmpty
          ? const Center(
              child: Text(
                "No subjects found",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: subjects.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: green.withOpacity(0.15),
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                              color: green, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        subjects[index],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
