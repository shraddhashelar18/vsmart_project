import 'package:flutter/material.dart';
import '../../services/attendance_service.dart';
import 'manage_students.dart';

class SelectClassScreen extends StatefulWidget {
  final String department;

  const SelectClassScreen({Key? key, required this.department})
      : super(key: key);

  @override
  State<SelectClassScreen> createState() => _SelectClassScreenState();
}

class _SelectClassScreenState extends State<SelectClassScreen> {
  final AttendanceService _attendanceService = AttendanceService();

  List<String> classes = [];

  @override
  void initState() {
    super.initState();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    classes = await _attendanceService.getClasses(widget.department);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Class"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (_, i) {
          final cls = classes[i];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(cls),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ManageStudents(className: cls),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
