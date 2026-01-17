import 'package:flutter/material.dart';
import 'hod_student_classes.dart';

class HodStudentSemesters extends StatelessWidget {
  final String semester;
  final String year;
  final String department;

  const HodStudentSemesters({
    Key? key,
    required this.semester,
    required this.year,
    required this.department,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    // All sems assumed 3 divisions for now
    List<String> divisions = ["A", "B", "C"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("$semester - Select Class"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: divisions.map((div) {
            String className =
                "$department${semester.replaceAll('SEM ', '')}K-$div";

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HodStudentClasses(
                          className: className,
                          department: department,
                          semester: semester,
                        ),
                      ),
                    );
                  },
                  child: Text(className,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
