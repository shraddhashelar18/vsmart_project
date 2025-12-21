import 'package:flutter/material.dart';

class RegisterTeacherScreen extends StatefulWidget {
  const RegisterTeacherScreen({Key? key}) : super(key: key);

  @override
  State<RegisterTeacherScreen> createState() => _RegisterTeacherScreenState();
}

class _RegisterTeacherScreenState extends State<RegisterTeacherScreen> {
  // ✅ FINAL attributes
  String fullName = "";
  String email = "";
  String password = "";
  String employeeId = "";

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 70),

            _appHeader(),

            const SizedBox(height: 30),

            _input("Full Name", Icons.person, (v) => fullName = v),
            _input("Email Address", Icons.email, (v) => email = v),
            _passwordInput(),
            _input("Employee ID", Icons.badge, (v) => employeeId = v),

            const SizedBox(height: 20),

            _registerButton(),

            const SizedBox(height: 10),

            const Text(
              "Your account will be activated after admin approval",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Back to Login",
                style: TextStyle(color: Color(0xFF009846)),
              ),
            ),
          ],
        ),
      ),
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
        Text("Vsmart",
            style: TextStyle(
                color: Color(0xFF009846),
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 4),
        Text("A Smart Academic Management Platform",
            style: TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  Widget _input(String hint, IconData icon, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        onChanged: onChanged,
        decoration: _decoration(hint, icon),
      ),
    );
  }

  Widget _passwordInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        obscureText: !isPasswordVisible,
        onChanged: (v) => password = v,
        decoration: _decoration("Password", Icons.lock).copyWith(
          suffixIcon: IconButton(
            icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ),
      ),
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

  Widget _registerButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009846),
        minimumSize: const Size(double.infinity, 48),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        // 🔁 TEMP: API call to insert teacher with status = pending
      },
      child: const Text("Register"),
    );
  }
}
