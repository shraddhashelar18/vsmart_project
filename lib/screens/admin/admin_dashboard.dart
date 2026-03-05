import 'package:flutter/material.dart';
import '../../services/admin_dashboard_service.dart';
import 'admin_bottom_nav.dart';
import 'teacher_departments.dart';
import 'student_departments.dart';
import 'parent_department_screen.dart';
import 'class_departments.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AdminDashboardService _service = AdminDashboardService();

  String admin_name = "Admin";

  int total_teachers = 0;
  int total_students = 0;
  int total_parents = 0;
  int total_classes = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final data = await _service.getDashboardStats();

    if (data["status"] == true) {
      setState(() {
        admin_name = data["admin_name"];

        total_teachers = data["total_teachers"];
        total_students = data["total_students"];
        total_parents = data["total_parents"];
        total_classes = data["total_classes"];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),

      

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              decoration: const BoxDecoration(
                color: Color(0xFF009846),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Admin Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Welcome back, $admin_name",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 STAT CARDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _statCard(
                    icon: Icons.school,
                    label: "Total Teachers",
                    value: total_teachers.toString(),
                    color: const Color(0xFF009846),
                  ),
                  _statCard(
                    icon: Icons.groups,
                    label: "Total Students",
                    value: total_students.toString(),
                    color: Colors.green,
                  ),
                  _statCard(
                    icon: Icons.person,
                    label: "Total Parents",
                    value: total_parents.toString(),
                    color: const Color(0xFF009846),
                  ),
                  _statCard(
                    icon: Icons.class_,
                    label: "Total Classes",
                    value: total_classes.toString(),
                    color: const Color(0xFF009846),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 QUICK ACTIONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                 _actionButton(
                      context, "Manage Teachers", const Color(0xFF009846)),
                  _actionButton(
                      context, "Manage Students", const Color(0xFF009846)),
                  _actionButton(
                      context, "Manage Parents", const Color(0xFF009846)),
                  _actionButton(
                      context, "Manage Classes", const Color(0xFF009846)),

                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 🔹 STAT CARD
  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 ACTION BUTTON
  Widget _actionButton(
    BuildContext context,
    String text,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            if (text == "Manage Teachers") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TeacherDepartments()),
              );
            }
 else if (text == "Manage Students") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentDepartments()
                ),
              );
            } else if (text == "Manage Parents") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ParentDepartmentScreen()),
              );
            } else if (text == "Manage Classes") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClassDepartments()),
              );
            }
          },
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

}
