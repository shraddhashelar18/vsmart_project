import 'package:flutter/material.dart';
import 'teacher_dashboard.dart';

class DepartmentSelectionScreen extends StatefulWidget {
  final List<String> departments;
  final int teacherId;
  final String teacherName; // ✅ ADD THIS

  const DepartmentSelectionScreen({
    Key? key,
    required this.departments,
    required this.teacherId,
    required this.teacherName, // ✅ ADD THIS
  }) : super(key: key);

  @override
  State<DepartmentSelectionScreen> createState() =>
      _DepartmentSelectionScreenState();
}

class _DepartmentSelectionScreenState extends State<DepartmentSelectionScreen> {
  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Department"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Department",
              ),
              items: widget.departments
                  .map(
                    (d) => DropdownMenuItem(
                      value: d,
                      child: Text(d),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                setState(() {
                  selectedDepartment = v;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedDepartment == null
                  ? null
                  : () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TeacherDashboard(
  activeDepartment: selectedDepartment!,
  teacherId: widget.teacherId,
  
  departments: widget.departments, teacherName: widget.teacherName, // ✅ ADD THIS
),

                        ),
                      );
                    },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}
