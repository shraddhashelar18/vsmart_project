import 'package:flutter/material.dart';
import 'notifications_screen.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  static const Color green = Color(0xFF009846);

  // ===== MOCK DATA → LATER FROM BACKEND =====
  final List<Map<String, dynamic>> children = const [
    {
      "name": "Shrusti Kadam",
      "initials": "SK",
      "class": "IF6KA",
      "attendance": 0.94,
      "grade": "A",
      "avg": "92%",
      "weak": ["Java", "Python"]
    },
    {
      "name": "Shraddha Shelar",
      "initials": "SS",
      "class": "IF6KA",
      "attendance": 0.38,
      "grade": "B",
      "avg": "85%",
      "weak": ["C", "C++"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: AppBar(
          backgroundColor: green,
          elevation: 0,
          flexibleSpace: const Padding(
            padding: EdgeInsets.fromLTRB(16, 42, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Parent Dashboard",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Welcome back, Priya",
                    style: TextStyle(color: Colors.white70))
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
                      builder: (_) => const NotificationsScreen()),
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
            const Text("Your Children",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children.map((c) => _childCard(c)),
            const SizedBox(height: 24),
            const Text("Overall Performance",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children.map((c) => _overallCard(c)),
            const SizedBox(height: 24),
            const Text("Notifications",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _notification("Low attendance warning"),
            _notification("Parent meeting scheduled"),
          ],
        ),
      ),
    );
  }

  // ================= CHILD CARD =================
  Widget _childCard(Map c) {
    bool good = c["attendance"] >= 0.9;

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
                  backgroundColor: green,
                  child: Text(c["initials"],
                      style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c["name"],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(c["class"],
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey))
                      ]),
                ),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: green.withOpacity(0.15),
                  child: Text(c["grade"],
                      style: const TextStyle(
                          color: green, fontWeight: FontWeight.bold)),
                )
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Attendance"),
                Text("${(c["attendance"] * 100).toInt()}%",
                    style: TextStyle(
                        color: good ? green : Colors.red,
                        fontWeight: FontWeight.bold))
              ],
            ),

            const SizedBox(height: 6),

            LinearProgressIndicator(
              value: c["attendance"],
              color: good ? green : Colors.red,
              minHeight: 6,
            ),

            const SizedBox(height: 12),

            // NEEDS IMPROVEMENT
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
                  const Text("Needs Improvement",
                      style:
                          TextStyle(color: green, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: c["weak"]
                        .map<Widget>((s) => Chip(label: Text(s)))
                        .toList(),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _BottomIcon(icon: Icons.menu_book, label: "Subjects"),
                _BottomIcon(icon: Icons.star, label: "Grades"),
                _BottomIcon(icon: Icons.person, label: "Profile"),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ================= OVERALL =================
  Widget _overallCard(Map c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: green, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(c["name"],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Text(c["avg"],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
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
