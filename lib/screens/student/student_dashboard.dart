import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  // 🔹 TEMP (later from login)
  final String studentId = "1";
  final String className = "IF6K-A";
  final int activeSemester = 3;

  @override
  Widget build(BuildContext context) {
    // ---------- AUTO DETECT CT STATUS ----------
    bool ct1Done = false;
    bool ct2Done = false;

    final studentReport = mockStudentReports[studentId];

    if (studentReport != null) {
      final marks = studentReport["marks"] as Map<String, dynamic>?;

      if (marks != null) {
        for (var subject in marks.values) {
          if (subject["CT-1"] != null) ct1Done = true;
          if (subject["CT-2"] != null) ct2Done = true;
        }
      }
    }

    // ---------- ATTENDANCE ----------
    final attendance = calculateAttendancePercentage(
      studentId: studentId,
      className: className,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Text(
              "Semester $activeSemester",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // ---------- ATTENDANCE ----------
            _card(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Attendance",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${attendance.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: attendance >= 75 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- CT STATUS ----------
            const Text(
              "Current Semester Performance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            if (!ct1Done && !ct2Done)
              const Text(
                "No internal assessments conducted yet.",
                style: TextStyle(color: Colors.grey),
              ),

            if (ct1Done) _row("Class Test 1", "Declared"),
            if (ct2Done) _row("Class Test 2", "Declared"),
          ],
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  Widget _row(String title, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            status,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: child,
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
        ),
      ],
    );
  }

  // ---------------- ATTENDANCE LOGIC ----------------

  double calculateAttendancePercentage({
    required String studentId,
    required String className,
  }) {
    int total = 0;
    int present = 0;

    final classData = mockAttendance[className];
    if (classData == null) return 0;

    for (var subject in classData.values) {
      for (var day in subject.values) {
        if (day.containsKey(studentId)) {
          total++;
          if (day[studentId] == "P" || day[studentId] == "L") {
            present++;
          }
        }
      }
    }

    if (total == 0) return 0;
    return (present / total) * 100;
  }
}
