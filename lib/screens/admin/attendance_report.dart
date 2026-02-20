import 'package:flutter/material.dart';
import '../../services/attendance_service.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class StudentAttendanceCard extends StatelessWidget {
  final String name;
  final int present;
  final int total;

  const StudentAttendanceCard({
    Key? key,
    required this.name,
    required this.present,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent = (present / total) * 100;
    Color percentColor = percent >= 75 ? const Color(0xFF009846) : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFEAF7F1),
          child: Icon(Icons.person, color: Color(0xFF009846)),
        ),
        title: Text(name),
        subtitle: Text("Present: $present / $total lectures"),
        trailing: Text(
          "${percent.toStringAsFixed(0)}%",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: percentColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _AttendanceReportState extends State<AttendanceReport> {
  static const Color green = Color(0xFF009846);

  final AttendanceService _attendanceService = AttendanceService();

  List<String> departments = [];
  List<String> classes = [];
  List<String> months = [];

  String? selectedDept;
  String? selectedClass;
  String? selectedMonth;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    departments = _attendanceService.getDepartments();

    if (departments.isNotEmpty) {
      selectedDept = departments.first;
      classes = await _attendanceService.getClasses(selectedDept!);

      if (classes.isNotEmpty) {
        selectedClass = classes.first;
      }
    }

    months = await _attendanceService.getMonths();

    if (months.isNotEmpty) {
      selectedMonth = months.first;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Attendance Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedDept,
              decoration: _decoration("Department"),
              items: departments
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) async {
                selectedDept = v;
                classes = await _attendanceService.getClasses(selectedDept!);
                selectedClass = classes.isNotEmpty ? classes.first : null;
                setState(() {});
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedClass,
              decoration: _decoration("Class"),
              items: classes
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                setState(() => selectedClass = v);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedMonth,
              decoration: _decoration("Month"),
              items: months.map((m) {
                return DropdownMenuItem<String>(
                  value: m,
                  child: FutureBuilder<bool>(
                    future: _attendanceService.isMonthEnabled(m),
                    builder: (context, snapshot) {
                      final enabled = snapshot.data ?? false;

                      return Text(
                        m,
                        style: TextStyle(
                          color: enabled ? Colors.black : Colors.grey,
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              onChanged: (v) async {
                if (v == null) return;

                final enabled = await _attendanceService.isMonthEnabled(v);

                if (!enabled) return; // block selection

                setState(() => selectedMonth = v);
              },
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Students",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  StudentAttendanceCard(
                    name: "Emma Johnson",
                    present: 22,
                    total: 25,
                  ),
                  StudentAttendanceCard(
                    name: "Liam Smith",
                    present: 18,
                    total: 25,
                  ),
                  StudentAttendanceCard(
                    name: "Olivia Brown",
                    present: 24,
                    total: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
