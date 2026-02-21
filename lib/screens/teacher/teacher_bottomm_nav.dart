import 'package:flutter/material.dart';

import '../../models/user_session.dart';
import '../settings/settings_screen.dart';
import 'teacher_home.dart';

class TeacherBottomNav extends StatelessWidget {
  final int currentIndex;

  const TeacherBottomNav({Key? key, required this.currentIndex})
      : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: green,
      onTap: (index) {
        if (index == currentIndex) return;

        final user = UserSession.currentUser;
        if (user == null) return; // prevent crash

        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => TeacherHome(
                teacherId: user.user_id,
                teacherName: user.name,
                department: user.departments.first,
                departments: user.departments,
              ),
            ),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SettingsScreen(
                role: user.role,
              ),
            ),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}
