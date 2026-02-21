import 'package:flutter/material.dart';
import '../../services/app_settings_service.dart';
import 'hod_bottom_nav.dart';
import 'hod_promoted_students.dart';

class HodPromotedClasses extends StatefulWidget {
  final String department;

  const HodPromotedClasses({super.key, required this.department});

  @override
  State<HodPromotedClasses> createState() => _HodPromotedClassesState();
}

class _HodPromotedClassesState extends State<HodPromotedClasses> {
  final AppSettingsService _settingsService = AppSettingsService();

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
    final semesters = activeSemester == "EVEN" ? [1, 3, 5] : [2, 4, 6];

    List<String> classList = [];

    for (var sem in semesters) {
      classList.add("${widget.department}$sem" "KA");
      classList.add("${widget.department}$sem" "KB");
      classList.add("${widget.department}$sem" "KC");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("Promoted Classes (${widget.department})"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 0,
        department: widget.department,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classList.length,
        itemBuilder: (_, index) {
          final className = classList[index];

          return Card(
            child: ListTile(
              title: Text(className),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HodPromotedStudents(
                      department: widget.department,
                      className: className,
                    ),
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
