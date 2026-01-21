import 'package:flutter/material.dart';
import 'principal_bottom_nav.dart';
import 'principal_department_view.dart';

class PrincipalDashboard extends StatelessWidget {
  final List<String> departments;

  const PrincipalDashboard({
    Key? key,
    required this.departments,
  }) : super(key: key);

  static const green = Color(0xFF009846);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Principal Dashboard"),
      ),
      bottomNavigationBar: const PrincipalBottomNav(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Department",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: departments.length,
                itemBuilder: (_, i) {
                  String dept = departments[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.apartment, color: green),
                      title: Text("$dept Department"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PrincipalDepartmentView(department: dept),
                          ),
                        );
                      },
                    ),
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
