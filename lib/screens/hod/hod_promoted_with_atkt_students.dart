import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';

class HodPromotedWithATKTStudents extends StatefulWidget {
  final String department;
  final String className;

  const HodPromotedWithATKTStudents({
    super.key,
    required this.department,
    required this.className,
  });

  @override
  State<HodPromotedWithATKTStudents> createState() =>
      _HodPromotedWithKTStudentsState();
}

class _HodPromotedWithKTStudentsState
    extends State<HodPromotedWithATKTStudents> {
  final StudentService _studentService = StudentService();

  late Future<List<Student>> _future;

  static const green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _future = _loadStudents();
  }

  Future<List<Student>> _loadStudents() async {
    return await _studentService.getAtktStudents(widget.className);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("Promoted with KT to ${widget.className}"),
      ),
      body: FutureBuilder<List<Student>>(
        future: _future,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final students = snapshot.data ?? [];

          if (students.isEmpty) {
            return const Center(child: Text("No ATKT students"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            itemBuilder: (_, i) {
              final s = students[i];

              return Card(
                child: ListTile(
                  title: Text(s.name),
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
