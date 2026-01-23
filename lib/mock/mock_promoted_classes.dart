import 'package:flutter/material.dart';
import '../../mock/mock_promotion.dart';
import '../screens/hod/hod_promoted_students.dart';
import '../screens/hod/hod_bottom_nav.dart';


class HodPromotedClasses extends StatelessWidget {
  final String department;

  const HodPromotedClasses({Key? key, required this.department})
      : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    // 🔹 Later Backend → GET /promotion/classes?department=IT
    final classList = mockPromotions.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("Promoted Classes ($department)"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 1,
        department: department,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classList.length,
        itemBuilder: (_, index) {
          final className = classList[index];
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
//test