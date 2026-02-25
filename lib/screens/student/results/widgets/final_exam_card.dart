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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(Icons.description, size: 42, color: Colors.grey),

          const SizedBox(height: 14),

          const Text(
            "Final Exam",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Scheduled for June 2026",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 20), // 👈 KEY FIX

          ElevatedButton(
            onPressed: allowUpload ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF009846),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Upload Marksheet",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
