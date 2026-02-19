import 'package:flutter/material.dart';

class PerformanceReport extends StatefulWidget {
  const PerformanceReport({Key? key}) : super(key: key);

  @override
  State<PerformanceReport> createState() => _PerformanceReportState();
}

class _PerformanceReportState extends State<PerformanceReport> {
  static const green = Color(0xFF009846);

  String selectedDept = "IF";
  String selectedClass = "IF1KA";
  String selectedExam = "CT1";
  bool isCT1Conducted = true;
  bool isCT2Conducted = false;


  // ---------- DUMMY DATA (REPLACE WITH API LATER) ----------
  List<Map<String, dynamic>> students = [
    {
      "name": "Emma Johnson",
      "ct1_total": 126,
      "ct2_total": null, // null = not conducted
      "max": 150
    },
    {
      "name": "Liam Smith",
      "ct1_total": "ABSENT",
      "ct2_total": null,
      "max": 150
    },
    {"name": "Olivia Brown", "ct1_total": 140, "ct2_total": null, "max": 150},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Performance Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _dropdown("Department", selectedDept, ["IT", "CO", "EJ"],
                (v) => setState(() => selectedDept = v!)),
            _dropdown(
                "Class",
                selectedClass,
                ["IF1KA", "IF1KB", "CO1KA", "EJ1KA"],
                (v) => setState(() => selectedClass = v!)),
           Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DropdownButtonFormField<String>(
                value: selectedExam,
                decoration: InputDecoration(
                  labelText: "Exam",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: isCT1Conducted ? "CT1" : null,
                    child: Text(
                      "CT1",
                      style: TextStyle(
                        color: isCT1Conducted ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: isCT2Conducted ? "CT2" : null,
                    child: Text(
                      "CT2",
                      style: TextStyle(
                        color: isCT2Conducted ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
                onChanged: (v) {
                  if (v == null) return; // disabled click ignore
                  setState(() => selectedExam = v);
                },
              ),
            ),

            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: students.map((s) {
                  return _studentCard(s);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- DROPDOWN ----------
  Widget _dropdown(String label, String value, List<String> items,
      Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  // ---------- STUDENT CARD ----------
  Widget _studentCard(Map<String, dynamic> s) {
    dynamic marks = selectedExam == "CT1" ? s["ct1_total"] : s["ct2_total"];
    int max = s["max"];

    String displayText;
    Color color = Colors.green;

    if (marks == null) {
      displayText = "Not Conducted";
      color = Colors.grey;
    } else if (marks == "ABSENT") {
      displayText = "Absent";
      color = Colors.red;
    } else {
      int percent = ((marks / max) * 100).round();
      displayText = "$marks / $max   ($percent%)";
      color = percent < 40 ? Colors.red : Colors.green;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFEAF7F1),
          child: Icon(Icons.person, color: green),
        ),
        title: Text(
          s["name"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          displayText,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
