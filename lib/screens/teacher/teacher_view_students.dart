import 'package:flutter/material.dart';
import '../../mock/mock_student_data.dart';
import 'student_report_details.dart';

class TeacherViewStudents extends StatelessWidget {
  final String className;
  static const green = Color(0xFF009846);

  const TeacherViewStudents({Key? key, required this.className})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 🔥 FIXED STUDENT FETCH
    final students = mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
            })
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("$className Students"),
      ),
      body: students.isEmpty
          ? const Center(
              child: Text(
                "No students found",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (_, i) {
                final s = students[i];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      /// 🔥 ID FIXED → ENROLLMENT
                      final studentId = s['enrollment'];

                      final report = mockStudentReports[studentId];

                      if (report == null ||
                          report["marks"] == null ||
                          (report["marks"] as Map).isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("No report found for this student")),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              StudentReportDetails(studentId: studentId),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        // Avatar bubble
                        Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                            color: green,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            s['name'].toString().substring(0, 1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Name + Roll
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "Roll No: ${s['roll']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(Icons.arrow_forward_ios,
                            size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
mm