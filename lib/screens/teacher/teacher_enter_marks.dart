import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';

class EnterMarksScreen extends StatefulWidget {
  final int teacherId;
  final String className;
  final String subject;

  const EnterMarksScreen({
    Key? key,
    required this.teacherId,
    required this.className,
    required this.subject,
  }) : super(key: key);

  @override
  State<EnterMarksScreen> createState() => _EnterMarksScreenState();
}

class _EnterMarksScreenState extends State<EnterMarksScreen> {
  static const green = Color(0xFF009846);

  final List<String> exams = ["CT-1", "CT-2"];
  String selectedExam = "CT-1";
  int maxMarks = 30;

  Map<String, String> enteredMarks = {};

  @override
  Widget build(BuildContext context) {
    final students = mockStudents[widget.className] ?? [];
    final int studentCount = students.length;

    int completed =
        enteredMarks.values.where((v) => v.trim().isNotEmpty).length;
    double avg = completed > 0
        ? enteredMarks.values
                .map((v) => (int.tryParse(v) ?? 0))
                .fold(0, (a, b) => a + b) /
            completed
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(backgroundColor: green, title: const Text("Enter Marks")),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    _label("Class"),
                    Text(widget.className,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _label("Subject"),
                    Text(widget.subject,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _label("Exam Type"),
                    DropdownButtonFormField(
                      value: selectedExam,
                      items: exams
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) {
  setState(() {
    selectedExam = v!;
    enteredMarks.clear(); // clear for new exam
  });
},
                      decoration: _fieldDeco(),
                    ),
                  ])),
              const SizedBox(height: 16),
              Row(children: [
                _statBox("$maxMarks", "Max Marks"),
                _statBox("$completed/$studentCount", "Completed"),
                _statBox(avg.toStringAsFixed(1), "Average"),
              ]),
              const SizedBox(height: 18),
              _label("Students ($studentCount)"),
              const SizedBox(height: 10),
              ...students.map((s) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(s['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            Text("Roll No: ${s['roll']}",
                                style: TextStyle(color: Colors.grey.shade600)),
                          ])),
                      SizedBox(
                          width: 85,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "0", suffixText: "/$maxMarks"),
                            onChanged: (v) =>
                                setState(() => enteredMarks[s['id']] = v),
                          )),
                    ]),
                  )),
            ]),
          ),
        ),
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: green,
              minimumSize: const Size(double.infinity, 50)),
          onPressed: _publishMarks,
          child: const Text("Publish Marks",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Future<void> _publishMarks() async {
    final students = mockStudents[widget.className] ?? [];

    // ---------- check overwrite ----------
    bool alreadyExists = false;
    for (var s in students) {
      final sid = s['id'];
      if (mockStudentReports[sid]?["marks"]?[widget.subject]?[selectedExam] !=
          null) {
        alreadyExists = true;
      }
    }

    if (alreadyExists) {
      bool confirm = await _askConfirm();
      if (!confirm) return;
    }

    for (var s in students) {
      final sid = s['id'];
      final int score = int.tryParse(enteredMarks[sid] ?? "") ?? 0;

      mockStudentReports.putIfAbsent(
          sid, () => {"name": s['name'], "roll": s['roll'], "marks": {}});

      // ensure student data exists
      mockStudentReports.putIfAbsent(
        sid,
        () => {"name": s["name"], "roll": s["roll"], "marks": {}},
      );

// now it's safe to access
      final data = mockStudentReports[sid] as Map;

// ensure marks level exists
      data.putIfAbsent("marks", () => {});
      final marksMap = data["marks"] as Map;

// ensure subject level exists
      marksMap.putIfAbsent(widget.subject, () => {});
      final subjectMap = marksMap[widget.subject] as Map;

// set this exam
      subjectMap[selectedExam] = {
        "score": score,
        "max": maxMarks,
      };

    }
    enteredMarks.clear();
    setState(() {});


    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$selectedExam published successfully!")));
  }

  Future<bool> _askConfirm() async {
    return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Overwrite Marks?"),
            content:
                const Text("Marks for this exam already exist. Replace them?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Overwrite")),
            ],
          ),
        ) ??
        false;
  }

  Widget _label(String t) => Text(t,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14));
  InputDecoration _fieldDeco() => InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none));
  Widget _card({required Widget child}) => Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: child);
  Widget _statBox(String title, String sub) => Expanded(
          child: Container(
        height: 70,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(sub, style: TextStyle(color: Colors.grey.shade600))
        ]),
      ));
}
//test