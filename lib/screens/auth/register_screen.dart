import 'package:flutter/material.dart';
import '../../widgets/rounded_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: const Center(child: Text("Register screen content goes here")),
    );
  }
}
