import 'dart:typed_data';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:flutter/material.dart';
import '../../services/teacher_marks_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';

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

  final List<String> exams = ["CT1", "CT2"];
  String selectedExam = "CT1";

  int maxMarks = 30;
  int completed = 0;
  int totalStudents = 0;
  double average = 0;

  List<Map<String, dynamic>> students = [];
  bool loading = true;

  final Map<String, Map<String, TextEditingController>> controllers = {
    "CT1": {},
    "CT2": {},
  };

  @override
  void initState() {
    super.initState();
    MediaStore.ensureInitialized();
    loadStudents();
    loadStats();
  }

  Future<void> loadStudents() async {
    final data = await _service.getStudents(
      className: widget.className,
      subject: widget.subject,
      examType: selectedExam,
    );

    students = data;

    _initControllers();

    setState(() {
      loading = false;
    });
  }

  Future<void> loadStats() async {
    final stats = await _service.getMarksStats(
      className: widget.className,
      subject: widget.subject,
      examType: selectedExam,
    );

    if (stats != null) {
      setState(() {
        maxMarks = stats["max_marks"];
        completed = stats["completed"];
        totalStudents = stats["total_students"];
        average = stats["average"].toDouble();
      });
    }
  }

  void _initControllers() {
    controllers[selectedExam] ??= {};

    for (var s in students) {
      final sid = s["user_id"].toString();
      final marks = s["marks"];

      controllers[selectedExam]![sid] =
          TextEditingController(text: marks == null ? "" : marks.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final ctrls = controllers[selectedExam]!;

    bool isPublished = false;

    if (students.isNotEmpty) {
      isPublished = students.first["status"] == "published";
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Enter Marks"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    onChanged: (v) async {
                      selectedExam = v!;
                      await loadStudents();
                      await loadStats();
                      setState(() {});
                    }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(children: [
            _statBox("$maxMarks", "Max Marks"),
            _statBox("$completed/$totalStudents", "Completed"),
            _statBox(average.toStringAsFixed(1), "Average"),
          ]),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _downloadTemplate,
                  child: const Text(
                    "Download Template",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: isPublished ? null : _uploadExcel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  child: const Text(
                    "Upload Excel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _label("Students (${students.length})"),
          const SizedBox(height: 10),
          ...students.map((s) {
            final sid = s["user_id"].toString();
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
                    enabled: !isPublished,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "0",
                      suffixText: "/$maxMarks",
                      filled: isPublished,
                      fillColor: isPublished ? Colors.grey.shade200 : null,
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
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
        ]),
      ),
    );
  }

  Future<void> _saveMarks({required bool isDraft}) async {
    List<Map<String, dynamic>> marksList = [];

    controllers[selectedExam]!.forEach((sid, controller) {
      final text = controller.text.trim();

      final student =
          students.firstWhere((s) => s["user_id"].toString() == sid);

      marksList.add({
        "user_id": int.parse(sid),
        "obtained_marks": text.isEmpty ? null : int.parse(text),
        "semester": student["current_semester"]
      });
    });

    final success = await _service.saveMarks(
      className: widget.className,
      subject: widget.subject,
      examType: selectedExam,
      totalMarks: maxMarks,
      isDraft: isDraft,
      marks: marksList,
    );

    if (success) {
      await loadStudents();
      await loadStats();
    }

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
    final ctrls = controllers[selectedExam]!;

    List<String> missingRolls = [];

    for (var s in students) {
      final sid = s["user_id"].toString();
      final roll = s["roll"];

      if (ctrls[sid]!.text.trim().isEmpty) {
        missingRolls.add(roll);
      }
    }

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

  Future<void> _downloadTemplate() async {}

  Future<void> _uploadExcel() async {}
}
