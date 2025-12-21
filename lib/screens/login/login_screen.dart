import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ✅ FINAL attributes
  String email = "";
  String password = "";

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 90),

            _appHeader(),

            const SizedBox(height: 40),

            _input("Enter your email", Icons.email, (v) => email = v),
            _passwordInput(),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Login will be connected to backend"),
    ),
  );
},

              child: const Text("Login"),
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
        decoration: _decoration("Enter your password", Icons.lock).copyWith(
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
}
