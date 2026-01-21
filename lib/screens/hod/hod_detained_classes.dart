import 'package:flutter/material.dart';
import '../../mock/mock_promotion.dart'; // <-- Using shared mock file
import 'hod_bottom_nav.dart';
import 'hod_detained_students.dart';

class HodDetainedClasses extends StatelessWidget {
  final String department;

  const HodDetainedClasses({
    Key? key,
    required this.department,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    // Extract class names from mockDetained
    final List<String> classList = mockDetained.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("Detained Students ($department)"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 0,
        department: department,
      ),
      body: classList.isEmpty
          ? const Center(
              child: Text(
                "No detained students found",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: classList.length,
              itemBuilder: (_, i) {
                final String className = classList[i];

                return Card(
                  child: ListTile(
                    title: Text(className),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HodDetainedStudents(
                            department: department,
                            className: className,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
