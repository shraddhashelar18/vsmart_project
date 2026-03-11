import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';

class HodPromotedStudents extends StatefulWidget {
  final String department;
  final String className;

  const HodPromotedStudents({
    super.key,
    required this.department,
    required this.className,
  });

  @override
  State<HodPromotedStudents> createState() => _HodPromotedStudentsState();
}

class _HodPromotedStudentsState extends State<HodPromotedStudents> {
  final StudentService _studentService = StudentService();

  static const green = Color(0xFF009846);

  late Future<List<Student>> _future;

  @override
  void initState() {
    super.initState();
    _future = _studentService.getPromotedStudents(widget.className);
  }

  String formatStatus(String? status) {
    if (status == "PROMOTED_WITH_ATKT") return "Promoted with ATKT";
    if (status == "PROMOTED") return "Promoted";
    if (status == "DETAINED") return "Detained";
    if (status == "PASSED_OUT") return "Passed Out"; // ✅ changed
    return status ?? "-";
  }

  Color statusColor(String? status) {
    if (status == "PROMOTED") return Colors.green;
    if (status == "PROMOTED_WITH_ATKT") return Colors.orange;
    if (status == "DETAINED") return Colors.red;
    if (status == "PASSED_OUT") return Colors.blue; // ✅ changed
    return Colors.grey;
  }

  Color statusBgColor(String? status) {
    if (status == "PROMOTED") return Colors.green.shade100;
    if (status == "PROMOTED_WITH_ATKT") return Colors.orange.shade100;
    if (status == "DETAINED") return Colors.red.shade100;
    if (status == "PASSED_OUT") return Colors.blue.shade100; // ✅ changed
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("Promoted to ${widget.className}"),
      ),
      body: FutureBuilder<List<Student>>(
        future: _future,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading students"));
          }

          final students = (snapshot.data ?? [])
              .where((s) =>
                  s.promotionStatus == "PROMOTED" ||
                  s.promotionStatus == "PASSED_OUT")
              .toList();

          if (students.isEmpty) {
            return const Center(
              child: Text(
                "No promoted students found",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            itemBuilder: (_, i) {
              final s = students[i];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFEAF7F1),
                    child: Icon(Icons.person, color: green),
                  ),
                  title: Text(
                    s.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      if (s.oldClass != null && s.newClass != null)
                        Text(
                          s.promotionStatus == "PASSED_OUT"
                              ? "${s.newClass} → Passed Out"
                              : "${s.oldClass} → ${s.newClass}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      Text("Backlogs: ${s.backlogCount}"),
                      if (s.percentage != null)
                        Text("Percentage: ${s.percentage}%"),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: statusBgColor(s.promotionStatus),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          formatStatus(s.promotionStatus),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor(s.promotionStatus),
                          ),
                        ),
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
