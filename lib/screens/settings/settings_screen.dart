import 'package:flutter/material.dart';
import '../admin/admin_bottom_nav.dart';
import 'change_password_screen.dart';
import 'about_screen.dart';
import '../../services/app_settings_service.dart';

class SettingsScreen extends StatefulWidget {
  final String role;

  const SettingsScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppSettingsService _settingsService = AppSettingsService();

  String activeSemester = "EVEN";
  bool registrationOpen = true;
  bool resultsPublished = false;
  bool attendanceLocked = false;

  static const Color primaryGreen = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    activeSemester = await _settingsService.getActiveSemester();
    registrationOpen = await _settingsService.getRegistrationStatus();
    resultsPublished = await _settingsService.getResultsStatus();
    attendanceLocked = await _settingsService.getAttendanceLockStatus();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("Settings"),
      ),
      bottomNavigationBar:
          widget.role == "admin" ? const AdminBottomNav(currentIndex: 2) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.role == "admin") ...[
              _sectionTitle("Academic Control"),
              _semesterSwitch(),
              _registrationSwitch(),
              _attendanceSwitch(),
              const SizedBox(height: 20),
            ],
            _sectionTitle("Account"),
            _settingsTile(
              Icons.lock,
              "Change Password",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChangePasswordScreen(),
                  ),
                );
              },
            ),
            _settingsTile(
              Icons.info_outline,
              "About Application",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AboutScreen(),
                  ),
                );
              },
            ),
            _settingsTile(
              Icons.logout,
              "Logout",
              isLogout: true,
              onTap: _confirmLogout,
            ),
          ],
        ),
      ),
    );
  }

  // ================== SWITCHES ==================

  Widget _semesterSwitch() {
    return _switchCard(
      icon: Icons.school,
      title: "Active Semester",
      subtitle: activeSemester,
      value: activeSemester == "EVEN",
      onChanged: (value) async {
        activeSemester = value ? "EVEN" : "ODD";
        await _settingsService.setActiveSemester(activeSemester);
        setState(() {});
      },
    );
  }

  Widget _registrationSwitch() {
    return _switchCard(
      icon: Icons.how_to_reg,
      title: "Registration Open",
      value: registrationOpen,
      onChanged: (value) async {
        registrationOpen = value;
        await _settingsService.setRegistrationStatus(value);
        setState(() {});
      },
    );
  }

  Widget _attendanceSwitch() {
    return _switchCard(
      icon: Icons.lock,
      title: "Lock Attendance",
      value: attendanceLocked,
      onChanged: (value) async {
        attendanceLocked = value;
        await _settingsService.setAttendanceLockStatus(value);
        setState(() {});
      },
    );
  }

  Widget _switchCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withOpacity(0.15),
          child: Icon(icon, color: primaryGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Switch(
          value: value,
          activeColor: primaryGreen,
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ================== COMMON UI ==================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
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
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : primaryGreen,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // ================== LOGOUT ==================

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
