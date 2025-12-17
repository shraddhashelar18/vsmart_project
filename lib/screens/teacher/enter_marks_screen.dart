import 'package:flutter/material.dart';

class EnterMarksScreen extends StatefulWidget {
  const EnterMarksScreen({super.key});

  @override
  State<EnterMarksScreen> createState() => _EnterMarksScreenState();
}

class _EnterMarksScreenState extends State<EnterMarksScreen> {
  List<Map<String, dynamic>> students = [
    {"name": "Harshita", "ct1": "0", "ct2": "0", "sem": "0"},
    {"name": "Shrusti", "ct1": "0", "ct2": "0", "sem": "0"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Marks")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(students[index]["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),

                  TextField(
                    decoration: const InputDecoration(labelText: "CT1"),
                    onChanged: (v) => students[index]["ct1"] = v,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: "CT2"),
                    onChanged: (v) => students[index]["ct2"] = v,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: "Semester"),
                    onChanged: (v) => students[index]["sem"] = v,
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Marks Saved")),
            );
          },
          child: const Text("Submit Marks"),
        ),
      ),
    );
  }
}
