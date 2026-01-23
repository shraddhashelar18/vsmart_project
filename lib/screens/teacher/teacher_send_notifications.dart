import 'package:flutter/material.dart';

class TeacherSendNotifications extends StatefulWidget {
  const TeacherSendNotifications({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  _TeacherSendNotificationsState createState() =>
      _TeacherSendNotificationsState();
}

class _TeacherSendNotificationsState extends State<TeacherSendNotifications> {
  final msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: TeacherSendNotifications.green,
          title: const Text("Send Notification")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: msgCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write notification...",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: TeacherSendNotifications.green),
              onPressed: () {
                // API SEND LATER
                msgCtrl.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Notification sent")));
              },
              child: const Text("Send", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
