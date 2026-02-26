import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;

  const NotificationsScreen({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text("No notifications available"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (_, index) {
                final n = notifications[index];
                return _notificationCard(
                  title: n["title"] ?? "",
                  desc: n["message"] ?? "",
                  time: n["date"] ?? "",
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
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: green.withOpacity(0.15),
          child: const Icon(Icons.notifications, color: green),
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
      ),
    );
  }
}
