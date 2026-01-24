import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';
import '../../mock/mock_teacher_subjects.dart';

class EnterMarksScreen extends StatefulWidget {
  final int teacherId;
  final String className;
  final String subject; // will be set from dashboard in future

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

  String? selectedSubject;
  String selectedExam = "CT-1";
  int maxMarks = 50;

  final List<String> exams = ["CT-1", "CT-2"];
  final ScrollController _scrollCtrl = ScrollController();

  Map<String, String> enteredMarks = {};

  @override
  void initState() {
    super.initState();
    selectedSubject = widget.subject.isNotEmpty ? widget.subject : null;
  }

  @override
  Widget build(BuildContext context) {
    final students = mockStudents[widget.className] ?? [];
    final subjects =
        mockTeacherSubjects[widget.teacherId]?[widget.className] ?? [];

    /// Assign subject if auto-select possible
    if (selectedSubject == null && subjects.length == 1) {
      selectedSubject = subjects.first;
    }

    /// Marks config
    maxMarks = (selectedExam == "CT-1" || selectedExam == "CT-2") ? 50 : 100;

    int completed =
        enteredMarks.values.where((v) => v.trim().isNotEmpty).length;
    double avg = completed > 0
        ? enteredMarks.values
                .map((v) => double.tryParse(v) ?? 0)
                .fold(0.0, (a, b) => a + b) /
            completed
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Enter Marks"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("Class"),
                        Text(widget.className,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 14),
                        _label("Subject"),
                        if (subjects.length <= 1)
                          Text(selectedSubject ?? "-",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600))
                        else
                          DropdownButtonFormField(
                            value: selectedSubject,
                            items: subjects
                                .map((s) =>
                                    DropdownMenuItem(value: s, child: Text(s)))
                                .toList(),
                            decoration: _dropdownDeco(),
                            onChanged: (v) =>
                                setState(() => selectedSubject = v),
                          ),
                        const SizedBox(height: 14),
                        _label("Exam Type"),
                        DropdownButtonFormField(
                          value: selectedExam,
                          items: exams
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          decoration: _dropdownDeco(),
                          onChanged: (v) => setState(() => selectedExam = v!),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// STATS
                  Row(
                    children: [
                      _statBox(
                          title: "$maxMarks",
                          subtitle: "Max Marks",
                          icon: Icons.bookmark),
                      _statBox(
                          title: "$completed/${students.length}",
                          subtitle: "Completed",
                          icon: Icons.check_circle),
                      _statBox(
                          title: avg.toStringAsFixed(1),
                          subtitle: "Average",
                          icon: Icons.bar_chart),
                    ],
                  ),

                  const SizedBox(height: 22),

                  _label("Students (${students.length})"),
                  const SizedBox(height: 10),

                  ...students.map((s) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                  Text("Roll No: ${s['roll']}",
                                      style: TextStyle(
                                          color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 85,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "0", suffixText: "/$maxMarks"),
                                onChanged: (v) =>
                                    setState(() => enteredMarks[s['id']] = v),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: green,
                side: BorderSide(color: green),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () => print("Draft => $enteredMarks"),
              child: const Text("Save as Draft"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: selectedSubject == null
                  ? null
                  : () => print(
                      "Published => $enteredMarks ($selectedExam - $selectedSubject)"),
              child: const Text("Publish Marks"),
            ),
          ],
        ),
      ),
    );
  }

  /// Helpers UI
  InputDecoration _dropdownDeco() => InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      );

  Widget _label(String t) => Text(t,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14));

  Widget _sectionCard({required Widget child}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: child,
      );

  Widget _statBox(
          {required String title,
          required String subtitle,
          required IconData icon}) =>
      Expanded(
        child: Container(
          height: 72,
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Icon(icon, size: 20, color: green),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
      );
}
