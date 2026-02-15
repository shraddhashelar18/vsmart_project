import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';

class ResultControlScreen extends StatefulWidget {
  const ResultControlScreen({Key? key}) : super(key: key);

  @override
  State<ResultControlScreen> createState() => _ResultControlScreenState();
}

class _ResultControlScreenState extends State<ResultControlScreen> {
  bool allowMarksheetUpload = false;

  // ODD = 1,3,5 | EVEN = 2,4,6
  String activeGroup = "ODD";

  void _toggleGroup() {
    setState(() {
      activeGroup = activeGroup == "ODD" ? "EVEN" : "ODD";
    });
  }

  String get groupLabel {
    return activeGroup == "ODD" ? "Semesters 1, 3, 5" : "Semesters 2, 4, 6";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Result Control"),
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Semester Result Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Control active semester group & marksheet upload.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // -------- ACTIVE GROUP CARD --------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.school,
                        color: Color(0xFF009846), size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Active Group: $groupLabel",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF009846),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _toggleGroup,
                      child: const Text("Switch"),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------- MARKSHEET TOGGLE --------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.upload_file,
                        color: Color(0xFF009846), size: 28),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        "Enable Marksheet Upload",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Switch(
                      activeColor: const Color(0xFF009846),
                      value: allowMarksheetUpload,
                      onChanged: (value) {
                        setState(() {
                          allowMarksheetUpload = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------- STATUS BOX --------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: allowMarksheetUpload
                    ? Colors.green.shade50
                    : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    allowMarksheetUpload ? Icons.check_circle : Icons.cancel,
                    color: allowMarksheetUpload ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      allowMarksheetUpload
                          ? "Students CAN upload marksheets."
                          : "Marksheet upload is DISABLED.",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: allowMarksheetUpload ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // -------- NOTE --------
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7F1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info, color: Color(0xFF009846)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "KT students remain in their semester. "
                      "Semester group only controls marksheet upload visibility.",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // -------- SAVE --------
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Result settings saved"),
                  ),
                );

                // SEND activeGroup + allowMarksheetUpload to backend
              },
              child: const Text(
                "Save Settings",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
