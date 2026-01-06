import 'package:flutter/material.dart';

class AddParent extends StatelessWidget {
  const AddParent({Key? key}) : super(key: key);

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
        title: const Text("Add Parent"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fill in parent details",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 PARENT NAME
            _inputField(
              hint: "Parent Name",
              icon: Icons.person,
            ),

            // 🔹 EMAIL
            _inputField(
              hint: "Email Address",
              icon: Icons.email,
            ),

            // 🔹 PHONE
            _inputField(
              hint: "Phone Number",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            // 🔹 LINK STUDENT (OPTIONAL)
            _dropdownField(
              hint: "Link Student (optional)",
              icon: Icons.school,
            ),

            const SizedBox(height: 16),

            // 🔹 NOTE
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: Color(0xFF009846)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Parent will receive login credentials via email after saving.",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🔹 SAVE BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // API call later
              },
              child: const Text(
                "Save Parent",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 CANCEL
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            const SizedBox(height: 12),

            const Center(
              child: Text(
                "Vsmart Academic Platform © 2024",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _inputField({
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String hint,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        items: const [
          DropdownMenuItem(value: "Emma Johnson", child: Text("Emma Johnson")),
          DropdownMenuItem(value: "Liam Smith", child: Text("Liam Smith")),
        ],
        onChanged: (_) {},
      ),
    );
  }
}
