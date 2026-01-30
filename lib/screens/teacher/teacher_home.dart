import 'package:flutter/material.dart';
import 'teacher_dashboard.dart';
import 'teacher_settings.dart';

class TeacherHome extends StatefulWidget {
  final int teacherId;
  final String department;
  final List<String> departments;

  const TeacherHome({
    Key? key,
    required this.teacherId,
    required this.department,
    required this.departments,
  }) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          TeacherDashboard(
            teacherId: widget.teacherId,
            activeDepartment: widget.department,
            departments: widget.departments,
          ),
          TeacherSettingsScreen(
            teacherName: "Teacher", // optional if stored later
            departments: widget.departments,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: const Color(0xFF009846),
        onTap: (i) => setState(() => index = i),
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
      ),
    );
  }
}
