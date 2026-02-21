import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String currentStoredPassword; // 🔥 pass from login

  const ChangePasswordScreen({
    Key? key,
    required this.currentStoredPassword,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";

  static const Color primaryGreen = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _passwordField("Current Password", (v) => currentPassword = v),
              _passwordField("New Password", (v) => newPassword = v),
              _passwordField("Confirm Password", (v) => confirmPassword = v),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                ),
                onPressed: _updatePassword,
                child: const Text("Update Password"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updatePassword() {
    if (!_formKey.currentState!.validate()) return;

    // 🔒 Step 1: Verify current password
    if (currentPassword != widget.currentStoredPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current password is incorrect")),
      );
      return;
    }

    // 🔒 Step 2: Check new != old
    if (newPassword == widget.currentStoredPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New password must be different")),
      );
      return;
    }

    // 🔒 Step 3: Confirm match
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password changed successfully")),
    );

    Navigator.pop(context);
  }

  Widget _passwordField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          if (value.length < 6) {
            return "Minimum 6 characters required";
          }
          return null;
        },
      ),
    );
  }
}
