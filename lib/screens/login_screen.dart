import 'package:flutter/material.dart';
import 'dashboard_router.dart';
import '../theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: AppColors.gradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: emailC,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: passC,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    loading
    ? const CircularProgressIndicator()
    : ElevatedButton(
        onPressed: () {
          Provider.of<UserProvider>(context, listen: false).setUser(
  newUid: "dummyUID",
  newRole: "Student",
  newUserData: {
    "name": "Test User",
    "email": emailC.text.trim(),
  },
);


          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const DashboardRouter()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        ),
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
