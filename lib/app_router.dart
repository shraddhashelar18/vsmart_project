import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/teacher/take_attendance_screen.dart';
import 'screens/teacher/class_dashboard_screen.dart';
import 'screens/student/student_dashboard_screen.dart';
import 'screens/parent/parent_dashboard_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/teacher/takeAttendance':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => TakeAttendanceScreen(classId: args['classId']));
      case '/teacher/classDashboard':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => ClassDashboardScreen(classId: args['classId']));
      case '/student/dashboard':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => StudentDashboardScreen(studentId: args['studentId']));
      case '/parent/dashboard':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => ParentDashboardScreen(parentId: args['parentId']));
      case '/admin/dashboard':
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('No route defined')),
                ));
    }
  }
}
