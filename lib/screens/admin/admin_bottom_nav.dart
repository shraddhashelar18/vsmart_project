import 'package:flutter/material.dart';
import 'admin_dashboard.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class AdminBottomNav extends StatefulWidget {
  final int currentIndex;
  const AdminBottomNav({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  void _onTap(int index) {
    if (index == widget.currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ReportsScreen()));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      selectedItemColor: const Color(0xFF009846),
      unselectedItemColor: Colors.grey,
      onTap: _onTap,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: "Dashboard"),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
