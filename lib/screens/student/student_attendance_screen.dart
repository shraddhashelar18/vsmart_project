import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            attendanceTile("Maths", "78%"),
            attendanceTile("Science", "88%"),
            attendanceTile("English", "91%"),
            attendanceTile("History", "82%"),
          ],
        ),
      ),
    );
  }

  Widget attendanceTile(String subject, String percent) {
    return Card(
      child: ListTile(
        title: Text(subject),
        trailing: Text(
          percent,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
