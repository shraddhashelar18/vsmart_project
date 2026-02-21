import 'package:flutter/material.dart';
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

        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/teacherHome');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(
            context,
            '/settings',
            arguments: {
              "role": "teacher",
            },
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
