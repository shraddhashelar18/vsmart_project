import 'package:flutter/material.dart';
import '../../mock/mock_student_data.dart';

class StudentReportDetails extends StatelessWidget {
  final String studentId;
  static const green = Color(0xFF009846);

  const StudentReportDetails({
    Key? key,
    required this.studentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = mockStudentReports[studentId];

    if (student == null || student["marks"] == null) {
      return Scaffold(
        appBar:
            AppBar(backgroundColor: green, title: const Text("Student Report")),
        body: const Center(
          child: Text("No report found", style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    final Map<String, dynamic> marks =
        Map<String, dynamic>.from(student["marks"]);

    return Scaffold(
      appBar:
          AppBar(backgroundColor: green, title: const Text("Student Report")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ================= HEADER =================
          Row(children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: green,
              child: Text(
                student["name"][0],
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(student["name"],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              Text("Roll No: ${student["roll"]}",
                  style: TextStyle(color: Colors.grey.shade600)),
            ]),
          ]),

          const SizedBox(height: 28),

          // ================= EXAM PERFORMANCE =================
          const Text(
            "Exam Performance",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),

          // ================= SUBJECTS =================
          ...marks.entries.map((subjectEntry) {
            final String subject = subjectEntry.key;
            final Map<String, dynamic> exams =
                Map<String, dynamic>.from(subjectEntry.value);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- SUBJECT (below Exam Performance) ----
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),

                // ---- EXAMS (CT-1 / CT-2 in order) ----
                ...["CT-1", "CT-2"].map((exam) {
                  final data = exams[exam];
                  if (data == null) return const SizedBox();

                  final int score = (data["score"] as num).toInt();
                  final int max = (data["max"] as num).toInt();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
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
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          exam,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        "$score / $max",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: green,
                        ),
                      ),
                    ]),
                  );
                }).toList(),

                const SizedBox(height: 18),
              ],
            );
          }).toList(),
        ]),
      ),
    );
  }
}
