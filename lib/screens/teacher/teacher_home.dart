import 'package:flutter/material.dart';
import 'teacher_bottom_nav.dart';
import 'teacher_dashboard.dart';

class TeacherHome extends StatefulWidget {
  final int teacherId;
  final String department;
  final String teacherName;
  final List<String> departments;
  const TeacherHome({
    Key? key,
    required this.teacherId,
    required this.teacherName,
    required this.department,
    required this.departments,
  }) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  String selectedClass = "";
  String selectedSubject = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TeacherDashboard(
        teacherId: widget.teacherId,
        activeDepartment: widget.department,
        departments: widget.departments,
        teacherName: widget.teacherName,
        selectedClass: selectedClass,
        selectedSubject: selectedSubject,
        onSelectionChanged: (cls, sub) {
          setState(() {
            selectedClass = cls;
            selectedSubject = sub;
          });
        },
      ),
      bottomNavigationBar: const TeacherBottomNav(currentIndex: 0),
    );
  }
}
