import 'package:flutter/material.dart';
import '../../services/classes_service.dart';
import 'hod_student_classes.dart';

class HodSelectClassScreen extends StatefulWidget {
  final String department;

  const HodSelectClassScreen({super.key, required this.department});

  @override
  State<HodSelectClassScreen> createState() => _HodSelectClassScreenState();
}

class _HodSelectClassScreenState extends State<HodSelectClassScreen> {
  final ClassesService _service = ClassesService();
  late Future<List<String>> _futureClasses;

  @override
  void initState() {
    super.initState();
    _futureClasses = _service.getClasses(widget.department);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Class"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: FutureBuilder<List<String>>(
        future: _futureClasses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load classes"));
          }

          final classes = snapshot.data ?? [];

          if (classes.isEmpty) {
            return const Center(child: Text("No classes available"));
          }

          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
