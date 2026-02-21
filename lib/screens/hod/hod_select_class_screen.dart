import 'package:flutter/material.dart';
import '../../services/app_settings_service.dart';
import 'hod_student_classes.dart';

class HodSelectClassScreen extends StatefulWidget {
  final String department;

  const HodSelectClassScreen({super.key, required this.department});

  @override
  State<HodSelectClassScreen> createState() => _HodSelectClassScreenState();
}

class _HodSelectClassScreenState extends State<HodSelectClassScreen> {
  final AppSettingsService _settingsService = AppSettingsService();

  String activeSemester = "EVEN";

  final List<String> allClasses = [
    "IF1KA",
    "IF1KB",
    "IF1KC",
    "IF2KA",
    "IF2KB",
    "IF2KC",
    "IF3KA",
    "IF3KB",
    "IF3KC",
    "IF4KA",
    "IF4KB",
    "IF4KC",
    "IF5KA",
    "IF5KB",
    "IF5KC",
    "IF6KA",
    "IF6KB",
    "IF6KC",
    "CO1KA",
    "CO1KB",
    "CO1KC",
    "CO2KA",
    "CO2KB",
    "CO2KC",
    "CO3KA",
    "CO3KB",
    "CO3KC",
    "CO4KA",
    "CO4KB",
    "CO4KC",
    "CO5KA",
    "CO5KB",
    "CO5KC",
    "CO6KA",
    "CO6KB",
    "CO6KC",
    "EJ1KA",
    "EJ1KB",
    "EJ1KC",
    "EJ2KA",
    "EJ2KB",
    "EJ2KC",
    "EJ3KA",
    "EJ3KB",
    "EJ3KC",
    "EJ4KA",
    "EJ4KB",
    "EJ4KC",
    "EJ5KA",
    "EJ5KB",
    "EJ5KC",
    "EJ6KA",
    "EJ6KB",
    "EJ6KC",
  ];

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
    final classes = allClasses.where((c) {
      if (!c.startsWith(widget.department)) return false;

      final sem = int.parse(c[2]);

      if (activeSemester == "EVEN") {
        return sem % 2 == 0;
      } else {
        return sem % 2 != 0;
      }
    }).toList();

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
                    builder: (_) => HodStudentClasses(className: cls),
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
