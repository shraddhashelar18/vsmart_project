import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';
import 'hod_students.dart';
import 'hod_teachers.dart';
import 'hod_promoted_list.dart';
import 'hod_detained_list.dart';
import 'hod_settings.dart';

class HodDashboard extends StatelessWidget {
  final String department;

  const HodDashboard({Key? key, required this.department}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("HOD Dashboard ($department)"),
      ),
      bottomNavigationBar:
          HodBottomNav(currentIndex: 0, department: department),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _card(Icons.school, "Total Students", "350"),
                _card(Icons.person, "Total Teachers", "18"),
                _card(Icons.arrow_upward, "Promoted", "312"),
                _card(Icons.warning, "Detained", "38"),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Academic Actions",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _button(context, "View Students", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HodStudents(department: department),
                ),
              );
            }),
            _button(context, "View Teachers", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HodTeachers(department: department),
                ),
              );
            }),
            _button(context, "View Promoted List", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HodPromoted(department: department),
                ),
              );
            }),
            _button(context, "View Detained List", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HodDetained(department: department),
                ),
              );
            }),
            _button(context, "Settings", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HodSettings(department: department),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _card(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: green, size: 28),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _button(BuildContext context, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
