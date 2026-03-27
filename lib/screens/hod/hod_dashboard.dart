import 'package:flutter/material.dart';
import '../../models/user_session.dart';
import '../../services/department_service.dart';
import '../../models/department_summary.dart';
import '../../widgets/summary_card.dart';
import 'hod_bottom_nav.dart';
import 'hod_students.dart';
import 'hod_teachers.dart';
import 'hod_promoted_classes.dart';
import 'hod_detained_classes.dart';
import 'hod_atkt_classes.dart';

class HodDashboard extends StatefulWidget {
  final String department;

  const HodDashboard({super.key, required this.department});

  @override
  State<HodDashboard> createState() => _HodDashboardState();
}

class _HodDashboardState extends State<HodDashboard> {
  final DepartmentService _service = DepartmentService();

  static const green = Color(0xFF009846);

  Future<DepartmentSummary>? _summaryFuture;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  void _loadSummary() {
    setState(() {
      _summaryFuture = _service.getSummary(widget.department);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = UserSession.currentUser;
    return Scaffold(
      bottomNavigationBar: HodBottomNav(
        currentIndex: 0,
        department: widget.department,
      ),
      body: FutureBuilder<DepartmentSummary>(
        future: _summaryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text(
                        "HOD Dashboard (${widget.department})",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Welcome back, ${user?.name ?? ""}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // 🔹 Row 1 — Main Stats
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.school,
                              title: "Total Students",
                              value: data.totalStudents.toString(),
                              color: green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.person,
                              title: "Total Teachers",
                              value: data.totalTeachers.toString(),
                              color: green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 🔹 Row 2 — Academic Status
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.arrow_upward,
                              title: "Promoted",
                              value: data.promoted.toString(),
                              color: green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.trending_up,
                              title: "With ATKT",
                              value: data.promotedWithBacklog.toString(),
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.warning,
                              title: "Detained",
                              value: data.detained.toString(),
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    "Academic Actions",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _actionButton("View Students", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                HodStudents(department: widget.department),
                          ),
                        );
                      }),
                      _actionButton("View Teachers", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                HodTeachers(department: widget.department),
                          ),
                        );
                      }),
                      _actionButton("View Promoted List", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HodPromotedClasses(
                                department: widget.department),
                          ),
                        );
                      }),
                      _actionButton("View ATKT List", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HodATKTClasses(
                              department: widget.department,
                            ),
                          ),
                        );
                      }),
                      _actionButton("View Detained List", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HodDetainedClasses(
                                department: widget.department),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _actionButton(String text, VoidCallback onTap) {
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
