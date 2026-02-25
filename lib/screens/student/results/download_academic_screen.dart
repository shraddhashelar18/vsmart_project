import 'package:flutter/material.dart';

class DownloadAcademicReportScreen extends StatelessWidget {
  final int activeSemester;

  const DownloadAcademicReportScreen({
    super.key,
    required this.activeSemester,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Reports"),
        backgroundColor: const Color(0xFF009846),
      ),
      backgroundColor: Colors.grey.shade100,
      body: activeSemester <= 1
          ? const Center(
              child: Text(
                "No previous semester marksheets available",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: activeSemester - 1,
              itemBuilder: (context, index) {
                final semester = index + 1;

                return Container(
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
                        "Semester $semester Marksheet",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: download logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF009846),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Download"),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
