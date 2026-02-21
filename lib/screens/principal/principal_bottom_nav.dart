import 'package:flutter/material.dart';
import '../settings/settings_screen.dart';
import 'principal_dashboard.dart';

class PrincipalBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<String> departments;

  const PrincipalBottomNav({
    Key? key,
    required this.currentIndex,
    required this.departments,
  }) : super(key: key);

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
                builder: (_) => PrincipalDashboard(departments: departments),
              ),
            );
            break;

          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SettingsScreen(role: "principal"),
              ),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
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
