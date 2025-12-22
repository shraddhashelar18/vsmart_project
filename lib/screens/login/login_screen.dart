import 'package:flutter/material.dart';

// mock + models
import '../../mock/mock_users.dart';
import '../../models/user_auth_model.dart';

// dashboards (placeholders for now)
import '../dashboard/admin_dashboard.dart';
import '../dashboard/teacher_dashboard.dart';
import '../dashboard/department_selection_screen.dart';

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
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
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
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- LOGIN LOGIC ----------------

  void _mockLogin() {
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

    if (user.status != "approved") {
      _showMessage("Waiting for admin approval");
      return;
    }

    // ADMIN
    if (user.role == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboard()),
      );
      return;
    }

    // TEACHER
    if (user.role == "teacher") {
      if (user.departments.isEmpty) {
        _showMessage("No department assigned");
        return;
      }

      // SINGLE DEPARTMENT
      if (user.departments.length == 1) {
        String activeDepartment = user.departments.first;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TeacherDashboard(
              activeDepartment: activeDepartment,
              teacherId: user.user_id, // 🔑 REQUIRED
            ),
          ),
        );
      }
      // MULTIPLE DEPARTMENTS
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DepartmentSelectionScreen(
              departments: user.departments,
              teacherId: user.user_id,
            ),
          ),
        );
      }
      return;
    }

    // OTHER ROLES
    _showMessage("Dashboard coming soon for ${user.role}");
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
