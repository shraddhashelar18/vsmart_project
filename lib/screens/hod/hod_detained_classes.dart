import 'package:flutter/material.dart';
import '../../services/classes_service.dart';
import 'hod_bottom_nav.dart';
import 'hod_detained_students.dart';

class HodDetainedClasses extends StatefulWidget {
  final String department;

  const HodDetainedClasses({
    super.key,
    required this.department,
  });

  @override
  State<HodDetainedClasses> createState() => _HodDetainedClassesState();
}

class _HodDetainedClassesState extends State<HodDetainedClasses> {
  final ClassesService _classService = ClassesService();
  late Future<List<String>> _futureClasses;

  static const green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _futureClasses = _classService.getDetainedClasses(widget.department);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("Detained Classes (${widget.department})"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 0,
        department: widget.department,
      ),
      body: FutureBuilder<List<String>>(
        future: _futureClasses,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load classes"));
          }

          final classList = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: classList.length,
            itemBuilder: (_, i) {
              final className = classList[i];

              return Card(
                child: ListTile(
                  title: Text(className),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HodDetainedStudents(
                          department: widget.department,
                          className: className,
                        ),
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
