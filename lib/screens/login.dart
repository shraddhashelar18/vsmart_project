import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'student_dashboard.dart';
import 'teacher_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  bool loading = false;

  login() async {
    if (emailC.text.isEmpty || passC.text.isEmpty) return;

    setState(() => loading = true);

    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailC.text.trim(), password: passC.text.trim());

      String uid = user.user!.uid;

      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      String role = doc["role"];

      if (!mounted) return;

      if (role == "student") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => StudentDashboard(uid: uid)));
      } else if (role == "teacher") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => TeacherDashboard(uid: uid)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Failed")));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Smart School",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _inputField(emailC, "Email", Icons.email),
            const SizedBox(height: 18),
            _inputField(passC, "Password", Icons.lock, obscure: true),
            const SizedBox(height: 30),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        backgroundColor:
                            const Color.fromARGB(255, 134, 145, 212)),
                    child: const Text("Login"),
                  )
          ],
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController c, String label, IconData icon,
      {bool obscure = false}) {
    return TextField(
      controller: c,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
