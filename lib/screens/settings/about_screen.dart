import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static const Color primaryGreen = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("About Application"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            SizedBox(height: 40),
            Icon(Icons.school, size: 70, color: primaryGreen),
            SizedBox(height: 20),
            Text(
              "VSmart",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("Smart Academic Management System"),
            SizedBox(height: 20),
            Text("Version: 1.0.0"),
            SizedBox(height: 20),
            Text("© 2026 All Rights Reserved"),
          ],
        ),
      ),
    );
  }
}
