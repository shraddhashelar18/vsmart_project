import 'package:flutter/material.dart';

import 'teacher_mark_attendance.dart';
import 'teacher_enter_marks.dart';
import 'teacher_view_reports.dart';
import 'teacher_attendance_settings.dart';
import 'teacher_send_notifications.dart';

class TeacherDashboard extends StatelessWidget {
  final String activeDepartment;
  final int teacherId;
  final List<String> departments;

  const TeacherDashboard({
    Key? key,
    required this.activeDepartment,
    required this.teacherId,
    required this.departments,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Teacher Dashboard"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "$activeDepartment Department",
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.05,
          children: [
            _dashBtn(
              icon: Icons.check_circle,
              title: "Take Attendance",
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeacherMarkAttendance(className: className),
                  ),
                );
              },
            ),
            _dashBtn(
              icon: Icons.score,
              title: "Enter Marks",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeacherEnterMarks(teacherId: teacherId),
                  ),
                );
              },
            ),
            _dashBtn(
              icon: Icons.assignment,
              title: "View Reports",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TeacherViewReports()),
                );
              },
            ),
            _dashBtn(
              icon: Icons.settings,
              title: "Attendance Settings",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const TeacherAttendanceSettings()),
                );
              },
            ),
            _dashBtn(
              icon: Icons.notifications_active,
              title: "Send Notifications",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const TeacherSendNotifications()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashBtn({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: green, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
