import 'package:flutter/material.dart';
import '../../services/parent_notification_service.dart';
import '../../services/parent_service.dart';
import '../../services/report_service.dart';
import '../../services/student_new_service.dart';
import '../../models/user_session.dart';
import 'notifications_screen.dart';
import 'subjects_screen.dart';
import 'grades_screen.dart';
import 'profile_screen.dart';
import 'parent_bottom_nav.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  static const Color green = Color(0xFF009846);

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  final ParentService _parentService = ParentService();
  final StudentNewService _studentService = StudentNewService();
  final ReportService _reportService = ReportService();

  List<Map<String, dynamic>> children = [];
  List<Map<String, dynamic>> notifications = [];
  Map<String, dynamic>? parentData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final email = UserSession.currentUser?.email;
    if (email == null) return;

    final parent = _parentService.getParentByEmail(email);
    if (parent == null) return;

    final phone = parent["phone"];

    final students = await _studentService.getStudentsByParentPhone(phone);

    setState(() {
      parentData = parent;
      children = students;
      isLoading = false;
    });
    List<String> enrollments =
        students.map((s) => s["enrollment"].toString()).toList();

    final parentNotifs =
        await ParentNotificationService.fetchParentNotifications(enrollments);

    setState(() {
      parentData = parent;
      children = students;
      notifications = parentNotifs;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: AppBar(
          backgroundColor: ParentDashboard.green,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(16, 42, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Parent Dashboard",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("Welcome back, ${parentData?["name"] ?? ""}",
                    style: const TextStyle(color: Colors.white70))
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotificationsScreen(
                      notifications: notifications,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Child",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children.map((c) => _childCard(c)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            NotificationsScreen(notifications: notifications),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: ParentDashboard.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...notifications.take(2).map((n) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(n["title"] ?? ""),
                    subtitle: Text(n["message"] ?? ""),
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: const ParentBottomNav(currentIndex: 0),
    );
  }

  // ================= CHILD CARD =================
  Widget _childCard(Map c) {
    final name = c["name"] ?? "";
    final className = c["class"] ?? "";
    final roll = c["roll"] ?? "";
    final enrollment = c["enrollment"] ?? "";
    double attendance = c["attendance"] ?? 0.0;
    bool good = attendance >= 0.9;

    final weakSubjects = _reportService.calculateWeakSubjects(enrollment);

    final initials =
        name.isNotEmpty ? name.split(" ").map((e) => e[0]).take(2).join() : "";

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ParentDashboard.green,
                  child: Text(initials,
                      style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text("$className | Roll: $roll",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey))
                      ]),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Attendance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Attendance"),
                Text("${(attendance * 100).toInt()}%",
                    style: TextStyle(
                        color: good ? ParentDashboard.green : Colors.red,
                        fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: attendance,
              color: good ? ParentDashboard.green : Colors.red,
              minHeight: 6,
            ),
            const SizedBox(height: 12),

            /// Only show if weak subjects exist
            if (weakSubjects.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.trending_down,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Needs Improvement",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Wrap(
                        spacing: 12,
                        children: weakSubjects
                            .map<Widget>((s) => Chip(
                                  label: Text(s),
                                  backgroundColor: Colors.red.shade50,
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),

            const SizedBox(height: 12),

            /// Bottom Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubjectsScreen(className: className),
                      ),
                    );
                  },
                  child: const _BottomIcon(
                      icon: Icons.menu_book, label: "Subjects"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GradesScreen(enrollment: enrollment),
                      ),
                    );
                  },
                  child: const _BottomIcon(icon: Icons.star, label: "Grades"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(enrollment: enrollment),
                      ),
                    );
                  },
                  child:
                      const _BottomIcon(icon: Icons.person, label: "Profile"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _notification(String text) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.notifications),
        title: Text(text),
      ),
    );
  }
}

class _BottomIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _BottomIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon, color: ParentDashboard.green),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 12))
    ]);
  }
}
