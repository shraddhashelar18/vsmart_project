import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  final String title;
  final String grade;
  final String total;
  final String percent;
  final String date;

  const ExamCard({
    super.key,
    required this.title,
    required this.grade,
    required this.total,
    required this.percent,
    required this.date,
  });

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Chip(label: Text(grade)),
            ],
          ),
          const SizedBox(height: 6),
          Text(date, style: const TextStyle(color: Colors.grey)),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Marks"),
              Text(total, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Percentage"),
              Text(percent,
                  style: const TextStyle(
                      color: green, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, color: green),
                SizedBox(width: 6),
                Text("Download PDF", style: TextStyle(color: green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
