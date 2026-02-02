import 'package:flutter/material.dart';
import '../../models/dashboard_model.dart';

class SubjectCard extends StatelessWidget {
  final SubjectModel subject;
  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject.name,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${subject.percent}%"),
              Text(subject.grade,
                  style: const TextStyle(
                      color: Color(0xFF009846), fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
