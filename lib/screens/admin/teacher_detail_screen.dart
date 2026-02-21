import 'package:flutter/material.dart';
import '../../services/teacher_new_service.dart';

class TeacherDetailScreen extends StatelessWidget {
  final int teacherId;
  final String name;

  final TeacherNewService _teacherService = TeacherNewService();

  TeacherDetailScreen({
    Key? key,
    required this.teacherId,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classes = _teacherService.getTeacherClasses(teacherId);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            final className = classes[index];
            final subjects =
                _teacherService.getSubjectsForClass(teacherId, className);

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      className,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...subjects.map(
                      (sub) => Row(
                        children: [
                          const Icon(Icons.book, size: 16, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(sub),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
