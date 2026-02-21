import 'package:flutter/material.dart';
import '../../services/teacher_report_service.dart';

class StudentReportDetails extends StatefulWidget {
  final String studentId;
  static const green = Color(0xFF009846);

  const StudentReportDetails({
    Key? key,
    required this.studentId,
  }) : super(key: key);

  @override
  State<StudentReportDetails> createState() => _StudentReportDetailsState();
}

class _StudentReportDetailsState extends State<StudentReportDetails> {
  final TeacherReportService _service = TeacherReportService();
  Map<String, dynamic>? student;

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    student = await _service.getStudentReport(widget.studentId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (student == null || student!["marks"] == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: StudentReportDetails.green,
          title: const Text("Student Report"),
        ),
        body: const Center(
          child: Text(
            "No report found",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final Map<String, dynamic> marks =
        Map<String, dynamic>.from(student!["marks"]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: StudentReportDetails.green,
        title: const Text("Student Report"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: StudentReportDetails.green,
                  child: Text(
                    student!["name"][0],
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student!["name"],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Roll No: ${student!["roll"]}",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              "Exam Performance",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),

            const SizedBox(height: 12),

            ...marks.entries.map((subjectEntry) {
              final String subject = subjectEntry.key;
              final Map<String, dynamic> exams =
                  Map<String, dynamic>.from(subjectEntry.value);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...["CT-1", "CT-2"].map((exam) {
                    final data = exams[exam];
                    if (data == null) return const SizedBox();

                    // Show only published marks
                    if (data["status"] != "published") {
                      return const SizedBox();
                    }

                    final score = data["score"];
                    final max = data["max"];

                    final displayText = score == null
                        ? "AB"
                        : "${score.toInt()} / ${max.toInt()}";

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
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              exam,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            displayText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: StudentReportDetails.green,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 18),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
