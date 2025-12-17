import 'package:flutter/material.dart';
import '../../widgets/info_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/gradient_button.dart';
import '../../theme/app_colors.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Student Dashboard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Overview"),

            InfoCard(
              title: "82%",
              subtitle: "Attendance",
              icon: Icons.check_circle,
              color: Colors.green,
            ),

            InfoCard(
              title: "View Marks",
              subtitle: "Semester Marks",
              icon: Icons.school,
              color: Colors.indigo,
            ),

            const SizedBox(height: 20),
            const SectionTitle(title: "Actions"),

            GradientButton(
              text: "View Attendance",
              onTap: () => Navigator.pushNamed(context, "/student-attendance"),
            ),

            GradientButton(
              text: "View Marks",
              onTap: () => Navigator.pushNamed(context, "/student-marks"),
            ),

            GradientButton(
              text: "Download PDF Marksheet",
              onTap: () => Navigator.pushNamed(context, "/student-pdf"),
            ),
          ],
        ),
      ),
    );
  }
}
