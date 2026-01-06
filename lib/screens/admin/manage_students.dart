import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';
import 'add_student.dart';

class ManageStudents extends StatelessWidget {
  const ManageStudents({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Manage Students",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "View and manage student information",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddStudent()),
          );
        },
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search students...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Student list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _StudentCard(
                  name: "Emma Johnson",
                  className: "Class 5-A",
                  email: "emma@student.com",
                  phone: "+91 5678903451",
                ),
                _StudentCard(
                  name: "Liam Smith",
                  className: "Class 5-A",
                  email: "liam@student.com",
                  phone: "+91 5678903452",
                ),
                _StudentCard(
                  name: "Olivia Brown",
                  className: "Class 4-B",
                  email: "olivia@student.com",
                  phone: "+91 5678903453",
                ),
                _StudentCard(
                  name: "Noah Davis",
                  className: "Class 5-A",
                  email: "noah@student.com",
                  phone: "+91 5678903454",
                ),
              ],
            ),
          ),

          // Bottom stats
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatItem(count: "4", label: "Total Students"),
                _StatItem(count: "3", label: "With Parents", color: green),
                _StatItem(
                  count: "1",
                  label: "Without Parents",
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String name;
  final String className;
  final String email;
  final String phone;

  const _StudentCard({
    required this.name,
    required this.className,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    className,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 14),
                      const SizedBox(width: 4),
                      Text(email),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 14),
                      const SizedBox(width: 4),
                      Text(phone),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: const [
                Icon(Icons.edit, color: Colors.blue),
                SizedBox(height: 8),
                Icon(Icons.delete, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;
  final Color? color;

  const _StatItem({
    required this.count,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
