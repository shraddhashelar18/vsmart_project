import 'package:flutter/material.dart';
import '../../../../mock/mock_student_data.dart';

class ExamCard extends StatelessWidget {
  final String title; // "Class Test 1 (CT1)"
  final String examKey; // "CT-1" or "CT-2"
  final String subject;
  final String studentId;

  const ExamCard({
    super.key,
    required this.title,
    required this.examKey,
    required this.subject,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    final studentReport = mockStudentReports[studentId];
    final subjectMarks = studentReport?["marks"]?[subject];
    final examData = subjectMarks?[examKey];

    final bool isDeclared = examData != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- Title --------
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),

          // -------- Status text --------
          Text(
            isDeclared
                ? "Marks declared by subject teacher"
                : "Marks not declared yet",
            style: TextStyle(
              color: isDeclared ? Colors.green : Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),

          // -------- Status chip --------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Status"),
              Chip(
                label: Text(isDeclared ? "Declared" : "Pending"),
                backgroundColor:
                    isDeclared ? const Color(0xFFE6F4EA) : Colors.grey.shade200,
                labelStyle: TextStyle(
                  color: isDeclared ? const Color(0xFF009846) : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
        ),
      ],
    );
  }
}
