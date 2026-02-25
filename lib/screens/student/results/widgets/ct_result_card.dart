import 'package:flutter/material.dart';
import 'subject_row.dart';

class CTResultCard extends StatelessWidget {
  final String title;

  const CTResultCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const SubjectRow("Data Structures", "18/20"),
          const SubjectRow("Operating Systems", "16/20"),
          const SubjectRow("Computer Networks", "19/20"),
          const Divider(height: 24, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Percentage 89%",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "Total Marks 89/100",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
