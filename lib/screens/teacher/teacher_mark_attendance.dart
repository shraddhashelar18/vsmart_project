import 'package:flutter/material.dart';

class TeacherMarkAttendance extends StatefulWidget {
  final String className;

  const TeacherMarkAttendance({Key? key, required this.className})
      : super(key: key);

  @override
  State<TeacherMarkAttendance> createState() => _TeacherMarkAttendanceState();
}

class _TeacherMarkAttendanceState extends State<TeacherMarkAttendance> {
  static const green = Color(0xFF009846);

  // TODO BACKEND: fetch attendance students list
  final List<Map<String, dynamic>> students = [
    {"name": "Aarav Sharma", "roll": "001", "status": null},
    {"name": "Ananya Patel", "roll": "002", "status": null},
    {"name": "Arjun Kumar", "roll": "003", "status": null},
    {"name": "Diya Singh", "roll": "004", "status": null},
    {"name": "Ishaan Verma", "roll": "005", "status": null},
  ];

  int present = 0;
  int absent = 0;
  int late = 0;

  void setStatus(int index, String status) {
    setState(() {
      students[index]["status"] = status;
      present = students.where((s) => s["status"] == "P").length;
      absent = students.where((s) => s["status"] == "A").length;
      late = students.where((s) => s["status"] == "L").length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Mark Attendance"),
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          // CLASS + DATE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Class: ${widget.className}",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text("Date: "),
                    Text(DateTime.now().toString().split(" ").first,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // COUNTERS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _countBox("Present", present, Colors.green),
                const SizedBox(width: 8),
                _countBox("Absent", absent, Colors.red),
                const SizedBox(width: 8),
                _countBox("Late", late, Colors.orange),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // STUDENTS LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: students.length,
              itemBuilder: (_, i) {
                final s = students[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(s["name"]),
                    subtitle: Text("Roll No: ${s["roll"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _statusChip("P", s["status"] == "P", Colors.green, () => setStatus(i, "P")),
                        const SizedBox(width: 6),
                        _statusChip("A", s["status"] == "A", Colors.red, () => setStatus(i, "A")),
                        const SizedBox(width: 6),
                        _statusChip("L", s["status"] == "L", Colors.orange, () => setStatus(i, "L")),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // SUBMIT BUTTON
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // TODO BACKEND: Send attendance list
                print("Attendance submitted => $students");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Attendance submitted")),
                );
              },
              child: const Text("Submit Attendance"),
            ),
          )
        ],
      ),
    );
  }

  Widget _statusChip(String label, bool selected, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.17) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? color : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? color : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _countBox(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text("$count", style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
