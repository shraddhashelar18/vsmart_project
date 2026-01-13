import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';
import 'add_student.dart';

class ManageStudents extends StatelessWidget {
  const ManageStudents({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Manage Students"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View and manage student information",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🟩 STATS ROW (same as parents)
            Row(
              children: [
                _statsBox("Total Students", "4"),
                const SizedBox(width: 12),
                _statsBox("With Parents", "3"),
                const SizedBox(width: 12),
                _statsBox("Without", "1"),
              ],
            ),

            const SizedBox(height: 16),

            // 🔍 SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: "Search by name, email, phone or ID...",
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
                "4 students found",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: const [
                  _StudentCard(
                    name: "Emma Johnson",
                    email: "emma@student.com",
                    phone: "+91 5678903451",
                    className: "IF6K-A",
                  ),
                  _StudentCard(
                    name: "Liam Smith",
                    email: "liam@student.com",
                    phone: "+91 5678903452",
                    className: "IF6K-A",
                  ),
                  _StudentCard(
                    name: "Olivia Brown",
                    email: "olivia@student.com",
                    phone: "+91 5678903453",
                    className: "IF6K-B",
                  ),
                  _StudentCard(
                    name: "Noah Davis",
                    email: "noah@student.com",
                    phone: "+91 5678903454",
                    className: "CO5K-A",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🟩 STATS BOX WIDGET (same style as parents)
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

// 🟩 STUDENT CARD MATCHING PARENT STYLE
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
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddStudent()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context, name),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 🗑 DELETE CONFIRMATION
void _confirmDelete(BuildContext context, String name) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Confirm Delete"),
      content: Text("Delete student $name?"),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$name deleted")),
            );
          },
        ),
      ],
    ),
  );
}
