import 'package:flutter/material.dart';
import '../../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _profileCard(),
          const SizedBox(height: 20),
          _optionTile(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Coming Soon")),
              );
            },
          ),
          _optionTile(
            icon: Icons.info,
            title: "About App",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Vsmart",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2026 Vsmart",
              );
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  // ---------- PROFILE CARD ----------

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white, size: 28),
          ),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rahul Sharma",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text("CS001", style: TextStyle(color: Colors.white70)),
              Text("IF6K-A", style: TextStyle(color: Colors.white70)),
            ],
          )
        ],
      ),
    );
  }

  // ---------- OPTION TILE ----------

  Widget _optionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: green),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
