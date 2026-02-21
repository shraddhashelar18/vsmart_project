import 'package:flutter/material.dart';
import '../hod/hod_students.dart';
import '../hod/hod_teachers.dart';
import '../hod/hod_promoted_classes.dart';
import '../hod/hod_detained_classes.dart';
import '../hod/hod_atkt_classes.dart';
import '../../services/department_service.dart';
import '../../models/department_summary.dart';
import 'principal_bottom_nav.dart';

class PrincipalDepartmentView extends StatefulWidget {
  final String department;
  final List<String> departments;

  const PrincipalDepartmentView({
    Key? key,
    required this.department,
    required this.departments,
  }) : super(key: key);

  @override
  State<PrincipalDepartmentView> createState() =>
      _PrincipalDepartmentViewState();
}

class _PrincipalDepartmentViewState extends State<PrincipalDepartmentView> {
  static const green = Color(0xFF009846);

  final DepartmentService _service = DepartmentService();
  late Future<DepartmentSummary> _summaryFuture;

  @override
  void initState() {
    super.initState();
    _summaryFuture = _service.getSummary(widget.department);
  }

  List<String> _getClassesForDepartment(String dept) {
    switch (dept) {
      case "IF":
        return ["IF1KA", "IF3KA"];
      case "CO":
        return ["CO1KA", "CO3KA"];
      case "EJ":
        return ["EJ1KA", "EJ3KA"];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("${widget.department} Department"),
      ),
      bottomNavigationBar: PrincipalBottomNav(
        currentIndex: 0,
        departments: widget.departments,
      ),
      body: FutureBuilder<DepartmentSummary>(
        future: _summaryFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 SUMMARY SECTION
                const Text(
                  "Department Summary",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    _summaryCard("Students", data.totalStudents.toString()),
                    const SizedBox(width: 10),
                    _summaryCard("Teachers", data.totalTeachers.toString()),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _summaryCard("Promoted", data.promoted.toString()),
                    const SizedBox(width: 10),
                    _summaryCard("ATKT", data.promotedWithBacklog.toString()),
                    const SizedBox(width: 10),
                    _summaryCard("Detained", data.detained.toString()),
                  ],
                ),

                const SizedBox(height: 30),

                // 🔹 ACTIONS
                const Text(
                  "Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                _button(context, "View Students", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HodStudents(department: widget.department)),
                  );
                }),

                _button(context, "View Teachers", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HodTeachers(department: widget.department)),
                  );
                }),

                _button(context, "View Promoted List", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HodPromotedClasses(department: widget.department)),
                  );
                }),

                _button(context, "View ATKT List", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HodATKTClasses(department: widget.department)),
                  );
                }),

                _button(context, "View Detained List", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HodDetainedClasses(department: widget.department)),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _summaryCard(String title, String value) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
