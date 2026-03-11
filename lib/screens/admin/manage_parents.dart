import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';
import 'add_parent.dart';
import '../../services/parent_service.dart';

class ManageParents extends StatefulWidget {
  final String className;

  const ManageParents({
    Key? key,
    required this.className,
  }) : super(key: key);

  @override
  State<ManageParents> createState() => _ManageParentsState();
}

class _ManageParentsState extends State<ManageParents> {
  final ParentService _parentService = ParentService();
  List<Map<String, dynamic>> parents = [];
String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadParents();
  }

  Future<void> _loadParents() async {
    parents = await _parentService.getParentsByClass(widget.className);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    // 🔹 FIX 1 — MOVED HERE
    
final filteredParents = parents.where((p) {
      final name = (p["name"] ?? "").toLowerCase();
      final email = (p["email"] ?? "").toLowerCase();
      final phone = (p["phone"] ?? "").toLowerCase();

      return name.contains(searchQuery) ||
          email.contains(searchQuery) ||
          phone.contains(searchQuery);
    }).toList();
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
        // 🔹 FIX 2 — ONLY ONE TITLE
        title: Text("Manage Parents - ${widget.className}"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View and manage parent information",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009846),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddParent(), // 🔥 NO PARAMETER
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 SEARCH BAR
           TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
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

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${parents.length} parents found",
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 LIST
            Expanded(
              child: ListView(
                children: filteredParents.map((p) {
                 final parentPhone = p["phone"];
                  final childEnroll = p["studentId"];

                  return FutureBuilder<Map<String, dynamic>?>(
                    future: _parentService.getStudent(childEnroll),
                    builder: (context, snapshot) {
                      final student = snapshot.data;

                      return ParentCard(
                        name: p["name"],
                        parentId: parentPhone,
                        email: p["email"] ?? "—",
                        phone: parentPhone,
                        studentName: student?["name"] ?? "",
                        studentId: childEnroll,
                        studentClass: student?["class"] ?? "",
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- PARENT CARD ----------

class ParentCard extends StatelessWidget {
  final String name;

  final String parentId;
  final String email;
  final String phone;
  final String studentName;
  final String studentId;
  final String studentClass;

  const ParentCard({
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
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("Parent ID: $parentId",
                          style: const TextStyle(fontSize: 12)),
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
                          MaterialPageRoute(
                            builder: (_) => AddParent(parentPhone: parentId),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(context, name, parentId),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.email, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(email),
            ]),
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.phone, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(phone),
            ]),
            const SizedBox(height: 12),
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
                        const Text("Linked Students (1)",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(studentName),
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

// ---------- CONFIRM DELETE ----------

void _confirmDelete(BuildContext context, String name, String phone) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Confirm Delete"),
      content: Text("Delete parent $name?"),
      actions: [
        TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context)),
        TextButton(
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.pop(context);
            ParentService().deleteParent(phone);
            Navigator.pop(context); // refresh
          },
        ),
      ],
    ),
  );
}
