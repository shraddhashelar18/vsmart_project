import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';

class HodDetainedStudents extends StatefulWidget {
  final String department;
  final String className;

  const HodDetainedStudents({
    super.key,
    required this.department,
    required this.className,
  });

  @override
  State<HodDetainedStudents> createState() => _HodDetainedStudentsState();
}

class _HodDetainedStudentsState extends State<HodDetainedStudents> {
  final StudentService _studentService = StudentService();

  late Future<List<Student>> _future;

  @override
  void initState() {
    super.initState();
    _future = _studentService.getDetainedStudents(widget.className);
  }

  List<String> _getKTSubjects(Student student) {
    return student.ktSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: Text("${widget.className} - Detained"),
      ),
      body: FutureBuilder<List<Student>>(
        future: _future,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final students = snapshot.data ?? [];

          if (students.isEmpty) {
            return const Center(
              child: Text(
                "No detained students",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            itemBuilder: (_, i) {
              final s = students[i];

              return Card(
                child: ListTile(
                  title: Text(
                    s.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Backlogs: ${s.backlogCount}"),
                      const SizedBox(height: 4),
                      Text(
                        "KT Subjects: ${s.ktSubjects.join(", ")}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
