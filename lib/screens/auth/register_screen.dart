import 'package:flutter/material.dart';
import '../../widgets/rounded_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  String selectedRole = 'student';

  void register() {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    /// Just SUCCESS popup (later will save to backend)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$selectedRole registered successfully!")),
    );

    Navigator.pop(context); // Back to Login page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 10),

              TextField(
                controller: confirmController,
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: selectedRole,
                decoration: const InputDecoration(labelText: "Select Role"),
                items: const [
                  DropdownMenuItem(value: 'student', child: Text("Student")),
                  DropdownMenuItem(value: 'teacher', child: Text("Teacher")),
                  DropdownMenuItem(value: 'parent', child: Text("Parent")),
                  DropdownMenuItem(value: 'admin', child: Text("Admin")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
              const SizedBox(height: 30),

              RoundedButton(text: "Register", onPressed: register),
            ],
          ),
        ),
      ),
    );
  }
}
