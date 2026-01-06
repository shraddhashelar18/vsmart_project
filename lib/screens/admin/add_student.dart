import 'package:flutter/material.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Add Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field("Student Name"),
            _field("Email"),
            _field("Phone"),
            _dropdown("Select Class"),
            _dropdown("Assign Parent"),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {},
              child: const Text("Save Student"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String hint) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(decoration: InputDecoration(hintText: hint)),
      );

  Widget _dropdown(String hint) => DropdownButtonFormField(
        decoration: InputDecoration(hintText: hint),
        items: const [],
        onChanged: (_) {},
      );
}
