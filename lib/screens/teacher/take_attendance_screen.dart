import 'package:flutter/material.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  List<Map<String, dynamic>> students = [
    {"name": "Harshita", "present": true},
    {"name": "Shrusti", "present": false},
    {"name": "Kaveri", "present": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Take Attendance")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index]["name"]),
            trailing: Switch(
              value: students[index]["present"],
              onChanged: (val) {
                setState(() {
                  students[index]["present"] = val;
                });
              },
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Attendance Submitted")),
            );
          },
          child: const Text("Submit"),
        ),
      ),
    );
  }
}
