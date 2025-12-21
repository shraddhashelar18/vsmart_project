import 'package:flutter/material.dart';

class RegisterCommonScreen extends StatefulWidget {
  const RegisterCommonScreen({Key? key}) : super(key: key);

  @override
  State<RegisterCommonScreen> createState() => _RegisterCommonScreenState();
}

class _RegisterCommonScreenState extends State<RegisterCommonScreen> {
  String selectedRole = "";

  // Common
  String fullName = "";
  String email = "";
  String password = "";

  // Student
  String rollNo = "";
  String studentClass = "";
  String studentMobile = "";
  String parentMobile = "";

  // Teacher
  String employeeId = "";
  String teacherMobile = "";

  // Parent
  String enrollmentNo = "";
  String parentOwnMobile = "";

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            _header(),
            const SizedBox(height: 30),

            _input("Full Name", Icons.person, (v) => fullName = v),
            _input("Email Address", Icons.email, (v) => email = v),
            _passwordInput(),

            DropdownButtonFormField<String>(
              decoration: _decoration("Select Role", Icons.group),
              items: const [
                DropdownMenuItem(value: "student", child: Text("Student")),
                DropdownMenuItem(value: "teacher", child: Text("Teacher")),
                DropdownMenuItem(value: "parent", child: Text("Parent")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            // ---------- ROLE BASED FIELDS ----------
            if (selectedRole == "student") ...[
              _input("Roll No", Icons.badge, (v) => rollNo = v),
              _input("Class", Icons.class_, (v) => studentClass = v),
              _input("Mobile Number", Icons.phone, (v) => studentMobile = v),
              _input("Parent Mobile Number", Icons.phone, (v) => parentMobile = v),
            ],

            if (selectedRole == "teacher") ...[
              _input("Employee ID", Icons.badge, (v) => employeeId = v),
              _input("Mobile Number", Icons.phone, (v) => teacherMobile = v),
            ],

            if (selectedRole == "parent") ...[
              _input("Enrollment No", Icons.confirmation_number,
                  (v) => enrollmentNo = v),
              _input("Mobile Number", Icons.phone,
                  (v) => parentOwnMobile = v),
            ],

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _onRegisterPressed,
              child: const Text("Register"),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
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

  // ---------- ACTION ----------
  void _onRegisterPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Registration request sent to admin for approval",
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------
  Widget _header() {
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
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
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
}
