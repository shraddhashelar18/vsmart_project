import 'package:flutter/material.dart';

class AddTeacher extends StatelessWidget {
  AddTeacher({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  String? _selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add Teacher"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Fill in teacher details",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Teacher Name"),
              _textField(
                hint: "Enter full name",
                icon: Icons.person,
                controller: _nameCtrl,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Name is required";
                  if (RegExp(r'[0-9]').hasMatch(v)) {
                    return "Name cannot contain numbers";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _label("Email Address"),
              _textField(
                hint: "teacher@example.com",
                icon: Icons.email,
                controller: _emailCtrl,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Email is required";
                  final reg = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!reg.hasMatch(v)) return "Enter valid email";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _label("Assign Class"),
              _dropdownField(
                validator: (v) => v == null ? "Please select a class" : null,
                onChanged: (v) => _selectedClass = v,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb, color: Color(0xFF009846)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Note: Teacher will receive a confirmation email with login credentials after saving.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009846),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Saving teacher...")),
                    );

                    // save teacher later
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Save Teacher",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  "Vsmart Academic Platform © 2024",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _textField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
    );
  }

  Widget _dropdownField({
    String? Function(String?)? validator,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "Select a class",
        prefixIcon: const Icon(Icons.group),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(value: "IF6KA", child: Text("IF6KA")),
        DropdownMenuItem(value: "IF6KB", child: Text("IF6KB")),
        DropdownMenuItem(value: "IF5KA", child: Text("IF5KA")),
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
