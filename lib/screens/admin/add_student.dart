import 'package:flutter/material.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  String? selectedClass;
  String? selectedParent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        
        backgroundColor: const Color(0xFF009846),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add Student"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Fill in student details",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _inputField(
                icon: Icons.person,
                hint: "Enter student's full name",
                controller: _nameCtrl,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Name is required";
                  if (RegExp(r'[0-9]').hasMatch(v)) {
                    return "Name cannot contain numbers";
                  }
                  return null;
                },
              ),
              _inputField(
                icon: Icons.email,
                hint: "student@example.com",
                controller: _emailCtrl,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Email is required";
                  final reg = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!reg.hasMatch(v)) return "Enter valid email";
                  return null;
                },
              ),
              _inputField(
                icon: Icons.phone,
                hint: "+91 1234567890",
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Phone is required";
                  if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                    return "Digits only";
                  }
                  if (v.length != 10) {
                    return "Phone number must be 10 digits";
                  }
                  return null;
                },
              ),
              _dropdownField(
                icon: Icons.school,
                hint: "Select a class",
                items: const ["IF6KA", "IF6KB", "IF5KB"],
                validator: (v) =>
                    v == null || v.isEmpty ? "Please select a class" : null,
                onChanged: (v) => selectedClass = v,
              ),
              _dropdownField(
                icon: Icons.person_outline,
                hint: "Select a parent (optional)",
                items: const ["Parent A", "Parent B", "Parent C"],
                validator: (v) => null, // optional
                onChanged: (v) => selectedParent = v,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Saving student...")),
                    );

                    // API call later
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Save Student",
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
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
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

  Widget _dropdownField({
    required IconData icon,
    required String hint,
    List<String>? items,
    String? Function(String?)? validator,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: items
            ?.map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
