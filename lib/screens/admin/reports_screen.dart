import 'package:flutter/material.dart';
import 'package:vsmart_app/screens/admin/performance_report.dart';
import 'admin_bottom_nav.dart';
import 'admin_user_approval_screen.dart';
import 'result_control.dart';
import 'attendance_report.dart'; // ADD THIS

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  static const Color primaryGreen = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("Reports"),
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 ATTENDANCE REPORT
            _reportCard(
              context: context,
              icon: Icons.fact_check,
              title: "Attendance Report",
              subtitle: "View student attendance details",
              onTap: () {
                // ADD THIS
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AttendanceReport(),
                  ),
                );
              },
            ),

            // PERFORMANCE REPORT
            _reportCard(
              context: context,
              icon: Icons.bar_chart,
              title: "Performance Report",
              subtitle: "Student academic performance",
              onTap: () {
                // ADD THIS
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PerformanceReport(),
                  ),
                );
              },
            ),

            // RESULT CONTROL
            _reportCard(
              context: context,
              icon: Icons.assignment_turned_in,
              title: "Result Control",
              subtitle: "Declare results & control marksheet upload",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResultControlScreen(),
                  ),
                );
              },
            ),
// USER APPROVALS
            _reportCard(
              context: context,
              icon: Icons.verified_user,
              title: "User Approvals",
              subtitle: "Verify & approve registrations",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminUserApprovalScreen(),
                  ),
                );
              },
            ),

          
          ],
        ),
      ),
    );
  }

  Widget _reportCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: primaryGreen.withOpacity(0.15),
          child: Icon(
            icon,
            color: primaryGreen,
            size: 26,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 13),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap, // THIS ALREADY EXISTS
      ),
    );
  }
}
