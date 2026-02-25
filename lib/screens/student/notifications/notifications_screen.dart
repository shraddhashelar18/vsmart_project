import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../../../services/notification_service.dart';
import '../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  void loadNotifications() async {
    final studentId = AuthService.currentUserId;

    final data = await NotificationService.fetchNotifications(studentId);

    setState(() {
      notifications = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? const Center(child: Text("No notifications"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final n = notifications[index];
                    return _notificationCard(n);
                  },
                ),
    );
  }

  Widget _notificationCard(NotificationModel n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF009846),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  n.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  n.message,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  n.date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
