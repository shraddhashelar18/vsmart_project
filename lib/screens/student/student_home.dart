import 'package:flutter/material.dart';

// dashboard
import '../student/dasboard/student_dashboard.dart';

// results
import 'results/student_results_screen.dart';

// notifications
import 'notifications/notifications_screen.dart';

// settings
import '../../screens/settings/settings_screen.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  int currentIndex = 0;

  final List<Widget> screens = [
    StudentDashboard(),
    StudentResultsScreen(),
    NotificationsScreen(),
    SettingsScreen(role: "student"), // 👈 IMPORTANT
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF009846),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Results",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alerts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
