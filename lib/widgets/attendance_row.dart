import 'package:flutter/material.dart';

class AttendanceRow extends StatelessWidget {
  final String studentName;
  final String status;
  final Function(String) onChange;

  const AttendanceRow({super.key, required this.studentName, required this.status, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(studentName),
        DropdownButton<String>(
          value: status,
          items: ['Present', 'Absent', 'Late'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => onChange(val!),
        )
      ],
    );
  }
}
