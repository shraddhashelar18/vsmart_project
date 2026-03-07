import 'package:flutter/material.dart';
import '../../services/classes_service.dart';
import 'hod_bottom_nav.dart';
import 'hod_promoted_students.dart';

class HodPromotedClasses extends StatefulWidget {
  final String department;

  const HodPromotedClasses({super.key, required this.department});

  @override
  State<HodPromotedClasses> createState() => _HodPromotedClassesState();
}

class _HodPromotedClassesState extends State<HodPromotedClasses> {
  final ClassesService _classService = ClassesService();
  late Future<List<String>> _futureClasses;

  static const green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _futureClasses = _classService.getPromotedClasses(widget.department);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text("Promoted Classes (${widget.department})"),
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

          if (classList.isEmpty) {
            return const Center(
              child: Text(
                "No classes available",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: classList.length,
            itemBuilder: (_, index) {
              final className = classList[index];

              return Card(
                child: ListTile(
                  title: Text(className),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HodPromotedStudents(
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
