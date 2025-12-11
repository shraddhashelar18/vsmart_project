import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../core/utils.dart';

class ClassDashboardScreen extends StatefulWidget {
  final String classId;
  const ClassDashboardScreen({super.key, required this.classId});

  @override
  State<ClassDashboardScreen> createState() => _ClassDashboardScreenState();
}

class _ClassDashboardScreenState extends State<ClassDashboardScreen> {
  List<Map<String, dynamic>> studentStats = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchClassStats();
  }

  Future<void> fetchClassStats() async {
    final data = await ApiService.getClassDashboard(widget.classId);
    setState(() {
      studentStats = List<Map<String, dynamic>>.from(data['students']);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Class Dashboard")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: studentStats.length,
              itemBuilder: (context, index) {
                final s = studentStats[index];
                return ListTile(
                  title: Text(s['studentId']),
                  subtitle: Text(
                    "Attended: ${s['attended']} / ${s['total']} (${formatPercentage(s['percentage'])})",
                  ),
                );
              },
            ),
    );
  }
}
