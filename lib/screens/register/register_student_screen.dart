import 'package:flutter/material.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({Key? key}) : super(key: key);

  @override
  State<RegisterStudentScreen> createState() =>
      _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  // 🔐 FINAL ATTRIBUTES (DO NOT CHANGE NAMES)
  String rollNo = "";
  String studentClass = "";
  String mobileNo = "";
  String parentMobileNo = "";

  // 🔐 FINAL CLASS LIST (SHARE WITH BACKEND)
  final List<String> classList = [
    "IF1KA", "IF2KA", "IF3KA", "IF4KA", "IF5KA", "IF6KA",
    "CO1KA", "CO2KA", "CO3KA", "CO4KA", "CO5KA", "CO6KA",
    "EJ1KA", "EJ2KA", "EJ3KA", "EJ4KA", "EJ5KA", "EJ6KA",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ keyboard fix
      appBar: AppBar(
        title: const Text("Student Registration"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // ✅ close keyboard
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _textField(
                hint: "Roll No",
                icon: Icons.badge,
                onChanged: (v) => rollNo = v,
              ),

              // ✅ CLASS DROPDOWN
              _classDropdown(),

              _textField(
                hint: "Mobile Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                onChanged: (v) => mobileNo = v,
              ),

              _textField(
                hint: "Parent Mobile Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                onChanged: (v) => parentMobileNo = v,
              ),

              const SizedBox(height: 20),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _textField({
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _classDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: studentClass.isEmpty ? null : studentClass,
        decoration: InputDecoration(
          hintText: "Select Class",
          prefixIcon: const Icon(Icons.book),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        items: classList
            .map(
              (cls) => DropdownMenuItem<String>(
                value: cls,
                child: Text(cls),
              ),
            )
            .toList(),
        onTap: () {
          FocusScope.of(context).unfocus(); // ✅ close keyboard
        },
        onChanged: (value) {
          setState(() {
            studentClass = value!;
          });
        },
      ),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009846),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Student registration request sent to admin for approval",
            ),
          ),
        );
      },
      child: const Text("Register"),
    );
  }
}
