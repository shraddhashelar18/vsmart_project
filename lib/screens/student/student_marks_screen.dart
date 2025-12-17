import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentMarksScreen extends StatelessWidget {
  const StudentMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Marks & Analytics"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            marksTile("Maths", 18, 19, 76),
            marksTile("Science", 20, 18, 81),
            marksTile("English", 17, 18, 74),
          ],
        ),
      ),
    );
  }

  Widget marksTile(String subject, int ct1, int ct2, int sem) {
    return Card(
      child: ListTile(
        title: Text(subject),
        subtitle: Text("CT1: $ct1   CT2: $ct2   SEM: $sem"),
      ),
    );
  }
}
