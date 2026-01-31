import 'package:flutter/material.dart';

class AllSemesterMarkSheetsScreen extends StatelessWidget {
  const AllSemesterMarkSheetsScreen({super.key});

  // MOCK DATA (replace later from backend)
  final Map<int, bool> semesterPdfAvailable = const {
    1: true,
    2: true,
    3: false,
    4: false,
    5: false,
    6: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester Marksheets"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: semesterPdfAvailable.entries.map((entry) {
          return _semesterTile(
            context,
            semester: entry.key,
            available: entry.value,
          );
        }).toList(),
      ),
    );
  }

  Widget _semesterTile(
    BuildContext context, {
    required int semester,
    required bool available,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Semester $semester",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (available)
            ElevatedButton.icon(
              onPressed: () {
                // TODO: open or download PDF
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("View"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
              ),
            )
          else
            const Text(
              "Not Available",
              style: TextStyle(color: Colors.grey),
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
