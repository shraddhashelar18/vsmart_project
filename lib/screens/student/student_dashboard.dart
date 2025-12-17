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
        backgroundColor: AppColors.primaryColor,
        title: const Text("Student Dashboard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Overview"),
            const InfoCard(
              title: "Attendance",
              value: "82%",
              icon: Icons.check_circle,
            ),
            const InfoCard(
              title: "Semester Marks",
              value: "View Marks",
              icon: Icons.school,
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: "Actions"),
            GradientButton(
              text: "View Attendance",
              icon: Icons.list_alt,
              onTap: () {
                Navigator.pushNamed(context, "/student-attendance");
              },
            ),
            GradientButton(
              text: "View Marks",
              icon: Icons.bar_chart,
              onTap: () {
                Navigator.pushNamed(context, "/student-marks");
              },
            ),
            GradientButton(
              text: "Download PDF Marksheet",
              icon: Icons.picture_as_pdf,
              onTap: () {
                Navigator.pushNamed(context, "/student-pdf");
              },
            ),
          ],
        ),
      ),
    );
  }
}
