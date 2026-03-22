import 'package:flutter/material.dart';
import '../../services/result_service.dart';

class UploadStatusScreen extends StatefulWidget {
  const UploadStatusScreen({Key? key}) : super(key: key);

  @override
  State<UploadStatusScreen> createState() => _UploadStatusScreenState();
}

class _UploadStatusScreenState extends State<UploadStatusScreen> {
  List<String> departments = [];
  List<String> classes = [];
  List students = [];

  String? selectedDept;
  String? selectedClass;

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  Future loadDepartments() async {
    departments = await ResultService.getDepartments();

    setState(() {});
  }

  Future loadClasses() async {
    classes = await ResultService.getClasses(selectedDept!);

    selectedClass = null;
    students = [];

    setState(() {});
  }

  Future loadStudents() async {
    students = await ResultService.getUploadStatus(selectedClass!);
    print("STUDENTS: $students");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Marksheet Upload Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Department Dropdown
            DropdownButtonFormField<String>(
              hint: const Text("Select Department"),
              value: selectedDept,
              items: departments.map((d) {
                return DropdownMenuItem(
                  value: d,
                  child: Text(d),
                );
              }).toList(),
              onChanged: (v) async {
                setState(() {
                  selectedDept = v;
                });

                await loadClasses();
              },
            ),

            const SizedBox(height: 10),

            /// Class Dropdown
            DropdownButtonFormField<String>(
              hint: const Text("Select Class"),
              value: selectedClass,
              items: classes.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text(c),
                );
              }).toList(),
              onChanged: (v) async {
                setState(() {
                  selectedClass = v;
                });

                await loadStudents();
              },
            ),

            const SizedBox(height: 20),

            /// Student List
           Expanded(
              child: students == null || students.isEmpty
                  ? const Center(child: Text("No data"))
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final s = students[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(s["full_name"] ?? "No Name"),
                           trailing: (s["marks_uploaded"].toString() == "1")
                                ? const Text(
                                    "Uploaded",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const Text(
                                    "Not Uploaded",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
