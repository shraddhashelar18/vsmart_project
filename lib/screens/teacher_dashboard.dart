import 'package:flutter/material.dart';

class TeacherDashboard extends StatelessWidget {
  final String uid;
  const TeacherDashboard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: ListView(
        children: [
          _header(),

          const SizedBox(height: 20),
          _sectionTitle("Quick Actions"),

          _menuButton(
            title: "Take Attendance",
            icon: Icons.check_circle_outline,
            color: Colors.blue,
            onTap: () {
              Navigator.pushNamed(context, "/takeAttendance", arguments: uid);
            },
          ),

          _menuButton(
            title: "Enter Marks",
            icon: Icons.edit_note_rounded,
            color: Colors.deepPurple,
            onTap: () {
              Navigator.pushNamed(context, "/enterMarks", arguments: uid);
            },
          ),

          _menuButton(
            title: "Update Attendance Threshold",
            icon: Icons.settings,
            color: Colors.orange,
            onTap: () {
              Navigator.pushNamed(context, "/updateThreshold", arguments: uid);
            },
          ),

          const SizedBox(height: 20),
          _sectionTitle("Analytics"),

          _menuButton(
            title: "View Class Performance",
            icon: Icons.bar_chart,
            color: Colors.green,
            onTap: () {
              Navigator.pushNamed(context, "/teacherAnalytics", arguments: uid);
            },
          ),
        ],
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Teacher 👩‍🏫",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Teacher Dashboard",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ---------------- SECTION TITLE ----------------
  Widget _sectionTitle(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Text(
        t,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // ---------------- MENU BUTTON ----------------
  Widget _menuButton({
    required String title,
    required IconData icon,
    required Color color,
    required Function() onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Card(
        elevation: 6,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: color.withOpacity(0.15),
                  child: Icon(icon, color: color, size: 30),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
