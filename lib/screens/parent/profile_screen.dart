import 'package:flutter/material.dart';
import '../../services/student_new_service.dart';

class ProfileScreen extends StatefulWidget {
  final String enrollment;

  const ProfileScreen({Key? key, required this.enrollment}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final StudentNewService _studentService = StudentNewService();

  Map<String, dynamic>? student;
  bool isLoading = true;

  static const Color green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    final data =
        await _studentService.getStudentByEnrollment(widget.enrollment);

    setState(() {
      student = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final name = student?["name"] ?? "";
    final roll = student?["roll"] ?? "";
    final className = student?["class"] ?? "";
    final email = student?["email"] ?? "";
    final phone = student?["phone"] ?? "";
    final enrollment = student?["enrollment"] ?? "";

    final initials =
        name.isNotEmpty ? name.split(" ").map((e) => e[0]).take(2).join() : "";

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Student Profile",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// 🔹 Top Profile Card
          Center(
            child: SizedBox(
              width: 300, // 👈 change this value to adjust width
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: green.withOpacity(0.15),
                        child: Text(
                          initials,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          /// 🔹 Info Card
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _infoRow("Roll No", roll),
                  const Divider(height: 30),
                  _infoRow("Enrollment No", enrollment),
                  const Divider(height: 30),
                  _infoRow("Class", className),
                  const Divider(height: 30),
                  _infoRow("Email", email),
                  const Divider(height: 30),
                  _infoRow("Phone", phone),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
