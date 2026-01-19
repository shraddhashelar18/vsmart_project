import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';
import 'hod_promoted_students.dart';

class HodPromotedClasses extends StatelessWidget {
  final String department;

  const HodPromotedClasses({Key? key, required this.department})
      : super(key: key);

  static const green = Color(0xFF009846);

  // Mock class list
  final List<String> classList = const [
    "IF6K-A",
    "IF6K-B",
    "IF6K-C",
    "IF5K-A",
    "IF5K-B",
    "IF5K-C",
    "IF4K-A",
    "IF4K-B",
    "IF4K-C",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("Promoted Students ($department)"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 1,
        department: department,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classList.length,
        itemBuilder: (_, i) {
          String className = classList[i];
          return Card(
            child: ListTile(
              title: Text(className),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HodPromotedStudents(
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
