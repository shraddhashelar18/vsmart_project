import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../core/utils.dart';

class StudentDashboardScreen extends StatefulWidget {
  final String studentId;
  const StudentDashboardScreen({super.key, required this.studentId});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  Map<String, dynamic>? dashboardData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    final data = await ApiService.getStudentDashboard(widget.studentId);
    setState(() {
      dashboardData = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Dashboard")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Total Classes: ${dashboardData!['totalClasses']}"),
                  Text("Attended: ${dashboardData!['attendedClasses']}"),
                  Text(
                    "Percentage: ${formatPercentage(dashboardData!['percentage'])}",
                  ),
                  Text("Threshold: ${dashboardData!['threshold']}"),
                  Text(
                    dashboardData!['lowAttendance']
                        ? "⚠ Low Attendance"
                        : "Good Attendance",
                  ),
                ],
              ),
            ),
    );
  }
}
