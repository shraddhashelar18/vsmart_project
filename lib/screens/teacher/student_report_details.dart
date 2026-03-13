import 'package:flutter/material.dart';
import '../../services/teacher_report_service.dart';
import 'previous_semesters_screen.dart';

class StudentReportDetails extends StatefulWidget {
  final String studentId;
  final String name;
  final String roll;
  static const green = Color(0xFF009846);

  const StudentReportDetails({
    Key? key,
    required this.studentId,
    required this.name,
    required this.roll,
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
    print("REPORT RESPONSE -> $student");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (student == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: StudentReportDetails.green,
          title: const Text("Student Report"),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final marksData = student!["marks"];

    final Map<String, dynamic> marks =
        marksData is Map ? Map<String, dynamic>.from(marksData) : {};

    final subjects = marks.keys.toList();

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
                    widget.name[0],
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Roll No: ${widget.roll}",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 28),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PreviousSemestersScreen(
                        studentId: widget.studentId,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "View Previous Semesters",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: StudentReportDetails.green,
                  ),
                ),
              ),
            ),
            const Text(
              "Exam Performance",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),

            const SizedBox(height: 12),

            if (subjects.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    "Current semester data not entered yet",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              ...subjects.map((subject) {
                final exams = Map<String, dynamic>.from(marks[subject]);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    ...exams.entries.map((examEntry) {
                      final examName = examEntry.key;
                      final data = examEntry.value;

                      if (data["status"] == "draft") return const SizedBox();

                      String displayText;

                      if (data["score"] == null) {
                        displayText = "AB";
                      } else {
                        displayText = "${data["score"]} / ${data["max"]}";
                      }

                      return _buildMarkTile(
                        examName,
                        displayText,
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

  Widget _buildMarkTile(String exam, String displayText) {
    {
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
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Text(displayText)
          ],
        ),
      );
    }
  }
}
