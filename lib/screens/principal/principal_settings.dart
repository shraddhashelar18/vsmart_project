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
        elevation: 0,
        title: const Text("Settings"),
      ),

      // BOTTOM NAV
      bottomNavigationBar: const PrincipalBottomNav(currentIndex: 1),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("Admin Profile"),

          _settingsCard(
            children: [
              _tile(
                icon: Icons.person,
                title: "Name",
                subtitle: "Principal User",
                onTap: () {},
              ),
              _tile(
                icon: Icons.email,
                title: "Email",
                subtitle: "principal@vsmart.edu",
                onTap: () {},
              ),
              _tile(
                icon: Icons.lock,
                title: "Change Password",
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          _sectionTitle("App Settings"),

          _settingsCard(
            children: [
              _tile(
                icon: Icons.notifications,
                title: "Notifications",
                onTap: () {},
              ),
              _tile(
                icon: Icons.tune,
                title: "Feature Toggles",
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          _sectionTitle("Security"),

          _settingsCard(
            children: [
              _tile(
                icon: Icons.privacy_tip,
                title: "Privacy Settings",
                onTap: () {},
              ),
              _tile(
                icon: Icons.security,
                title: "Security Options",
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          // LOGOUT — Always last
          _logoutTile(),
        ],
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _settingsCard({required List<Widget> children}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(children: children),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: green),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _logoutTile() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          "Logout",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          // TODO: Add logout backend logic here
        },
      ),
    );
  }
}
