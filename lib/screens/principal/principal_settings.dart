import 'package:flutter/material.dart';
import 'principal_bottom_nav.dart';

class PrincipalSettings extends StatelessWidget {
  const PrincipalSettings({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Settings"),
      ),
      bottomNavigationBar: const PrincipalBottomNav(currentIndex: 1),
      body: const Center(
        child: Text("Settings Page (Backend Later)"),
      ),
    );
  }
}
