import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';

class HodTeachers extends StatelessWidget {
  final String department;
  const HodTeachers({Key? key, required this.department}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Teachers"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 2,
        department: department,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search teachers...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("18 teachers found",
                  style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  _TeacherCard(
                      name: "Prof Sunil Dodake",
                      subject: "PIC",
                      email: "sunil@college.com"),
                  _TeacherCard(
                      name: "Mrs Gauri Bobade",
                      subject: "English",
                      email: "gauri@college.com"),
                  _TeacherCard(
                      name: "Mrs Sushma Pawar",
                      subject: "DAN",
                      email: "sushma@college.com"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeacherCard extends StatelessWidget {
  final String name, subject, email;
  const _TeacherCard(
      {required this.name, required this.subject, required this.email});

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
            backgroundColor: Color(0xFFEAF7F1),
            child: Icon(Icons.person, color: green)),
        title: Text(name),
        subtitle: Text("$subject\n$email", style: const TextStyle(height: 1.3)),
      ),
    );
  }
}
