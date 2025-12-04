// lib/src/app.dart
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/student/student_dashboard.dart';
import 'screens/teacher/teacher_dashboard.dart';
import 'screens/teacher/take_attendance.dart';
import 'screens/admin/add_student_screen.dart';
import 'screens/shared/notifications_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/login': (c) => LoginScreen(),
    '/student/dashboard': (c) => StudentDashboard(),
    '/teacher/dashboard': (c) => TeacherDashboard(),
    '/teacher/take-attendance': (c) => TakeAttendance(classId: '10A'),
    '/admin/add-student': (c) => AddStudentScreen(),
    '/notifications': (c) => NotificationsScreen(),
  };
}
