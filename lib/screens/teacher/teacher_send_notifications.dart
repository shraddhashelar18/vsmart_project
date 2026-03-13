import 'package:flutter/material.dart';
import '../../services/teacher_notification_service.dart';

enum NotifyType {
  wholeStudents,
  wholeParents,
  selectedStudents,
  selectedParents,
}

class TeacherSendNotifications extends StatefulWidget {
  final String className;
  final String subject;

  const TeacherSendNotifications({
    Key? key,
    required this.className,
    required this.subject,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  _TeacherSendNotificationsState createState() =>
      _TeacherSendNotificationsState();
}

class _TeacherSendNotificationsState extends State<TeacherSendNotifications> {
  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> parents = [];
  bool isLoading = true;
  final msgCtrl = TextEditingController();
  final TeacherNotificationService _service = TeacherNotificationService();
  NotifyType notifyType = NotifyType.wholeStudents;
  List<String> selectedRecipients = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    msgCtrl.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    try {
      print("Loading students...");
      students = await _service.getStudentsByClass(widget.className);

      print("Students loaded: ${students.length}");

      print("Loading parents...");
      parents = await _service.getParentsByClass(widget.className);

      print("Parents loaded: ${parents.length}");
    } catch (e) {
      print("Error: $e");
    }

    setState(() {
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
      appBar: AppBar(
        backgroundColor: TeacherSendNotifications.green,
        title: Text("Notify ${widget.className} - ${widget.subject}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Message",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
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
            const SizedBox(height: 20),
            const Text("Send To",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            DropdownButtonFormField<NotifyType>(
              value: notifyType,
              items: const [
                DropdownMenuItem(
                  value: NotifyType.wholeStudents,
                  child: Text("Whole Class (Students)"),
                ),
                DropdownMenuItem(
                  value: NotifyType.wholeParents,
                  child: Text("Whole Class (Parents)"),
                ),
                DropdownMenuItem(
                  value: NotifyType.selectedStudents,
                  child: Text("Selected Students"),
                ),
                DropdownMenuItem(
                  value: NotifyType.selectedParents,
                  child: Text("Selected Parents"),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  notifyType = v!;
                  selectedRecipients.clear();
                });
              },
            ),
            const SizedBox(height: 10),
            if (notifyType == NotifyType.selectedStudents ||
                notifyType == NotifyType.selectedParents)
              Expanded(
                child: ListView.builder(
                  itemCount: notifyType == NotifyType.selectedStudents
                      ? students.length
                      : parents.length,
                  itemBuilder: (_, i) {
                    final list = notifyType == NotifyType.selectedStudents
                        ? students
                        : parents;

                    final id = list[i]['user_id'].toString();

                    return CheckboxListTile(
                      value: selectedRecipients.contains(id),
                      title: Text(
                        notifyType == NotifyType.selectedParents
                            ? list[i]['student_name']
                            : list[i]['full_name'],
                      ),
                      subtitle: notifyType == NotifyType.selectedStudents
                          ? Text("Roll No: ${list[i]['roll_no']}")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Parent: ${list[i]['parent_name']}"),
                                Text("Roll No: ${list[i]['roll_no']}"),
                              ],
                            ),
                      onChanged: (v) {
                        setState(() {
                          if (v == true) {
                            selectedRecipients.add(id);
                          } else {
                            selectedRecipients.remove(id);
                          }
                        });
                      },
                    );
                  },
                ),
              )
            else
              const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TeacherSendNotifications.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                if (msgCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Message cannot be empty")));
                  return;
                }

                if ((notifyType == NotifyType.selectedStudents ||
                        notifyType == NotifyType.selectedParents) &&
                    selectedRecipients.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Select at least one recipient")));
                  return;
                }

                bool success = await _service.sendNotification(
                  className: widget.className,
                  subject: widget.subject,
                  message: msgCtrl.text.trim(),
                  notifyType: notifyType.name,
                  selectedRecipients: selectedRecipients,
                );

                if (success) {
                  setState(() {
                    msgCtrl.clear();
                    selectedRecipients.clear();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Notification Sent!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Failed to send notification")),
                  );
                }
              },
              child: const Text("Send", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
