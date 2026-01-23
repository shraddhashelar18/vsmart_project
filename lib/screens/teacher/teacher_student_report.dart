import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';

class TeacherStudentReport extends StatelessWidget {
  final String studentId;
  const TeacherStudentReport({required this.studentId});

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    final data = mockStudentReports[studentId];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Student Report"),
      ),
      body: data == null
          ? const Center(child: Text("No data"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  Text("Roll: ${data['roll']}"),
                  const SizedBox(height: 20),
                  const Text("Marks",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  ...data['marks'].map<Widget>((m) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(m['exam']),
                      trailing: Text("${m['score']} / ${m['max']}"),
                    );
                  }).toList()
                ],
              ),
            ),
    );
  }
}
