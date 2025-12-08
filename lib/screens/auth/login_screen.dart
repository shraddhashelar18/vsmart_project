import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // Dummy login logic: based on email role
    final email = emailController.text;
    String role = '';
    if (email.contains('student')) role = 'student';
    if (email.contains('teacher')) role = 'teacher';
    if (email.contains('parent')) role = 'parent';
    if (email.contains('admin')) role = 'admin';

    authProvider.login(
      User(id: 'user_dummy', name: 'Dummy', email: email, role: role),
    );

    // Navigate based on role
    if (role == 'student') {
      Navigator.pushReplacementNamed(
        context,
        '/student/dashboard',
        arguments: {'studentId': 'stud_1'},
      );
    } else if (role == 'teacher') {
      Navigator.pushReplacementNamed(
        context,
        '/teacher/takeAttendance',
        arguments: {'classId': 'class_1'},
      );
    } else if (role == 'parent') {
      Navigator.pushReplacementNamed(
        context,
        '/parent/dashboard',
        arguments: {'parentId': 'parent_1'},
      );
    } else if (role == 'admin') {
      Navigator.pushReplacementNamed(context, '/admin/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            RoundedButton(text: "Login", onPressed: login),
          ],
        ),
      ),
    );
  }
}
