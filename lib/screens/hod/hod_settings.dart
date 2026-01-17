import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';

class HodSettings extends StatelessWidget {
  final String department;

  const HodSettings({Key? key, required this.department}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Settings"),
      ),
      bottomNavigationBar:
          HodBottomNav(currentIndex: 1, department: department),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("Admin Profile"),
          _settingsCard([
            _tile(Icons.person, "Name", "HOD User", () {}),
            _tile(Icons.email, "Email", "hod@college.com", () {}),
            _tile(Icons.key, "Change Password", null, () {}),
          ]),
          const SizedBox(height: 20),
          _sectionTitle("App Settings"),
          _settingsCard([
            _tile(Icons.notifications, "Notifications", null, () {}),
            _tile(Icons.tune, "Feature Toggles", null, () {}),
          ]),
          const SizedBox(height: 20),
          _sectionTitle("Security"),
          _settingsCard([
            _tile(Icons.security, "Privacy Settings", null, () {}),
            _tile(Icons.shield, "Security Options", null, () {}),
          ]),
          const SizedBox(height: 30),
          _logoutButton(context),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  Widget _settingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(height: 1, thickness: 0.4),
          ]
        ],
      ),
    );
  }

  Widget _tile(
      IconData icon, String title, String? subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: green),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: Colors.grey))
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _logoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        icon: const Icon(Icons.logout),
        label: const Text("Logout"),
        onPressed: () {
          // TODO: implement real logout later
          Navigator.pop(context);
        },
      ),
    );
  }
}
