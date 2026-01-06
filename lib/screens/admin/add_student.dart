import 'package:flutter/material.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Add Student"),
        leading: const BackButton(),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              "Fill in student details",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _inputField(
              icon: Icons.person,
              hint: "Enter student's full name",
            ),
            _inputField(
              icon: Icons.email,
              hint: "student@example.com",
            ),
            _inputField(
              icon: Icons.phone,
              hint: "+91 1234567890",
            ),
            _dropdownField(
              icon: Icons.school,
              hint: "Select a class",
            ),
            _dropdownField(
              icon: Icons.person_outline,
              hint: "Select a parent (optional)",
            ),
            const SizedBox(height: 12),

            // Info box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Student details will be added to the system and parents will be notified via email.",
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text("Save Student"),
            ),
            const SizedBox(height: 12),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({required IconData icon, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _dropdownField({required IconData icon, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: const [],
        onChanged: (_) {},
      ),
    );
  }
}
