import 'package:flutter/material.dart';
import '../../mock/mock_student_data.dart';

class AddStudent extends StatefulWidget {
  final String? enrollment; // null = add, not null = edit
  final String className;

  const AddStudent({
    Key? key,
    this.enrollment,
    required this.className,
  }) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController(); // 🔹 NEW
  final _phoneCtrl = TextEditingController();
  final _parentPhoneCtrl = TextEditingController();
  final _rollCtrl = TextEditingController();
  final _enrollCtrl = TextEditingController();

  bool get isEdit => widget.enrollment != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final s = mockStudents[widget.enrollment]!;
      _nameCtrl.text = s["name"] ?? "";
      _emailCtrl.text = s["email"] ?? "";
      _phoneCtrl.text = s["phone"] ?? "";
      _parentPhoneCtrl.text = s["parentPhone"] ?? "";
      _rollCtrl.text = s["roll"] ?? "";
      _enrollCtrl.text = widget.enrollment!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: Text(isEdit ? "Edit Student" : "Add Student"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_nameCtrl, "Full Name", Icons.person),
              _field(_emailCtrl, "Email", Icons.email, enabled: !isEdit),

              /// 🔹 PASSWORD ONLY IN ADD
              if (!isEdit)
                _field(_passwordCtrl, "Password", Icons.lock, obscure: true),

              _field(_phoneCtrl, "Mobile", Icons.phone),
              _field(_parentPhoneCtrl, "Parent Mobile", Icons.phone),
              _field(_rollCtrl, "Roll No", Icons.badge),
              _field(_enrollCtrl, "Enrollment", Icons.numbers,
                  enabled: !isEdit),

              /// 🔒 CLASS — VIEW ONLY
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  enabled: false,
                  initialValue: widget.className,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.school),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009846),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: _saveStudent,
                child: Text(isEdit ? "Update Student" : "Save Student"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveStudent() {
    if (!_formKey.currentState!.validate()) return;

    final enrollment = _enrollCtrl.text;

    mockStudents[enrollment] = {
      "name": _nameCtrl.text,
      "email": _emailCtrl.text,
      "password": _passwordCtrl.text, // 🔹 NEW
      "phone": _phoneCtrl.text,
      "parentPhone": _parentPhoneCtrl.text,
      "roll": _rollCtrl.text,
      "class": widget.className,
    };

    Navigator.pop(context);
  }

  Widget _field(TextEditingController c, String hint, IconData i,
      {bool enabled = true, bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        enabled: enabled,
        obscureText: obscure, // 🔹 NEW
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(i),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
