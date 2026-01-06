import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';

class ManageParents extends StatelessWidget {
  const ManageParents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Manage Parents"),
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          // navigate to AddParent (later)
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ParentCard(
            name: "Sarah Johnson",
            email: "sarah@gmail.com",
            phone: "+91 9876543210",
            student: "Emma Johnson (IF6K-A)",
          ),
          _ParentCard(
            name: "Michael Smith",
            email: "michael@gmail.com",
            phone: "+91 9876543222",
            student: "Liam Smith (IF6K-B)",
          ),
        ],
      ),
    );
  }
}

class _ParentCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String student;

  const _ParentCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(email),
            Text(phone),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("Linked Student: $student"),
            ),
          ],
        ),
      ),
    );
  }
}
