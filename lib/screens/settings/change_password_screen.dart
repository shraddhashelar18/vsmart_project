import 'package:flutter/material.dart';

import '../../core/session_manager.dart';
import '../../services/app_settings_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    Key? key,
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
                child: const Text("Update Password",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    final result = await AppSettingsService().changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(result["message"])));

    if (result["status"] == true) {
      SessionManager.clear();

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    }
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
