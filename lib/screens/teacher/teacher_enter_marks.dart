import 'package:flutter/material.dart';
import '../../mock/mock_student_data.dart';
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

  /// exam → studentId → controller
  final Map<String, Map<String, TextEditingController>> controllers = {
    "CT-1": {},
    "CT-2": {},
  };

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    final students = mockStudents.entries
        .where((e) => e.value["class"] == widget.className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
            })
        .toList();

    for (var exam in exams) {
      for (var s in students) {
        final sid = s["enrollment"];

        final published =
            mockStudentReports[sid]?["marks"]?[widget.subject]?[exam];

        controllers[exam]![sid] = TextEditingController(
          text: published != null ? published["score"].toString() : "",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 FIXED STUDENT FETCH
    final students = mockStudents.entries
        .where((e) => e.value["class"] == widget.className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
            })
        .toList();

    final ctrls = controllers[selectedExam]!;

    /// ✅ Stats PER EXAM
    final values = ctrls.values
        .map((c) => int.tryParse(c.text) ?? 0)
        .where((v) => v > 0)
        .toList();

    final completed = values.length;

    final avg = values.isNotEmpty
        ? values.reduce((a, b) => a + b) / values.length
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(backgroundColor: green, title: const Text("Enter Marks")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _card(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _label("Class"),
              Text(widget.className,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _label("Subject"),
              Text(widget.subject,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _label("Exam Type"),
              DropdownButtonFormField(
                value: selectedExam,
                items: exams
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => selectedExam = v!),
              ),
            ]),
          ),

          const SizedBox(height: 16),

          /// ✅ STATS
          Row(children: [
            _statBox("$maxMarks", "Max Marks"),
            _statBox("$completed/${students.length}", "Completed"),
            _statBox(avg.toStringAsFixed(1), "Average"),
          ]),

          const SizedBox(height: 18),
          _label("Students (${students.length})"),
          const SizedBox(height: 10),

          ...students.map((s) {
            final sid = s["enrollment"];
            final controller = ctrls[sid]!;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s["name"],
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        Text("Roll No: ${s["roll"]}",
                            style: TextStyle(color: Colors.grey.shade600)),
                      ]),
                ),
                SizedBox(
                  width: 85,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "0", suffixText: "/$maxMarks"),
                    onChanged: (v) {
                      final val = int.tryParse(v);
                      if (val != null && val > maxMarks) {
                        controller.text = "";
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Marks cannot exceed $maxMarks")),
                        );
                      }
                      setState(() {});
                    },
                  ),
                ),
              ]),
            );
          }),
        ]),
      ),
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

  void _publishMarks() {
    final students = mockStudents.entries
        .where((e) => e.value["class"] == widget.className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
            })
        .toList();

    final ctrls = controllers[selectedExam]!;

    for (var s in students) {
      final sid = s["enrollment"];
      final score = int.tryParse(ctrls[sid]!.text) ?? 0;

      mockStudentReports[sid] ??= {
        "name": s["name"],
        "roll": s["roll"],
        "marks": {},
      };

      final marks = mockStudentReports[sid]!["marks"] as Map;
      marks[widget.subject] ??= {};
      marks[widget.subject][selectedExam] = {
        "score": score,
        "max": maxMarks,
      };
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$selectedExam published successfully!")),
    );
  }

  Widget _label(String t) =>
      Text(t, style: const TextStyle(fontWeight: FontWeight.w600));

  Widget _card({required Widget child}) => Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: child);

  Widget _statBox(String t, String s) => Expanded(
      child: Container(
          height: 70,
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            Text(t,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(s, style: TextStyle(color: Colors.grey.shade600)),
          ])));
}
