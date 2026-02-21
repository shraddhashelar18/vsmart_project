import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';
import 'student_detail_screen.dart';

class HodStudentClasses extends StatefulWidget {
  final String className;

  const HodStudentClasses({
    super.key,
    required this.className,
  });

  @override
  State<HodStudentClasses> createState() => _HodStudentClassesState();
}

class _HodStudentClassesState extends State<HodStudentClasses> {
  final StudentService _service = StudentService();
  late Future<List<Student>> _studentsFuture;

  static const green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _studentsFuture = _service.getStudentsByClass(widget.className);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("${widget.className} Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search student...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Student>>(
                future: _studentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading students"));
                  }

                  final students = snapshot.data ?? [];

                  if (students.isEmpty) {
                    return const Center(child: Text("No students found"));
                  }

                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final s = students[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => StudentDetailScreen(student: s),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        s.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Roll No: ${s.rollNo}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                )
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
          ],
        ),
      ),
    );
  }
}
