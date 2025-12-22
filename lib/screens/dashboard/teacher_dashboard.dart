import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../mock/mock_teacher_classes.dart';
import 'department_selection_screen.dart';

class TeacherDashboard extends StatefulWidget {
  final String activeDepartment;
  final int teacherId;

  const TeacherDashboard({
    Key? key,
    required this.activeDepartment,
    required this.teacherId,
  }) : super(key: key);

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  // 🔐 CONSTANTS (BACKEND WILL ONLY CHANGE VALUES)
  String teacherName = "Mr. Sunil Dodake";
  String selectedClass = "";

  List<String> allocatedClasses = [];

  @override
  void initState() {
    super.initState();

    // 🔑 Load classes allocated by HOD
    allocatedClasses = mockTeacherClasses[widget.teacherId] ?? [];

    if (allocatedClasses.isNotEmpty) {
      selectedClass = allocatedClasses.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String today =
        DateFormat("EEEE, MMMM d, yyyy").format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(today),

            // ✅ SWITCH DEPARTMENT BUTTON (NEW)
            _switchDepartmentButton(),

            const SizedBox(height: 10),
            _classSelector(),
            const SizedBox(height: 20),
            _quickActions(),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _header(String today) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF009846),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Vsmart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Academic Management",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Text(
            "Good Afternoon, $teacherName",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            today,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // ================= SWITCH DEPARTMENT =================

  Widget _switchDepartmentButton() {
    // 🔴 MOCK: later backend will tell department count
    bool hasMultipleDepartments = true;

    if (!hasMultipleDepartments) return const SizedBox();

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
                  departments: const ["IT", "CO"], // 🔁 mock
                  teacherId: widget.teacherId,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.swap_horiz,
            color: Color(0xFF009846),
          ),
          label: const Text(
            "Switch Department",
            style: TextStyle(
              color: Color(0xFF009846),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ================= CLASS SELECT =================

  Widget _classSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Class",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedClass.isEmpty ? null : selectedClass,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            items: allocatedClasses
                .map(
                  (cls) => DropdownMenuItem(
                    value: cls,
                    child: Text(cls),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedClass = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  // ================= QUICK ACTIONS =================

  Widget _quickActions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _actionCard(
            icon: Icons.check_circle_outline,
            title: "Mark Attendance",
            subtitle: "Take attendance for today’s class",
          ),
          _actionCard(
            icon: Icons.edit_note,
            title: "Enter Marks",
            subtitle: "Add or update student marks",
          ),
          _actionCard(
            icon: Icons.bar_chart,
            title: "View Reports",
            subtitle: "Check student performance reports",
          ),
          _actionCard(
            icon: Icons.settings,
            title: "Attendance Settings",
            subtitle: "Set attendance threshold requirements",
          ),
          _actionCard(
            icon: Icons.notifications,
            title: "Send Notifications",
            subtitle: "Message students and classes",
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF009846),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
