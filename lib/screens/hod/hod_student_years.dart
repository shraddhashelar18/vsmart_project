import 'package:flutter/material.dart';
import 'hod_student_semesters.dart';

class HodStudentYears extends StatelessWidget {
  final String year;
  final String department;

  const HodStudentYears(
      {Key? key, required this.year, required this.department})
      : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    List<String> semesters = [];

    if (year == "FY") semesters = ["SEM 1", "SEM 2"];
    if (year == "SY") semesters = ["SEM 3", "SEM 4"];
    if (year == "TY") semesters = ["SEM 5", "SEM 6"];

    return Scaffold(
      appBar: AppBar(
        title: Text("$year - Select Semester"),
        backgroundColor: green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: semesters
              .map((sem) => Padding(
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
                              builder: (_) => HodStudentSemesters(
                                semester: sem,
                                year: year,
                                department: department,
                              ),
                            ),
                          );
                        },
                        child: Text(sem,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
