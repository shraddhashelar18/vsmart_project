import 'package:flutter/material.dart';

class AllSemesterMarkSheetsScreen extends StatelessWidget {
  const AllSemesterMarkSheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester Marksheets"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(
          6,
          (i) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Semester ${i + 1}"),
                const Icon(Icons.picture_as_pdf, color: Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
