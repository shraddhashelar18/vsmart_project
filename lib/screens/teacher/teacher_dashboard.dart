import 'package:flutter/material.dart';
import '../../widgets/info_card.dart';
import '../../widgets/section_title.dart';
import '../../theme/app_colors.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Teacher Dashboard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Quick Actions"),

            InfoCard(
              title: "Take Attendance",
              subtitle: "Mark students for today's class",
              icon: Icons.how_to_reg,
              color: Colors.blue,
              onTap: () => Navigator.pushNamed(context, '/takeAttendance'),
            ),

            InfoCard(
              title: "Enter Marks",
              subtitle: "Update internal exam marks",
              icon: Icons.edit_document,
              color: Colors.orange,
              onTap: () => Navigator.pushNamed(context, '/enterMarks'),
            ),

            InfoCard(
              title: "Update Attendance Threshold",
              subtitle: "Modify attendance alert limit",
              icon: Icons.settings,
              color: Colors.redAccent,
              onTap: () => Navigator.pushNamed(context, '/updateThreshold'),
            ),
          ],
        ),
      ),
    );
  }
}
