import 'package:flutter/material.dart';

class AddClass extends StatelessWidget {
  AddClass({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  final _formKey = GlobalKey<FormState>();
  final _classNameCtrl = TextEditingController();
  String? _selectedDepartment;
  String? _selectedTeacher;

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
        title: const Text("Add Class"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Fill in class details",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Class Name"),
              _textField(
                hint: "Enter class name (e.g. IF6K-A)",
                icon: Icons.class_,
                controller: _classNameCtrl,
                validator: (v) {
  if (v == null || v.isEmpty) {
    return "Class name is required";
  }
  if (RegExp(r'^[0-9]+$').hasMatch(v)) {
    return "Class name cannot be only numbers";
  }
  return null;
},

              ),
              const SizedBox(height: 16),
              _label("Department"),
              _dropdown(
                hint: "Select department",
                items: const ["IT", "CO", "EJ"],
                onChanged: (v) => _selectedDepartment = v,
                validator: (v) =>
                    v == null ? "Please select a department" : null,
              ),
              const SizedBox(height: 16),
              _label("Class Teacher"),
              _dropdown(
                hint: "Select class teacher",
                items: const [
                  "Prof Sunil Dodake",
                  "Mrs Sushma Pawar",
                  "Mrs Gauri Bobade",
                ],
                onChanged: (v) => _selectedTeacher = v,
                validator: (v) =>
                    v == null ? "Please select a class teacher" : null,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Note: Students and teachers can be assigned to this class later.",
                        style: TextStyle(fontSize: 13),
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
                      const SnackBar(content: Text("Saving class...")),
                    );

                    // save class later
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Save Class",
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Reusable widgets ----------

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      );

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String hint,
    required List<String> items,
    String? Function(String?)? validator,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
