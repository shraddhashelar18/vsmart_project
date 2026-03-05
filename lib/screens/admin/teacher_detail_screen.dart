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
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFF009846),
      ),
      body: FutureBuilder(
        future: _teacherService.getTeacherDetail(teacherId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final teacher = snapshot.data as Map<String, dynamic>;

          final classes = teacher["classes"] ?? [];
          final subjects = teacher["subjects"] ?? {};

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final className = classes[index];
              final classSubjects = subjects[className] ?? [];

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
                      ...classSubjects.map<Widget>((sub) => Row(
                            children: [
                              const Icon(Icons.book,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(sub),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
