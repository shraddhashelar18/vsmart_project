import 'package:flutter/material.dart';
import '../../mock/mock_academics.dart'; // 🔥 ADD
 

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

  late String selectedDept;
  late String selectedClass;
  late String selectedMonth;

  // 🔹 DEPARTMENTS FROM MOCK
  List<String> get departments => mockAcademics.keys.toList();

  // 🔹 MONTHS BASED ON EVEN / ODD
 List<String> get months => activeSemType == "EVEN" ? evenMonths : oddMonths;
 


  // 🔹 CLASSES BASED ON DEPT + SEM TYPE
  List<String> getClasses(String dept) {
    final years = mockAcademics[dept]!;
    List<String> result = [];

    years.forEach((year, sems) {
      sems.forEach((semName, classList) {
        if (isSemesterAllowed(semName)) {
          result.addAll(classList);
        }
      });
    });

    return result;
  }

  @override
  void initState() {
    super.initState();

    selectedDept = departments.first;
    selectedClass = getClasses(selectedDept).first;

    selectedMonth = months.first;

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
            // 🔹 DEPARTMENT
            DropdownButtonFormField<String>(
              value: selectedDept,
              decoration: _decoration("Department"),
              items: departments
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  selectedDept = v!;
                  selectedClass = getClasses(selectedDept).first;
                });
              },
            ),

            const SizedBox(height: 12),

            // 🔹 CLASS
            DropdownButtonFormField<String>(
              value: selectedClass,
              decoration: _decoration("Class"),
              items: getClasses(selectedDept)
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                setState(() => selectedClass = v!);
              },
            ),

            const SizedBox(height: 12),

            // 🔹 MONTH
            DropdownButtonFormField<String>(
              value:
                  months.contains(selectedMonth) ? selectedMonth : months.first,

              decoration: _decoration("Month"),
              items: months.map((m) {
                final enabled = isMonthEnabled(m);

                return DropdownMenuItem(
                  value: enabled ? m : null, // null disables selection
                  child: Text(
                    m,
                    style: TextStyle(
                      color: enabled ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              }).toList(),

              onChanged: (v) {
                if (v == null) return; // disabled
                setState(() => selectedMonth = v);
              },

            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Students",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 STUDENT LIST (UNCHANGED)
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
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
