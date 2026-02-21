import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';
import '../../services/promotion_service.dart';

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
  final PromotionService _promotionService = PromotionService();

  late Future<List<Student>> _future;

  static const red = Colors.red;

  @override
  void initState() {
    super.initState();
    _future = _loadStudents();
  }

  Future<List<Student>> _loadStudents() async {
    final students = await _studentService.getStudentsByClass(widget.className);

    final evaluated = await _promotionService.evaluatePromotion(students);

    return evaluated.where((s) => s.promotionStatus == "DETAINED").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color (0xFF009846),
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
                        "KT Subjects: ${_getKTSubjects(s).join(", ")}",
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
  List<String> _getKTSubjects(Student student) {
    List<String> ktSubjects = [];

    student.finalResults.forEach((subject, result) {
      if (result == "FAIL" || result == "ABSENT") {
        ktSubjects.add(subject);
      }
    });

    return ktSubjects;
  }
}
