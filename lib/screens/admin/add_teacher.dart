import 'package:flutter/material.dart';

class AddTeacher extends StatelessWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: const Text("Add Teacher"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field("Teacher Name"),
            _field("Email Address"),
            _dropdown("Assign Class"),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {},
              child: const Text("Save Teacher"),
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
