import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';
import 'hod_student_years.dart';

class HodStudents extends StatelessWidget {
  final String department;
  const HodStudents({Key? key, required this.department}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Students"),
      ),
      bottomNavigationBar:
          HodBottomNav(currentIndex: 1, department: department),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Year",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _yearButton(context, "FY", department),
            _yearButton(context, "SY", department),
            _yearButton(context, "TY", department),
          ],
        ),
      ),
    );
  }

  Widget _yearButton(BuildContext context, String year, String department) {
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
                builder: (_) => HodStudentYears(
                  year: year,
                  department: department,
                ),
              ),
            );
          },
          child: Text(year, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
