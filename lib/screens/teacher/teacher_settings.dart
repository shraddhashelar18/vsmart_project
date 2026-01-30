import 'package:flutter/material.dart';

class TeacherSettingsScreen extends StatelessWidget {
  final String teacherName;
  final List<String> departments; // teacher can have multiple departments
  static const green = Color(0xFF009846);

  const TeacherSettingsScreen({
    Key? key,
    required this.teacherName,
    required this.departments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _profileSection(),
          const SizedBox(height: 20),
          _sectionHeader("ACCOUNT"),
          _tile(Icons.person, "View Profile", onTap: () {}),
          _tile(Icons.lock, "Change Password", onTap: () {}),
          _tile(Icons.notifications, "Notification Preferences", onTap: () {}),
          _tile(Icons.history, "Activity Log", onTap: () {}),
          const SizedBox(height: 20),
          _sectionHeader("APP"),
          _tile(Icons.info_outline, "App Info", onTap: () {}),
          _tile(Icons.help_outline, "Help & Support", onTap: () {}),
          _tile(Icons.bug_report_outlined, "Report Issue", onTap: () {}),
          const SizedBox(height: 20),
          _sectionHeader("SYSTEM"),
          _tile(Icons.language, "Language", onTap: () {}),
          _tile(Icons.dark_mode, "Theme (Coming Soon)", onTap: () {}),
          const SizedBox(height: 20),
          _sectionHeader("DANGER ZONE"),
          _tile(Icons.logout, "Logout", color: Colors.red, onTap: () {
            _confirmLogout(context);
          }),
        ],
      ),
    );
  }

  // ---------- PROFILE CARD ----------
  Widget _profileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _box(),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: green,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              teacherName[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacherName,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "Role: Teacher",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                Text(
                  departments.isNotEmpty
                      ? "Dept: ${departments.join(" | ")}"
                      : "Dept: Not Assigned",
                  style: TextStyle(color: Colors.grey.shade700),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // ---------- TILE ----------
  Widget _tile(IconData icon, String title,
      {VoidCallback? onTap, Color? color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: _box(),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color ?? green),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: color ?? Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // ---------- SECTION LABEL ----------
  Widget _sectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }

  // ---------- BOX UI ----------
  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      );

  // ---------- LOGOUT DIALOG ----------
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Do you really want to logout?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO redirect to login
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
