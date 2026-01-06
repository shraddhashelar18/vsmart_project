import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';
import 'add_parent.dart';

class ManageParents extends StatelessWidget {
  const ManageParents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔹 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Manage Parents",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text(
              "Vsmart Academic Platform",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.filter_list),
          )
        ],
      ),

      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddParent()),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 STATS ROW
            Row(
              children: [
                _statCard("Total Parents", "5"),
                const SizedBox(width: 12),
                _statCard("Active Students", "8"),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 SEARCH BAR
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
                "5 parents found",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 LIST
            Expanded(
              child: ListView(
                children: const [
                  _ParentCard(
                    name: "Sarah Johnson",
                    parentId: "P12345",
                    email: "sarah.johnson@email.com",
                    phone: "+1 234 567 8901",
                    studentName: "Emma Johnson",
                    studentId: "S001",
                    studentClass: "IF6K-A",
                  ),
                  _ParentCard(
                    name: "Michael Smith",
                    parentId: "P12346",
                    email: "michael.smith@email.com",
                    phone: "+1 234 567 8902",
                    studentName: "Liam Smith",
                    studentId: "S002",
                    studentClass: "IF6K-B",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _statCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF009846),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- PARENT CARD ----------

class _ParentCard extends StatelessWidget {
  final String name;
  final String parentId;
  final String email;
  final String phone;
  final String studentName;
  final String studentId;
  final String studentClass;

  const _ParentCard({
    required this.name,
    required this.parentId,
    required this.email,
    required this.phone,
    required this.studentName,
    required this.studentId,
    required this.studentClass,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
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
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text("Parent ID: $parentId",
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.email, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(email),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(phone),
              ],
            ),

            const SizedBox(height: 12),

            // 🔹 LINKED STUDENT
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link, color: Color(0xFF009846)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Linked Students (1)",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text("$studentName"),
                        Text("ID: $studentId"),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF009846),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      studentClass,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
