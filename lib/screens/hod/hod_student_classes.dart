import 'package:flutter/material.dart';

class HodStudentClasses extends StatelessWidget {
  final String className;
  final String semester;
  final String department;

  const HodStudentClasses({
    Key? key,
    required this.className,
    required this.department,
    required this.semester,
  }) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("$className Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "40 students found",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  _StudentCard(
                    name: "Emma Johnson",
                    email: "emma@if.com",
                    phone: "9876543210",
                  ),
                  _StudentCard(
                    name: "Liam Smith",
                    email: "liam@if.com",
                    phone: "9876543211",
                  ),
                  _StudentCard(
                    name: "Noah Davis",
                    email: "noah@if.com",
                    phone: "9876543212",
                  ),
                ],
              ),
            ),
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

  const _StudentCard({
    required this.name,
    required this.email,
    required this.phone,
  });

  static const green = Color(0xFF009846);

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
              child: Icon(Icons.person, color: green),
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
          ],
        ),
      ),
    );
  }
}
