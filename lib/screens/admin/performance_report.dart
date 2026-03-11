import 'package:flutter/material.dart';
import '../../services/performance_service.dart';

class PerformanceReport extends StatefulWidget {
  const PerformanceReport({Key? key}) : super(key: key);

  @override
  State<PerformanceReport> createState() => _PerformanceReportState();
}

class _PerformanceReportState extends State<PerformanceReport> {
  static const green = Color(0xFF009846);

  final PerformanceService _service = PerformanceService();

  List<String> departments = [];
  List<String> classes = [];
List<Map<String, dynamic>> students = [];
  String? selectedDept;
  String? selectedClass;

  String selectedExam = "CT1";
  bool isCT1Conducted = true;
  bool isCT2Conducted = false;

Future<void> _loadPerformance() async {
    if (selectedClass == null) return;

    try {
      students = await _service.getPerformanceReport(
        className: selectedClass!,
        exam: selectedExam,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

      students = [];
    }

    setState(() {});
  }
  @override
  void initState() {
   
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    departments = await _service.getDepartments();

    if (departments.isNotEmpty) {
      selectedDept = departments.first;
      classes = await _service.getClasses(selectedDept!);

      if (classes.isNotEmpty) {
        selectedClass = classes.first;
      }
    }

    setState(() {});
  }

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
            _dropdown(
              "Department",
              selectedDept,
              departments,
              (v) async {
                selectedDept = v;
                classes = await _service.getClasses(selectedDept!);
                selectedClass = classes.isNotEmpty ? classes.first : null;
                setState(() {});
              },
            ),
           _dropdown(
              "Class",
              selectedClass,
              classes,
              (v) async {
                selectedClass = v;
                await _loadPerformance();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DropdownButtonFormField<String>(
                value: selectedExam,
                decoration: _inputDecoration("Exam"),
                items: [
                  DropdownMenuItem(
                    value: "CT1",
                    enabled: isCT1Conducted,
                    child: Text(
                      "CT1",
                      style: TextStyle(
                          color: isCT1Conducted ? Colors.black : Colors.grey),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "CT2",
                    enabled: isCT2Conducted,
                    child: Text(
                      "CT2",
                      style: TextStyle(
                          color: isCT2Conducted ? Colors.black : Colors.grey),
                    ),
                  ),
                ],
               onChanged: (v) async {
                  if (v == null) return;

                  selectedExam = v;
                  await _loadPerformance();
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

  Widget _dropdown(String label, String? value, List<String> items,
      Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: _inputDecoration(label),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _studentCard(Map<String, dynamic> s) {
    dynamic marks = selectedExam == "CT1" ? s["ct1_total"] : s["ct2_total"];

    int max = int.tryParse(s["max"].toString()) ?? 0;

    String displayText;
    Color color = Colors.green;

    if (marks == null) {
      displayText = "Not Conducted";
      color = Colors.grey;
    } else if (marks == "ABSENT") {
      displayText = "Absent";
      color = Colors.red;
    } else {
      int obtained = int.tryParse(marks.toString()) ?? 0;

      int percent = max == 0 ? 0 : ((obtained / max) * 100).round();

      displayText = "$obtained / $max   ($percent%)";
      color = percent < 40 ? Colors.red : Colors.green;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
