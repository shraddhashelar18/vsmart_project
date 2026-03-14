import 'package:flutter/material.dart';
import 'subject_row.dart';

class CTResultCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> marks;
  final String examType;

  const CTResultCard({
    super.key,
    required this.title,
    required this.marks,
    required this.examType,
  });

  @override
  Widget build(BuildContext context) {
    int total = 0;
    int subjects = 0;

    List<Widget> rows = [];

    marks.forEach((subject, exams) {
      if (exams[examType] != null) {
        int mark = exams[examType];
        total += mark;
        subjects++;

        Color textColor = mark < 12 ? Colors.red : Colors.black;

        rows.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject,
                  style: TextStyle(color: textColor),
                ),
                Text(
                  "$mark/30",
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        );
      }
    });

    double percentage = subjects == 0 ? 0 : (total / (subjects * 30)) * 100;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ...rows,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Percentage ${percentage.toStringAsFixed(1)}%"),
              Text("Total Marks $total/${subjects * 30}")
            ],
          )
        ],
      ),
    );
  }
}
