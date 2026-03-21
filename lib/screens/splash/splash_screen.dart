import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showText = false;

  @override
  void initState() {
    super.initState();

    // Show text after logo animation
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        showText = true;
      });
    });

    // Navigate to next screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/register');
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
            /// 🔥 LOGO ANIMATION
            TweenAnimationBuilder(
              tween: Tween(begin: 0.3, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: value,
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                "assets/icon1.png",
                height: MediaQuery.of(context).size.height * 0.20,
              ),
            ),

            const SizedBox(height: 5),

            /// 🔥 TEXT FADE IN
            AnimatedOpacity(
              opacity: showText ? 1 : 0,
              duration: const Duration(milliseconds: 800),
              child: Column(
                children: const [
                  Text(
                    "VSmart",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009846),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Smart Academic Management Platform",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
