import 'package:flutter/material.dart';

// mock + models
import '../../mock/mock_users.dart';
import '../../mock/mock_teacher_departments.dart';
import '../../models/user_auth_model.dart';

// dashboards
import '../dashboard/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              const SizedBox(height: 90),

              _appHeader(),

              const SizedBox(height: 40),

              // EMAIL
              TextFormField(
                decoration: _decoration("Enter your email", Icons.email),
                onChanged: (v) => email = v.trim(),
                validator: (v) =>
                    v == null || v.isEmpty ? "Email is required" : null,
              ),

              const SizedBox(height: 12),

              // PASSWORD
              TextFormField(
                obscureText: !isPasswordVisible,
                decoration:
                    _decoration("Enter your password", Icons.lock).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (v) => password = v,
                validator: (v) =>
                    v == null || v.isEmpty ? "Password is required" : null,
              ),

              const SizedBox(height: 20),

              // LOGIN BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009846),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_loginFormKey.currentState!.validate()) {
                    _mockLogin();
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Color(0xFF009846)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- LOGIN LOGIC ----------------

  void _mockLogin() {
    // 🔍 find user by email (users table simulation)
    final UserAuth user = mockUsers.firstWhere(
  (u) => u.email == email,
  orElse: () => UserAuth(
    user_id: -1,
    email: "",
    role: "",
    status: "",
  ),
);


    if (user.user_id == -1) {
      _showMessage("User not found");
      return;
    }

    // ⛔ approval check
    if (user.status != "approved") {
      _showMessage("Waiting for admin approval");
      return;
    }

    // ✅ role-based routing
    if (user.role == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboard()),
      );
    }

    else if (user.role == "teacher") {
      // 🔑 simulate teacher_departments table
      final List<String> departments =
          mockTeacherDepartments[user.user_id] ?? [];

      if (departments.isEmpty) {
        _showMessage("No department assigned");
        return;
      }

      if (departments.length == 1) {
        final activeDepartment = departments.first;
        _showMessage(
          "Logged in as Teacher ($activeDepartment department)",
        );

        // 🔜 Later:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => TeacherDashboard(
        //       department: activeDepartment,
        //     ),
        //   ),
        // );
      } else {
        _showMessage("Please select a department");
        // 🔜 Later:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => DepartmentSelectionScreen(
        //       departments: departments,
        //     ),
        //   ),
        // );
      }
    }

    else {
      _showMessage(
        "Dashboard for this role will be available soon",
      );
    }
  }

  // ---------------- HELPERS ----------------

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget _appHeader() {
    return Column(
      children: const [
        CircleAvatar(
          radius: 32,
          backgroundColor: Color(0xFF009846),
          child: Icon(Icons.school, color: Colors.white, size: 28),
        ),
        SizedBox(height: 10),
        Text(
          "Vsmart",
          style: TextStyle(
            color: Color(0xFF009846),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "A Smart Academic Management Platform",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }

  InputDecoration _decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
