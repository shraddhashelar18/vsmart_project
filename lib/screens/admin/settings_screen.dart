import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const Color primaryGreen = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("Settings"),
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Account"),
            _settingsTile(Icons.lock, "Change Password"),
            _settingsTile(Icons.notifications, "Notification Settings"),
            const SizedBox(height: 20),
            _sectionTitle("Academic"),
            _settingsTile(Icons.class_, "Manage Classes"),
            _settingsTile(Icons.subject, "Manage Subjects"),
            _settingsTile(Icons.calendar_today, "Academic Year"),
            const SizedBox(height: 20),
            _sectionTitle("System"),
            _settingsTile(Icons.security, "Security Settings"),
            _settingsTile(Icons.backup, "Backup & Restore"),
            const SizedBox(height: 20),
            _sectionTitle("App"),
            _settingsTile(Icons.info_outline, "About Application"),
            _settingsTile(Icons.logout, "Logout", isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryGreen,
        ),
      ),
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title, {
    bool isLogout = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withOpacity(0.1),
          child: Icon(
            icon,
            color: isLogout ? Colors.red : primaryGreen,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigation / action later
        },
      ),
    );
  }
}
