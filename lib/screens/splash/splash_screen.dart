import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 10), () {
        Navigator.pushReplacementNamed(context, '/register');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF009846),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.school,
                color: Colors.white,
                size: 35,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Vsmart",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF009846),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "A Smart Academic Management Platform",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
