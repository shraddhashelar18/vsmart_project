import 'package:flutter/material.dart';
import 'add_teacher.dart';
import 'admin_bottom_nav.dart';

class ManageTeachers extends StatelessWidget {
  const ManageTeachers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // 🔹 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage Teachers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              "View and manage teacher information",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),

      // 🔹 BOTTOM NAV
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),

      // 🔹 ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTeacher()),
          );
        },
      ),

      // 🔹 BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: "Search teachers...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 TEACHER LIST
            Expanded(
              child: ListView(
                children: const [
                  TeacherCard(
                    name: "Prof Sunil Dodake",
                    subject: "PIC",
                    email: "sunil@teacher.com",
                    phone: "+91 5678903451",
                  ),
                  TeacherCard(
                    name: "Mrs Sushma Pawar",
                    subject: "DAN",
                    email: "sushma@teacher.com",
                    phone: "+91 5678903452",
                  ),
                  TeacherCard(
                    name: "Mrs Gauri Bobade",
                    subject: "English Literature",
                    email: "gauri@teacher.com",
                    phone: "+91 5678903453",
                  ),
                  TeacherCard(
                    name: "Mrs Samidha Chavan",
                    subject: "Computer Science",
                    email: "samidha@teacher.com",
                    phone: "+91 5678903454",
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

// 🔹 TEACHER CARD (MATCHES UI)
class TeacherCard extends StatelessWidget {
  final String name;
  final String subject;
  final String email;
  final String phone;

  const TeacherCard({
    Key? key,
    required this.name,
    required this.subject,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F2E9),
                child: Icon(Icons.person, color: Color(0xFF009846)),
              ),
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(subject),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 12),
                  Icon(Icons.delete, color: Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.email, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(email),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(phone),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
