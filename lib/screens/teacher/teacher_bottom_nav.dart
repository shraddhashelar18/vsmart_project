import 'package:flutter/material.dart';

import '../../models/user_session.dart';
import '../settings/settings_screen.dart';

class TeacherBottomNav extends StatelessWidget {
  final int currentIndex;

  const TeacherBottomNav({Key? key, required this.currentIndex})
      : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    final user = UserSession.currentUser;
    if (user == null) return const SizedBox();

    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: green,
      onTap: (index) {
        if (index == currentIndex) return;

        if (index == 0) {
          Navigator.pop(context);
        }

        if (index == 1) {
          Navigator.push(
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
