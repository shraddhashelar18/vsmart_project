import 'package:flutter/material.dart';
import '../../services/teacher_marks_service.dart';

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
final TeacherMarksService _service = TeacherMarksService();
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
    final students = _service.getStudentsByClass(widget.className);

    for (var exam in exams) {
      for (var s in students) {
        final sid = s["enrollment"];

        final examData = _service.getExamData(
          studentId: sid,
          subject: widget.subject,
          exam: exam,
        );

        controllers[exam]![sid] = TextEditingController(
          text: examData != null ? examData["score"].toString() : "",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 FIXED STUDENT FETCH
   final students = _service.getStudentsByClass(widget.className);

    final ctrls = controllers[selectedExam]!;
String? examStatus;

if (students.isNotEmpty) {
  final firstStudentId = students.first["enrollment"];

  final examData = _service.getExamData(
    studentId: firstStudentId,
    subject: widget.subject,
    exam: selectedExam,
  );

  examStatus = examData?["status"];
}
final bool isPublished = examStatus == "published";
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
                    enabled: examStatus != "published", // 🔒 lock editing
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "0",
                      suffixText: "/$maxMarks",
                      filled: examStatus == "published",
                      fillColor: examStatus == "published"
                          ? Colors.grey.shade200
                          : null,
                    ),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: isPublished ? null : () => _saveMarks(isDraft: true),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Save Draft"),
            ),
            const SizedBox(height: 10),
           ElevatedButton(
              onPressed: isPublished ? null : () => _confirmPublish(),
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                disabledBackgroundColor: Colors.grey.shade400,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Publish Marks",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

void _saveMarks({required bool isDraft}) {
  _service.saveMarks(
    className: widget.className,
    subject: widget.subject,
    exam: selectedExam,
    maxMarks: maxMarks,
    isDraft: isDraft,
    controllers: controllers[selectedExam]!,
  );

  setState(() {});

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isDraft
            ? "$selectedExam saved as draft"
            : "$selectedExam published successfully!",
      ),
    ),
  );
}
Future<void> _confirmPublish() async {
    final students = _service.getStudentsByClass(widget.className);

    final ctrls = controllers[selectedExam]!;

    // 🔥 Find students with empty marks
    List<String> missingRolls = [];

    for (var s in students) {
      final sid = s["enrollment"];
      final roll = s["roll"];

      if (ctrls[sid]!.text.trim().isEmpty) {
        missingRolls.add(roll);
      }
    }

    // 🔥 If any missing → show warning
    if (missingRolls.isNotEmpty) {
      final proceed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Incomplete Marks"),
          content: Text(
            "Marks not entered for Roll No: ${missingRolls.join(", ")}\n\n"
            "If you continue, blank entries will be marked as AB.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Continue"),
            ),
          ],
        ),
      );

      if (proceed != true) return;
    }

    // 🔥 If all marks entered → confirm publish
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Publish"),
        content: Text(
            "Are you sure you want to publish $selectedExam marks?\n\nOnce published, marks cannot be edited."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: green),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Publish", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _saveMarks(isDraft: false);
    }
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
