import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';

class EnterMarksScreen extends StatefulWidget {
  final String className;

  const EnterMarksScreen({Key? key, required this.className}) : super(key: key);

  @override
  State<EnterMarksScreen> createState() => _EnterMarksScreenState();
}

class _EnterMarksScreenState extends State<EnterMarksScreen> {
  static const green = Color(0xFF009846);

  String examType = "Mid Term (50)";
  final List<String> examTypes = [
    "Mid Term (50)",
    "Final Exam (100)",
    "Unit Test (25)"
  ];

  Map<String, String> enteredMarks = {};

  @override
  Widget build(BuildContext context) {
    final students = mockStudents[widget.className] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("Enter Marks (${widget.className})"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Exam Type",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            DropdownButtonFormField(
              value: examType,
              items: examTypes
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => examType = v.toString()),
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 14),
            Text("Students (${students.length})",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (_, i) {
                  final s = students[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(s['name']),
                      subtitle: Text("Roll No: ${s['roll']}"),
                      trailing: SizedBox(
                        width: 80,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "0"),
                          onChanged: (v) => enteredMarks[s['id']] = v,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  minimumSize: const Size(double.infinity, 48)),
              onPressed: () {
                // 🔥 BACKEND CALL HERE
                print("Submit marks: $enteredMarks for $examType");
              },
              child: const Text("Publish Marks",
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    );
  }
}
