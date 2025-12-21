import 'package:flutter/material.dart';
import '../dashboard/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  // 🔐 AUTH ATTRIBUTES (MATCH users TABLE)
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
                onChanged: (v) => email = v,
                decoration: _decoration("Enter your email", Icons.email),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // PASSWORD
              TextFormField(
                obscureText: !isPasswordVisible,
                onChanged: (v) => password = v,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
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

  // ---------- MOCK LOGIN LOGIC (SIMULATES BACKEND) ----------

  void _mockLogin() {
    // 🔴 FAKE BACKEND RESPONSE (users table)
    final fakeUser = {
      "user_id": 1,
      "role": "admin", // try: student / teacher / parent
      "status": "approved", // try: pending
    };

    if (fakeUser["status"] != "approved") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Waiting for admin approval"),
        ),
      );
      return;
    }

    if (fakeUser["role"] == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminDashboard(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Dashboard for this role will be available soon",
          ),
        ),
      );
    }
  }

  // ---------- UI HELPERS ----------

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
              fontWeight: FontWeight.w600),
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
