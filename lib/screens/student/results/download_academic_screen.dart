import 'package:flutter/material.dart';

import '../../../models/user_session.dart';
import '../results/student_semester_detail_screen.dart';

class DownloadAcademicReportScreen extends StatelessWidget {
  const DownloadAcademicReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSemester = UserSession.currentUser?.semester ?? 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Reports"),
        backgroundColor: const Color(0xFF009846),
      ),
      backgroundColor: Colors.grey.shade100,
      body: currentSemester <= 0
          ? const Center(
              child: Text(
                "No semester data available",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: currentSemester,
              itemBuilder: (context, index) {
                final semester = index + 1;

                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StudentSemesterDetailScreen(
                          semesterNumber: semester,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Semester $semester",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
