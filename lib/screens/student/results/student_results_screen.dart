import 'package:flutter/material.dart';

import '../../../mock/mock_teacher_data.dart';
import '../models/semester_result.dart';
import 'widgets/exam_card.dart';
import 'widgets/final_exam_card.dart';
import 'widgets/semester_selector.dart';
import 'all_semester_marksheets.dart';

class StudentResultsScreen extends StatefulWidget {
  const StudentResultsScreen({super.key});

  @override
  State<StudentResultsScreen> createState() => _StudentResultsScreenState();
}

class _StudentResultsScreenState extends State<StudentResultsScreen> {
  // 🔹 TEMP (later from login)
  final String studentId = "1";
  final String className = "IF6K-A";

  // semesters student belongs to
  final List<int> semesters = [1, 2, 3, 4, 5, 6];

  late int selectedSemester;

  @override
  void initState() {
    super.initState();
    selectedSemester = _latestSemesterWithData();
  }

  // ---------- AUTO SELECT LATEST SEM WITH DATA ----------
  int _latestSemesterWithData() {
    // For now → active semester
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    // ---------- TEACHER MARKS (CT STATUS) ----------
    bool ct1Declared = false;
    bool ct2Declared = false;

    final studentReport = mockStudentReports[studentId];
    if (studentReport != null) {
      final marks = studentReport["marks"] as Map<String, dynamic>?;

      if (marks != null) {
        for (var subject in marks.values) {
          if (subject["CT-1"] != null) ct1Declared = true;
          if (subject["CT-2"] != null) ct2Declared = true;
        }
      }
    }

    // ---------- ADMIN FINAL RESULT FLAGS (MOCK) ----------
    // ⚠️ Later comes from backend
    final SemesterResult sem = SemesterResult(
      semester: selectedSemester,
      finalDeclared: selectedSemester <= 2, // example
      finalUploadAllowed: selectedSemester == 2,
      finalPdfUploaded: selectedSemester == 1,
      reuploadAllowed: false,
      ct1Declared: ct1Declared,
      ct2Declared: ct2Declared,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // -------- Semester selector --------
            SemesterSelector(
              semesters: semesters,
              selected: selectedSemester,
              onChanged: (v) => setState(() => selectedSemester = v),
            ),

            const SizedBox(height: 16),

            // -------- CT exams (TEACHER DATA) --------
            if (ct1Declared)
              ExamCard(
                title: "Class Test 1 (CT1)",
                examKey: "CT-1",
                subject: "Maths", // dynamic later
                studentId: studentId,
              ),

            if (ct2Declared)
              ExamCard(
                title: "Class Test 2 (CT2)",
                examKey: "CT-2",
                subject: "Maths",
                studentId: studentId,
              ),

            // -------- Final exam (ADMIN CONTROLLED) --------
            FinalExamCard(semester: sem),

            const SizedBox(height: 30),

            // -------- View all semester marksheets --------
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllSemesterMarkSheetsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("View Semester Marksheets"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
