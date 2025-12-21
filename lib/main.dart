import 'package:flutter/material.dart';

// import screens
import 'screens/splash/splash_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/register/register_common_screen.dart';
import 'screens/register/register_student_screen.dart';
import 'screens/register/register_teacher_screen.dart';
import 'screens/register/register_parent_screen.dart';

void main() {
  runApp(const VsmartApp());
}

class VsmartApp extends StatelessWidget {
  const VsmartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vsmart',
      debugShowCheckedModeBanner: false,

      // 👇 first screen
      home: const SplashScreen(),

      // 👇 routes (VERY IMPORTANT)
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterCommonScreen(),
        '/registerStudent': (context) => const RegisterStudentScreen(),

        '/registerTeacher': (context) => const RegisterTeacherScreen(),
        '/registerParent': (context) => const RegisterParentScreen(),
      },
    );
  }
}
