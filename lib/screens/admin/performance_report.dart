import 'package:flutter/material.dart';
import '../../services/app_settings_service.dart';

class PerformanceReport extends StatefulWidget {
  const PerformanceReport({Key? key}) : super(key: key);

  @override
  State<PerformanceReport> createState() => _PerformanceReportState();
}

class _PerformanceReportState extends State<PerformanceReport> {
  static const green = Color(0xFF009846);

  final AppSettingsService _settingsService = AppSettingsService();
  String activeSemester = "EVEN";

  String selectedDept = "IF";
  String selectedClass = "";
  String selectedExam = "CT1";
  bool isCT1Conducted = true;
  bool isCT2Conducted = false;

  // 🔹 ALL CLASSES
  final List<String> allClasses = [
    "IF1KA",
    "IF1KB",
    "IF1KC",
    "IF2KA",
    "IF2KB",
    "IF2KC",
    "IF3KA",
    "IF3KB",
    "IF3KC",
    "IF4KA",
    "IF4KB",
    "IF4KC",
    "IF5KA",
    "IF5KB",
    "IF5KC",
    "IF6KA",
    "IF6KB",
    "IF6KC",
    "CO1KA",
    "CO1KB",
    "CO1KC",
    "CO2KA",
    "CO2KB",
    "CO2KC",
    "CO3KA",
    "CO3KB",
    "CO3KC",
    "CO4KA",
    "CO4KB",
    "CO4KC",
    "CO5KA",
    "CO5KB",
    "CO5KC",
    "CO6KA",
    "CO6KB",
    "CO6KC",
    "EJ1KA",
    "EJ1KB",
    "EJ1KC",
    "EJ2KA",
    "EJ2KB",
    "EJ2KC",
    "EJ3KA",
    "EJ3KB",
    "EJ3KC",
    "EJ4KA",
    "EJ4KB",
    "EJ4KC",
    "EJ5KA",
    "EJ5KB",
    "EJ5KC",
    "EJ6KA",
    "EJ6KB",
    "EJ6KC",
  ];

  // ---------- DUMMY DATA ----------
  List<Map<String, dynamic>> students = [
    {"name": "Emma Johnson", "ct1_total": 126, "ct2_total": null, "max": 150},
    {
      "name": "Liam Smith",
      "ct1_total": "ABSENT",
      "ct2_total": null,
      "max": 150
    },
    {"name": "Olivia Brown", "ct1_total": 140, "ct2_total": null, "max": 150},
  ];

  @override
  void initState() {
    super.initState();
    _loadSemester();
  }

  Future<void> _loadSemester() async {
    activeSemester = await _settingsService.getActiveSemester();
    selectedClass = _getClasses(selectedDept).first;
    setState(() {});
  }

  // 🔹 FILTER CLASSES BASED ON ACTIVE SEMESTER
  List<String> _getClasses(String dept) {
    return allClasses.where((c) {
      if (!c.startsWith(dept)) return false;

      final sem = int.parse(c[2]);

      if (activeSemester == "EVEN") {
        return sem % 2 == 0;
      } else {
        return sem % 2 != 0;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredClasses = _getClasses(selectedDept);

    if (!filteredClasses.contains(selectedClass) &&
        filteredClasses.isNotEmpty) {
      selectedClass = filteredClasses.first;
    }

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
            _dropdown(
              "Department",
              selectedDept,
              ["IF", "CO", "EJ"],
              (v) {
                selectedDept = v!;
                selectedClass = _getClasses(selectedDept).first;
                setState(() {});
              },
            ),
            _dropdown(
              "Class",
              selectedClass,
              filteredClasses,
              (v) => setState(() => selectedClass = v!),
            ),
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
                    value: "CT1",
                    enabled: isCT1Conducted,
                    child: Text(
                      "CT1",
                      style: TextStyle(
                        color: isCT1Conducted ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "CT2",
                    enabled: isCT2Conducted,
                    child: Text(
                      "CT2",
                      style: TextStyle(
                        color: isCT2Conducted ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
                onChanged: (v) {
                  if (v == null) return;
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
