import 'package:flutter/material.dart';
import '../../services/parent_service.dart';

class AddParent extends StatefulWidget {
  final String? parentPhone; // null = add, not null = edit

  const AddParent({Key? key, this.parentPhone}) : super(key: key);

  @override
  State<AddParent> createState() => _AddParentState();
}

class _AddParentState extends State<AddParent> {
  final ParentService _parentService = ParentService();
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _enrollCtrl = TextEditingController();

  bool get isEdit => widget.parentPhone != null;

  @override
  void initState() {
    super.initState();
    _loadParent();
  }

  Future<void> _loadParent() async {
    if (!isEdit) return;

    final p = await _parentService.getParent(widget.parentPhone!);

    if (p == null) return;

    setState(() {
      _nameCtrl.text = p["name"] ?? "";
      _emailCtrl.text = p["email"] ?? "";
      _phoneCtrl.text = widget.parentPhone!;
      _enrollCtrl.text =
          (p["children"] as List).isNotEmpty ? p["children"][0] : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: Text(isEdit ? "Edit Parent" : "Add Parent"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_nameCtrl, "Parent Name", Icons.person),
              _field(_emailCtrl, "Email", Icons.email, enabled: !isEdit),
              if (!isEdit) ...[
                _field(_passwordCtrl, "Password", Icons.lock),
              ],
              _field(_phoneCtrl, "Phone Number", Icons.phone),
              _field(
                _enrollCtrl,
                "Student Enrollment",
                Icons.badge,
                enabled: !isEdit, // 🔒 LOCK IN EDIT
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009846),
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () async {
                  await _saveParent();
                },
                child: Text(
                  isEdit ? "Update Parent" : "Save Parent",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveParent() async {
    if (!_formKey.currentState!.validate()) return;

    bool success = false;

    if (isEdit) {
      success = await _parentService.updateParent(
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        oldPhone: widget.parentPhone!,
      );
    } else {
      success = await _parentService.addParent(
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        phone: _phoneCtrl.text,
        children: [_enrollCtrl.text],
      );
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEdit ? "Parent updated" : "Parent added")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Operation failed")),
      );
    }
  }
  Widget _field(TextEditingController c, String hint, IconData i,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        enabled: enabled,
        validator: (v) {
          if (v == null || v.isEmpty) return "Required";

          // Email validation
          if (hint == "Email") {
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
              return "Enter valid email";
            }
          }

          // Phone validation
          if (hint == "Phone Number") {
            if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
              return "Phone must be 10 digits";
            }
          }

          // Enrollment validation
          if (hint == "Student Enrollment") {
            if (v.length < 5) {
              return "Invalid enrollment";
            }
          }

          return null;
        },
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
