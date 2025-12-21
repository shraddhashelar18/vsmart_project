import 'package:flutter/material.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({Key? key}) : super(key: key);

  @override
  State<RegisterStudentScreen> createState() =>
      _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  // ✅ FINAL attributes
  String rollNo = "";
  String studentClass = "";
  String mobileNo = "";
  String parentMobileNo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Registration"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _field("Roll No", (v) => rollNo = v),
            _field("Class", (v) => studentClass = v),
            _field("Mobile Number", (v) => mobileNo = v),
            _field("Parent Mobile Number", (v) => parentMobileNo = v),
            const SizedBox(height: 20),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _field(String hint, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009846),
        minimumSize: const Size(double.infinity, 45),
      ),
      onPressed: () {
        // 🔁 TEMP: API call later
      },
      child: const Text("Register"),
    );
  }
}
