import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    print("NOTIFICATION SCREEN OPENED");

    // 🔹 DUMMY DATA (REPLACE WITH BACKEND LATER)
    final List<Map<String, String>> notifications = [
      {
        "title": "Low attendance warning",
        "desc": "Shrusti's attendance dropped below 90%",
        "time": "2 hours ago",
        "type": "warning"
      },
      {
        "title": "Parent-Teacher Meeting",
        "desc": "Scheduled for Dec 20, 2025 at 3:00 PM",
        "time": "5 hours ago",
        "type": "meeting"
      },
      {
        "title": "Exam Schedule Released",
        "desc": "Final exams start from Jan 10, 2026",
        "time": "2 days ago",
        "type": "exam"
      },
      {
        "title": "Holiday Notice",
        "desc": "College closed on Friday",
        "time": "4 days ago",
        "type": "info"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (_, index) {
          final n = notifications[index];
          return _notificationCard(
            title: n["title"]!,
            desc: n["desc"]!,
            time: n["time"]!,
            type: n["type"]!,
          );
        },
      ),
    );
  }

  // ---------- CARD ----------
  Widget _notificationCard({
    required String title,
    required String desc,
    required String time,
    required String type,
  }) {
    IconData icon;
    Color color;

    switch (type) {
      case "warning":
        icon = Icons.warning_amber_rounded;
        color = Colors.orange;
        break;
      case "meeting":
        icon = Icons.calendar_month;
        color = Colors.blue;
        break;
      case "exam":
        icon = Icons.school;
        color = Colors.green;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(desc),
            const SizedBox(height: 6),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }
}
