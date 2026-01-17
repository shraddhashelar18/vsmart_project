import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';

class HODManageStudents extends StatelessWidget {
  const HODManageStudents({super.key});

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Manage Students"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Text(
              "Department student overview",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const HODBottomNav(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _statsBox("Total", "420"),
                const SizedBox(width: 12),
                _statsBox("Promoted", "392"),
                const SizedBox(width: 12),
                _statsBox("Detained", "28"),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Search student...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("420 found", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  _StudentCard(
                    name: "Emma Johnson",
                    email: "emma@if.com",
                    phone: "9876543210",
                    className: "IF6K-A",
                  ),
                  _StudentCard(
                    name: "Liam Smith",
                    email: "liam@if.com",
                    phone: "9876543211",
                    className: "IF6K-A",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statsBox(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String className;

  const _StudentCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFEAF7F1),
              child: Icon(Icons.person, color: Color(0xFF009846)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                  Text(phone, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            Text(className,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
