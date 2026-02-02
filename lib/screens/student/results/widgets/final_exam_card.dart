import 'package:flutter/material.dart';

class FinalExamCard extends StatelessWidget {
  final bool declared;
  final bool allowUpload;

  const FinalExamCard({
    super.key,
    required this.declared,
    required this.allowUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(Icons.description, size: 40, color: Colors.grey),
          const SizedBox(height: 10),

          const Text(
            "Final Exam",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text(
            "Scheduled for June 2026",
            style: TextStyle(color: Colors.grey),
          ),

          // ---------- BUTTON ----------
          if (!declared)
            Padding(
                padding: const EdgeInsets.only(top: 14),
                child: ElevatedButton.icon(
                  onPressed: allowUpload ? () {} : null,
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: const Text(
                    "Upload Marksheet",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009846),
                    disabledBackgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
