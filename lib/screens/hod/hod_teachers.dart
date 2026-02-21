import 'package:flutter/material.dart';
import '../../models/teacher.dart';
import '../../services/teacher_service.dart';
import 'teacher_detail_screen.dart';

class HodTeachers extends StatefulWidget {
  final String department;

  const HodTeachers({super.key, required this.department});

  @override
  State<HodTeachers> createState() => _HodTeachersState();
}

class _HodTeachersState extends State<HodTeachers> {
  final TeacherService _service = TeacherService();
  late Future<List<Teacher>> _teachersFuture;

  static const green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _teachersFuture = _service.getTeachersByDepartment(widget.department);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("Teachers (${widget.department})"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Teacher>>(
          future: _teachersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Error loading teachers"));
            }

            final teachers = snapshot.data ?? [];

            if (teachers.isEmpty) {
              return const Center(child: Text("No teachers found"));
            }

            return ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final t = teachers[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TeacherDetailScreen(teacher: t),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFEAF7F1),
                            child: Icon(Icons.person, color: green),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (t.isClassTeacher)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Class Teacher: ${t.classTeacherOf}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: green,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
