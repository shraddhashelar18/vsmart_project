import 'package:flutter/material.dart';

class SubjectRow extends StatelessWidget {
  final String subject;
  final String marks;

  const SubjectRow(this.subject, this.marks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject),
          Text(marks),
        ],
      ),
    );
  }
}
