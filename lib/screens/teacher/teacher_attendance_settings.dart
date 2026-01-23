import 'package:flutter/material.dart';

class TeacherAttendanceSettings extends StatefulWidget {
  const TeacherAttendanceSettings({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  _TeacherAttendanceSettingsState createState() =>
      _TeacherAttendanceSettingsState();
}

class _TeacherAttendanceSettingsState extends State<TeacherAttendanceSettings> {
  bool allowLate = true;
  int lateThreshold = 10; // minutes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: TeacherAttendanceSettings.green,
          title: const Text("Attendance Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Allow Late Marking"),
              value: allowLate,
              onChanged: (v) => setState(() => allowLate = v),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Late Threshold:  "),
                DropdownButton<int>(
                  value: lateThreshold,
                  items: const [
                    DropdownMenuItem(value: 5, child: Text("5 min")),
                    DropdownMenuItem(value: 10, child: Text("10 min")),
                    DropdownMenuItem(value: 15, child: Text("15 min")),
                  ],
                  onChanged: (v) => setState(() => lateThreshold = v!),
                )
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: TeacherAttendanceSettings.green),
              onPressed: () {
                // API CALL LATER
                Navigator.pop(context);
              },
              child: const Text("Save Settings",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
