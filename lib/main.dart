import 'package:flutter/material.dart';

// screens
import 'screens/splash/splash_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/register/register_common_screen.dart';
import 'screens/admin/admin_dashboard.dart'; // ✅ ADD THIS


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const VsmartApp());
}

class VsmartApp extends StatelessWidget {
  const VsmartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vsmart',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,

      // ✅ FIRST SCREEN
      home: const SplashScreen(),

      // ✅ ROUTES
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterCommonScreen(),
        '/admin': (context) => AdminDashboard(), // ✅ ADMIN DASHBOARD
      },
    );
  }
}
