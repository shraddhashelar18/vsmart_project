import 'package:flutter/material.dart';

class FinalExamCard extends StatelessWidget {
  const FinalExamCard({super.key});

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.insert_drive_file, size: 40, color: Colors.grey),
          const SizedBox(height: 10),
          const Text("Final Exam",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Scheduled for June 2026",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text("Upload Marksheet"),
          )
        ],
      ),
    );
  }
}
