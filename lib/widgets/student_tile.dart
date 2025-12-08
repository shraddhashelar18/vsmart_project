import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentTile extends StatelessWidget {
  final Student student;
  final void Function()? onTap;

  const StudentTile({super.key, required this.student, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.userId),
      subtitle: Text("Roll: ${student.rollNo}"),
      onTap: onTap,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
