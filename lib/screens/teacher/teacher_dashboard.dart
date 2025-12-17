import 'package:flutter/material.dart';
import '../../widgets/info_card.dart';
import '../../widgets/section_title.dart';
import '../../theme/app_colors.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
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
              icon: Icons.how_to_reg,
              onTap: () => Navigator.pushNamed(context, '/takeAttendance'),
            ),

            InfoCard(
              title: "Enter Marks",
              icon: Icons.edit_document,
              onTap: () => Navigator.pushNamed(context, '/enterMarks'),
            ),

            InfoCard(
              title: "Update Attendance Threshold",
              icon: Icons.settings,
              onTap: () =>
                  Navigator.pushNamed(context, '/updateThreshold'),
            ),
          ],
        ),
      ),
    );
  }
}
