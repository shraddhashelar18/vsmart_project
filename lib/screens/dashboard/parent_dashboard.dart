import 'package:flutter/material.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  static const Color green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          backgroundColor: const Color(0xFF009846),
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Parent Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Welcome back, Priya",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              "Your Children",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // rest unchanged

            const SizedBox(height: 12),

            _childDetailCard(
              initials: "SK",
              name: "Shrusti Kadam",
              className: "IF6KA",
              attendance: 0.94,
              grade: "A",
              weakSubjects: ["Java", "Python"],
            ),

            const SizedBox(height: 16),

            _childDetailCard(
              initials: "SS",
              name: "Shraddha Shelar",
              className: "IF6KA",
              attendance: 0.38,
              grade: "B",
              weakSubjects: ["C", "C++"],
            ),

            const SizedBox(height: 24),

            // ========= OVERALL PERFORMANCE =========
            const Text(
              "Overall Performance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _overallCard(
              initials: "SK",
              name: "Shrusti Kadam",
              attendance: "94%",
              score: "92%",
              grade: "A",
            ),
            const SizedBox(height: 12),
            _overallCard(
              initials: "SS",
              name: "Shraddha Shelar",
              attendance: "38%",
              score: "85%",
              grade: "B",
            ),

            const SizedBox(height: 24),

            // ========= NOTIFICATIONS =========
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "View All",
                  style: TextStyle(color: green),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _notification(
              icon: Icons.warning_amber,
              title: "Low attendance warning",
              subtitle: "Shrusti's attendance dropped below 90%",
            ),
            _notification(
              icon: Icons.event,
              title: "Parent-Teacher Meeting",
              subtitle: "Scheduled for Dec 20, 2025 at 3:00 PM",
            ),
            _notification(
              icon: Icons.school,
              title: "Exam Schedule Released",
              subtitle: "Final exams start from Jan 10, 2026",
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _welcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome back, Priya", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text(
            "Parent Dashboard",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ================= CHILD DETAIL CARD =================
  Widget _childDetailCard({
    required String initials,
    required String name,
    required String className,
    required double attendance,
    required String grade,
    required List<String> weakSubjects,
  }) {
    final bool good = attendance >= 0.9;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: green,
                child: Text(
                  initials,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(className,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 14,
                backgroundColor: green.withOpacity(0.1),
                child: Text(
                  grade,
                  style: const TextStyle(
                      color: green, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: green),
                  SizedBox(width: 6),
                  Text("Attendance"),
                ],
              ),
              Text(
                "${(attendance * 100).toInt()}%",
                style: TextStyle(
                  color: good ? green : const Color.fromARGB(255, 255, 7, 7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: attendance,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            color: good ? green : Colors.redAccent,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 14),
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Color(0xFFE8F5E9), // light green background
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Row(
        children: [
          Icon(
            Icons.trending_down,
            size: 18,
            color: Color(0xFF2E7D32), // dark green
          ),
          SizedBox(width: 6),
          Text(
            "Needs Improvement",
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: weakSubjects
            .map(
              (s) => Chip(
                label: Text(
                  s,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                  ),
                ),
                backgroundColor: Color(0xFFC8E6C9),
              ),
            )
            .toList(),
      )
    ],
  ),
),
const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _BottomIcon(icon: Icons.menu_book, label: "Subjects"),
              _BottomIcon(icon: Icons.grade, label: "Grades"),
              _BottomIcon(icon: Icons.person, label: "Profile"),
            ],
          ),
        ],
      ),
    );
  }

  // ================= OVERALL CARD =================
  Widget _overallCard({
    required String initials,
    required String name,
    required String attendance,
    required String score,
    required String grade,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: green.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(initials,
                    style: const TextStyle(
                        color: green, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Text(name,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stat(attendance, "Attendance"),
              _stat(score, "Avg Score"),
              _stat(grade, "Grade"),
            ],
          )
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  // ================= NOTIFICATION =================
  Widget _notification({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: green.withOpacity(0.1),
            child: Icon(icon, color: green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
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
    return Column(
      children: [
        Icon(icon, color: ParentDashboard.green),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
