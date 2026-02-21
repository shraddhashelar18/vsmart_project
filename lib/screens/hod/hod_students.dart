import 'package:flutter/material.dart';
import 'hod_select_class_screen.dart';
import 'hod_bottom_nav.dart';

class HodStudents extends StatelessWidget {
  final String department;

  const HodStudents({
    super.key,
    required this.department,
  });

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
   return HodSelectClassScreen(department: department);

  }
}
