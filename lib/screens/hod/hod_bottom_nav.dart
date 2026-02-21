import 'package:flutter/material.dart';
import '../../models/user_session.dart';
import '../settings/settings_screen.dart';
import 'hod_dashboard.dart';

class HodBottomNav extends StatelessWidget {
  final int currentIndex;
  final String department;

  const HodBottomNav(
      {Key? key, required this.currentIndex, required this.department})
      : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: green,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        if (i == currentIndex) return;
        switch (i) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => HodDashboard(department: department)),
            );
            break;

          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SettingsScreen(
                  role: UserSession.currentUser!.role,
                ),
              ),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: "Dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
