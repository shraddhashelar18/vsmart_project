import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';

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
  final msgCtrl = TextEditingController();

  String notifyType = "Whole Class"; // default
  List<String> selectedStudents = [];

  @override
  Widget build(BuildContext context) {
    final students = mockStudents[widget.className] ?? [];

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
            DropdownButtonFormField(
              value: notifyType,
              items: ["Whole Class", "Students"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  notifyType = v!;
                  selectedStudents.clear();
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 10),
            if (notifyType == "Students")
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (_, i) {
                    final s = students[i];
                    final id = s['id'];

                    return CheckboxListTile(
                      value: selectedStudents.contains(id),
                      title: Text(s['name']),
                      subtitle: Text("Roll No: ${s['roll']}"),
                      onChanged: (v) {
                        setState(() {
                          if (v == true) {
                            selectedStudents.add(id);
                          } else {
                            selectedStudents.remove(id);
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
              onPressed: () {
                if (msgCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Message cannot be empty")));
                  return;
                }

                if (notifyType == "Whole Class") {
                  print("Sending to WHOLE CLASS: ${widget.className}");
                } else {
                  print("Sending to SELECTED: $selectedStudents");
                }

                print("Message: ${msgCtrl.text}");

                msgCtrl.clear();
                selectedStudents.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Notification Sent!")));
              },
              child: const Text("Send", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
