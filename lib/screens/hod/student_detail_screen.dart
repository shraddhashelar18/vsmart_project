import 'package:flutter/material.dart';
import '../../models/student.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({
    super.key,
    required this.student,
  });

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Student Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFEAF7F1),
                      child: Icon(Icons.person, size: 40, color: green),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text("Roll No: ${student.rollNo}"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            _infoCard(
              title: "Academic Information",
              children: [
                _infoRow("Enrollment No", student.enrollmentNo),
              ],
            ),

            const SizedBox(height: 16),

            _infoCard(
              title: "Contact Information",
              children: [
                _infoRow("Student Mobile", student.phone),
                _infoRow("Parent Mobile", student.parentMobile),
                _infoRow("Email", student.email),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 CT1 Section
            _infoCard(
              title: "CT1 - Subject Wise Marks(Out of 30)",
              children: [
                _subjectMarkRow("Mathematics", "18"),
                _subjectMarkRow("Physics", "Absent"),
                _subjectMarkRow("Programming", "20"),
              ],
            ),

            const SizedBox(height: 16),

// 🔹 CT2 Section
            _infoCard(
              title: "CT2 - Subject Wise Marks(Out of 30)",
              children: [
                _subjectMarkRow("Mathematics", "20"),
                _subjectMarkRow("Physics", "19"),
                _subjectMarkRow("Programming", "Absent"),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _marksBox(String title, int? marks) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 6),
          Text(
            marks?.toString() ?? "--",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  Widget _subjectMarkRow(String subject, String mark) {
    final isAbsent = mark.toLowerCase() == "absent";

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isAbsent ? Colors.red.shade50 : Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              mark,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isAbsent ? Colors.red : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
