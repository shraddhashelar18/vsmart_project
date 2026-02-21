import 'package:flutter/material.dart';
import '../admin/admin_bottom_nav.dart';
import 'change_password_screen.dart';
import 'about_screen.dart';
import '../../services/app_settings_service.dart';

class SettingsScreen extends StatefulWidget {
  final String role;
  final String? department;

  const SettingsScreen({
    Key? key,
    required this.role,
    this.department,
  }) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppSettingsService _settingsService = AppSettingsService();

  String activeSemester = "EVEN";
  bool registrationOpen = true;
  bool resultsPublished = false;
  bool attendanceLocked = false;
  int atktLimit = 2;

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
    atktLimit = await _settingsService.getAtktLimit();

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
           if (widget.role == "hod") ...[
              // 🔹 PROFILE
              _sectionTitle("Profile"),
              _settingsCard([
                _infoTile(Icons.person, "Name", "HOD User"),
                _infoTile(Icons.email, "Email", "hod@college.com"),
                if (widget.department != null)
                  _infoTile(Icons.school, "Department", widget.department!),
              ]),

              const SizedBox(height: 20),

              // 🔹 ACADEMIC INFO (READ ONLY)
              _sectionTitle("Academic Information"),
              _settingsCard([
                _infoTile(Icons.school, "Active Semester", activeSemester),
                _infoTile(Icons.rule, "ATKT Limit", atktLimit.toString()),
                _infoTile(
                  Icons.how_to_reg,
                  "Registration Status",
                  registrationOpen ? "Open" : "Closed",
                ),
              ]),

              const SizedBox(height: 20),
            ],
            if (widget.role == "admin") ...[
              _sectionTitle("Academic Control"),
              _semesterSwitch(),
              _registrationSwitch(),
              _attendanceSwitch(),
                            _atktLimitCard(),
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
                    builder: (_) => const ChangePasswordScreen(
                      currentStoredPassword: '123456',
                    ),
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
Widget _atktLimitCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withOpacity(0.15),
          child: const Icon(Icons.rule, color: primaryGreen),
        ),
        title: const Text(
          "Max Backlogs Allowed",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text("Current Limit: $atktLimit"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: atktLimit > 0
                  ? () async {
                      atktLimit--;
                      await _settingsService.setAtktLimit(atktLimit);
                      setState(() {});
                    }
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                atktLimit++;
                await _settingsService.setAtktLimit(atktLimit);
                setState(() {});
              },
            ),
          ],
        ),
      ),
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
  Widget _infoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: primaryGreen),
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(color: Colors.grey),
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
//