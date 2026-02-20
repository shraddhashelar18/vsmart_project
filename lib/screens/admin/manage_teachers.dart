import 'package:flutter/material.dart';
import '../../services/teacher_new_service.dart';
import 'add_teacher.dart';
import 'teacher_detail_screen.dart';

class ManageTeachers extends StatefulWidget {
  final String department;

  const ManageTeachers({Key? key, required this.department}) : super(key: key);

  @override
  State<ManageTeachers> createState() => _ManageTeachersState();
}

class _ManageTeachersState extends State<ManageTeachers> {
  final TeacherService _teacherService = TeacherService();
  List<Map<String, dynamic>> teachers = [];

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  Future<void> _loadTeachers() async {
    final allTeachers = await _teacherService.getAllTeachers();

    teachers = allTeachers
        .where((t) => (t["departments"] as List).contains(widget.department))
        .toList();

    setState(() {});
  }

  Future<void> _deleteTeacher(int teacherId, String name) async {
    await _teacherService.deleteTeacher(teacherId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$name deleted")),
    );

    _loadTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Manage Teachers"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTeacher(department: widget.department),
            ),
          );
          _loadTeachers();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: teachers.isEmpty
            ? const Center(child: Text("No teachers found"))
            : ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];

                  return TeacherCard(
                    teacherId: teacher["id"],
                    name: teacher["name"],
                    email: teacher["email"],
                    phone: teacher["phone"],
                    department: widget.department,
                    onDelete: () =>
                        _deleteTeacher(teacher["id"], teacher["name"]),
                  );
                },
              ),
      ),
    );
  }
}

// ===============================
// TEACHER CARD
// ===============================

class TeacherCard extends StatelessWidget {
  final int teacherId;
  final String name;
  final String email;
  final String phone;
  final String department;
  final VoidCallback onDelete;

  const TeacherCard({
    Key? key,
    required this.teacherId,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE0F2E9),
          child: Icon(Icons.person, color: Color(0xFF009846)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(email),
            Text(phone),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddTeacher(
                      department: department,
                      teacherId: teacherId,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  TeacherDetailScreen(teacherId: teacherId, name: name),
            ),
          );
        },
      ),
    );
  }
}
