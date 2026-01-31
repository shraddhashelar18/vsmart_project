import 'package:flutter/material.dart';

class ResultControlScreen extends StatefulWidget {
  const ResultControlScreen({Key? key}) : super(key: key);

  @override
  State<ResultControlScreen> createState() => _ResultControlScreenState();
}

class _ResultControlScreenState extends State<ResultControlScreen> {
  static const Color primaryGreen = Color(0xFF009846);

  /// MOCK DATA (later replace with backend)
  /// semester -> controls
  final Map<int, Map<String, bool>> semesterControl = {
    1: {
      "finalDeclared": true,
      "uploadAllowed": false,
      "reuploadAllowed": false,
    },
    2: {
      "finalDeclared": true,
      "uploadAllowed": false,
      "reuploadAllowed": false,
    },
    3: {
      "finalDeclared": true,
      "uploadAllowed": true,
      "reuploadAllowed": false,
    },
    4: {
      "finalDeclared": false,
      "uploadAllowed": false,
      "reuploadAllowed": false,
    },
    5: {
      "finalDeclared": false,
      "uploadAllowed": false,
      "reuploadAllowed": false,
    },
    6: {
      "finalDeclared": false,
      "uploadAllowed": false,
      "reuploadAllowed": false,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result Control"),
        backgroundColor: primaryGreen,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: semesterControl.entries.map((entry) {
          final semester = entry.key;
          final data = entry.value;

          return _semesterCard(
            semester: semester,
            data: data,
          );
        }).toList(),
      ),
    );
  }

  // ---------------- UI COMPONENTS ----------------

  Widget _semesterCard({
    required int semester,
    required Map<String, bool> data,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Semester $semester",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _switchTile(
              title: "Final Result Declared",
              value: data["finalDeclared"]!,
              onChanged: (v) {
                setState(() {
                  data["finalDeclared"] = v;

                  // auto-disable upload if result not declared
                  if (!v) {
                    data["uploadAllowed"] = false;
                    data["reuploadAllowed"] = false;
                  }
                });
              },
            ),
            _switchTile(
              title: "Allow Marksheet Upload",
              value: data["uploadAllowed"]!,
              onChanged: data["finalDeclared"]!
                  ? (v) {
                      setState(() {
                        data["uploadAllowed"] = v;

                        if (!v) {
                          data["reuploadAllowed"] = false;
                        }
                      });
                    }
                  : null,
            ),
            _switchTile(
              title: "Allow Re-upload",
              value: data["reuploadAllowed"]!,
              onChanged: data["uploadAllowed"]!
                  ? (v) {
                      setState(() {
                        data["reuploadAllowed"] = v;
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({
    required String title,
    required bool value,
    ValueChanged<bool>? onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: primaryGreen,
    );
  }
}
