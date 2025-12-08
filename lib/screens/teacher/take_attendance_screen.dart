import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/students_provider.dart';
import '../../providers/attendance_provider.dart';
import '../../widgets/student_tile.dart';
import '../../widgets/attendance_row.dart';

class TakeAttendanceScreen extends StatefulWidget {
  final String classId;
  const TakeAttendanceScreen({super.key, required this.classId});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<StudentsProvider>(
      context,
      listen: false,
    ).fetchStudents(['stud_1']); // fetch from API
  }

  @override
  Widget build(BuildContext context) {
    final studentsProvider = Provider.of<StudentsProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Take Attendance")),
      body: ListView.builder(
        itemCount: studentsProvider.students.length,
        itemBuilder: (context, index) {
          final student = studentsProvider.students[index];
          final status =
              attendanceProvider.attendance[student.id]?.status ?? 'Present';
          return AttendanceRow(
            studentName: student.userId,
            status: status,
            onChange: (val) =>
                attendanceProvider.setAttendance(student.id, val),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          await attendanceProvider.submitAttendance(widget.classId);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Attendance submitted")));
        },
      ),
    );
  }
}
