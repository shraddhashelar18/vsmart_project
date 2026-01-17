import 'package:flutter/material.dart';
import 'hod_dashboard.dart';
import 'hod_students.dart';
import 'hod_teachers.dart';
import 'hod_settings.dart';

class HodBottomNav extends StatelessWidget {
  final int currentIndex;

  const HodBottomNav({Key? key, required this.currentIndex}) : super(key: key);

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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HodDashboard()));
            break;
          case 1:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HodStudents()));
            break;
          case 2:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HodTeachers()));
            break;
          case 3:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HodSettings()));
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: "Dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: "Students"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Teachers"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
