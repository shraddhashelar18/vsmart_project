import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';

class ResultControlScreen extends StatefulWidget {
  const ResultControlScreen({Key? key}) : super(key: key);

  @override
  State<ResultControlScreen> createState() => _ResultControlScreenState();
}

class _ResultControlScreenState extends State<ResultControlScreen> {
  bool allowMarksheetUpload = false;
  bool allowReUpload = false; // 🔥 NEW

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
              "Result Upload Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Control student marksheet upload permissions.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // -------- UPLOAD TOGGLE --------
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
                          if (!value) allowReUpload = false; // 🔒 safety
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // -------- REUPLOAD TOGGLE --------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.refresh,
                        color: Color(0xFF009846), size: 26),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        "Allow Marksheet Re-Upload",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Switch(
                      activeColor: const Color(0xFF009846),
                      value: allowReUpload,
                      onChanged: allowMarksheetUpload
                          ? (value) {
                              setState(() {
                                allowReUpload = value;
                              });
                            }
                          : null, // 🔒 disabled if upload off
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
                          ? allowReUpload
                              ? "Students can upload & re-upload marksheets."
                              : "Students can upload marksheets once."
                          : "Marksheet upload is disabled.",
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
                      "Semester control is managed from Admin Settings. "
                      "This screen only controls upload permissions.",
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

                // SEND allowMarksheetUpload + allowReUpload to backend
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
