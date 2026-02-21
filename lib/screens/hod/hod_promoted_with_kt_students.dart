import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';
import '../../services/promotion_service.dart';

class HodPromotedWithKTStudents extends StatefulWidget {
  final String department;
  final String className;

  const HodPromotedWithKTStudents({
    super.key,
    required this.department,
    required this.className,
  });

  @override
  State<HodPromotedWithKTStudents> createState() =>
      _HodPromotedWithKTStudentsState();
}

class _HodPromotedWithKTStudentsState extends State<HodPromotedWithKTStudents> {
  final StudentService _studentService = StudentService();
  final PromotionService _promotionService = PromotionService();

  late Future<List<Student>> _future;

  static const green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _future = _loadStudents();
  }

  Future<List<Student>> _loadStudents() async {
    final students = await _studentService.getStudentsByClass(widget.className);

    final evaluated = await _promotionService.evaluatePromotion(students);

    return evaluated
        .where((s) => s.promotionStatus == "PROMOTED_WITH_ATKT")
        .toList();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("${widget.className} - Promoted With KT"),
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
                        "KT Subjects: ${_getKTSubjects(s).join(", ")}",
                        style: const TextStyle(color: Colors.orange),
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
