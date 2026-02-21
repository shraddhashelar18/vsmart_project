import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/teacher_attendance_service.dart';

class TeacherMarkAttendance extends StatefulWidget {
  final String className;
  final String subject;

  const TeacherMarkAttendance({
    Key? key,
    required this.className,
    required this.subject,
  }) : super(key: key);

  @override
  State<TeacherMarkAttendance> createState() => _TeacherMarkAttendanceState();
}

class _TeacherMarkAttendanceState extends State<TeacherMarkAttendance> {
  static const green = Color(0xFF009846);

  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> students = [];
  int present = 0;
  int late = 0;
  int absent = 0;

  final TeacherAttendanceService _service = TeacherAttendanceService();

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    students = await _service.getStudentsByClass(widget.className);
    setState(() {});
  }

  void setStatus(int index, String status) {
    setState(() {
      students[index]["status"] = status;
      present = students.where((s) => s["status"] == "P").length;
      late = students.where((s) => s["status"] == "L").length;
      absent = students.where((s) => s["status"] == "A").length;
    });
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Take Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Class"),
            _inputBox(widget.className),
            const SizedBox(height: 10),
            _label("Subject"),
            _inputBox(widget.subject.isEmpty ? "-" : widget.subject),
            const SizedBox(height: 10),
            _label("Date"),
            GestureDetector(
              onTap: pickDate,
              child: _inputBox(
                DateFormat("dd-MM-yyyy").format(selectedDate),
                trailing: Icons.calendar_today,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _counterBox("Present", present, Colors.green),
                _counterBox("Late", late, Colors.orange),
                _counterBox("Absent", absent, Colors.red),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              "Students (${students.length})",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (_, i) {
                  final s = students[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        Text("Roll No: ${s['roll']}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade600)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _statusChip("Present", "P", s["status"] == "P",
                                Colors.green, () => setStatus(i, "P")),
                            _statusChip("Late", "L", s["status"] == "L",
                                Colors.orange, () => setStatus(i, "L")),
                            _statusChip("Absent", "A", s["status"] == "A",
                                Colors.red, () => setStatus(i, "A")),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
  final dateKey = DateFormat("yyyy-MM-dd").format(selectedDate);

  await _service.submitAttendance(
    className: widget.className,
    subject: widget.subject,
    dateKey: dateKey,
    students: students,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Attendance Submitted!")),
  );
},
                child: const Text("Submit Attendance",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helpers

  Widget _label(String text) => Text(text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500));

  Widget _inputBox(String text, {IconData? trailing}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(fontSize: 14)),
          if (trailing != null) Icon(trailing, size: 18),
        ],
      ),
    );
  }

  Widget _counterBox(String title, int count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(count.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: color)),
            const SizedBox(height: 4),
            Text(title,
                style: TextStyle(fontSize: 12, color: color.withOpacity(0.9))),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String label, String key, bool selected, Color color,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? color.withOpacity(0.16) : Colors.grey.shade200,
          border: Border.all(color: selected ? color : Colors.transparent),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected ? color : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12)),
      ),
    );
  }
}

