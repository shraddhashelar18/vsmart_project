// lib/main.dart
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures bindings are ready
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VSmart',
      theme: AppTheme,                    // Custom theme from theme.dart
      initialRoute: '/login',             // Start with login screen
      routes: AppRoutes.routes,           // Centralized app routes
      debugShowCheckedModeBanner: false,  // Hide the debug banner
    );
  }
}
