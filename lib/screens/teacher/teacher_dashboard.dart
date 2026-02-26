import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/teacher_dashboard_service.dart';
import '../teacher/department_selection_screen.dart';
import '../teacher/teacher_mark_attendance.dart';
import '../teacher/teacher_enter_marks.dart';
import '../teacher/teacher_view_students.dart';
import '../teacher/teacher_attendance_settings.dart';
import '../teacher/teacher_send_notifications.dart';

class TeacherDashboard extends StatefulWidget {
  final String activeDepartment;
  final int teacherId;
  final String teacherName;
  final List<String> departments;

  const TeacherDashboard({
    Key? key,
    required this.activeDepartment,
    required this.teacherId,
    required this.departments,
    required this.teacherName,
  }) : super(key: key);

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  static const green = Color(0xFF009846);

  String selectedClass = "";
  String selectedSubject = "";

  List<String> allocatedClasses = [];
  List<String> subjectList = [];
  final TeacherDashboardService _service = TeacherDashboardService();
  @override
  void initState() {
    super.initState();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    final allClasses = await _service.getAllocatedClasses(widget.teacherId);

    // 🔥 FILTER BY ACTIVE DEPARTMENT
    allocatedClasses = allClasses
        .where((cls) => cls.startsWith(widget.activeDepartment))
        .toList();

    if (allocatedClasses.isNotEmpty) {
      selectedClass = allocatedClasses.first;
      await loadSubjects();
    } else {
      selectedClass = "";
      selectedSubject = "";
    }

    setState(() {});
  }

  Future<void> loadSubjects() async {
    subjectList = await _service.getSubjects(widget.teacherId, selectedClass);

    if (subjectList.isEmpty) {
      selectedSubject = "";
    } else if (subjectList.length == 1) {
      selectedSubject = subjectList.first;
    } else {
      if (!subjectList.contains(selectedSubject)) {
        selectedSubject = subjectList.first;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String today =
        DateFormat("EEEE, MMMM d, yyyy").format(DateTime.now());

    return Container(
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(today),
            _switchDepartmentButton(),
            const SizedBox(height: 10),
            _classSelector(),
            const SizedBox(height: 10),
            _subjectSelector(), // Always show subject block if class selected
            const SizedBox(height: 20),
            _quickActions(),
          ],
        ),
      ),
    );
  }

  Widget _header(String today) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          const Text("Teacher Dashboard",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          Text(
            "Good Afternoon, ${widget.teacherName}",
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(today, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _switchDepartmentButton() {
    if (widget.departments.length <= 1) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => DepartmentSelectionScreen(
                  departments: widget.departments,
                  teacherId: widget.teacherId,
                  teacherName: widget.teacherName,
                ),
              ),
            );
          },
          icon: const Icon(Icons.swap_horiz, color: green),
          label: const Text(
            "Switch Department",
            style: TextStyle(color: green, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _classSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Class",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          DropdownButtonFormField(
            value: selectedClass.isEmpty ? null : selectedClass,
            items: allocatedClasses
                .map((cls) => DropdownMenuItem(value: cls, child: Text(cls)))
                .toList(),
            decoration: _dropdownDeco(),
            onChanged: (v) {
              selectedClass = v!;
              loadSubjects();
            },
          ),
        ],
      ),
    );
  }

  Widget _subjectSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Subject",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          DropdownButtonFormField(
            value: selectedSubject.isEmpty ? null : selectedSubject,
            items: subjectList
                .map((sub) => DropdownMenuItem(value: sub, child: Text(sub)))
                .toList(),
            decoration: _dropdownDeco(),
            onChanged: (v) {
              setState(() => selectedSubject = v!);
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _dropdownDeco() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    );
  }

  Widget _quickActions() {
    bool disabled = selectedClass.isEmpty || selectedSubject.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _actionCard(
            icon: Icons.check_circle_outline,
            title: "Mark Attendance",
            subtitle: "Take attendance",
            onTap: disabled
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TeacherMarkAttendance(
                          className: selectedClass,
                          subject: selectedSubject,
                        ),
                      ),
                    );
                  },
          ),
          _actionCard(
            icon: Icons.edit_note,
            title: "Enter Marks",
            subtitle: "Add student marks",
            onTap: disabled
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EnterMarksScreen(
                          className: selectedClass,
                          subject: selectedSubject,
                          teacherId: widget.teacherId,
                        ),
                      ),
                    );
                  },
          ),
          _actionCard(
            icon: Icons.bar_chart,
            title: "View Reports",
            subtitle: "Performance Reports",
            onTap: disabled
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            TeacherViewStudents(className: selectedClass),
                      ),
                    );
                  },
          ),
          _actionCard(
            icon: Icons.notifications_active,
            title: "Send Notifications",
            subtitle: "Message class or students",
            onTap: disabled
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TeacherSendNotifications(
                          className: selectedClass,
                          subject: selectedSubject,
                        ),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return Opacity(
      opacity: onTap == null ? 0.45 : 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3)),
              ]),
          child: Row(children: [
            Container(
              height: 44,
              width: 44,
              decoration:
                  const BoxDecoration(color: green, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
