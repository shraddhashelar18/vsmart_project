import 'package:flutter/material.dart';
import '../../services/app_settings_service.dart';
import 'manage_parents.dart';
import '../../services/attendance_service.dart';

class ParentClassScreen extends StatefulWidget {
  final String department;

  const ParentClassScreen({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  State<ParentClassScreen> createState() => _ParentClassScreenState();
}

class _ParentClassScreenState extends State<ParentClassScreen> {
  final AppSettingsService _settingsService = AppSettingsService();
  final AttendanceService _attendanceService = AttendanceService();
  String activeSemester = "EVEN";

  static const green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _loadSemester();
  }

  Future<void> _loadSemester() async {
    activeSemester = await _settingsService.getActiveSemester();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.department} Classes"),
        backgroundColor: green,
      ),
      body: FutureBuilder<List<String>>(
        future: _attendanceService.getClasses(widget.department),
        builder: (context, snapshot) {
          final classes = snapshot.data ?? [];

          return ListView.builder(
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
                        builder: (_) => ManageParents(className: cls),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
