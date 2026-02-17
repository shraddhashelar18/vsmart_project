import 'package:flutter/material.dart';
import '../../mock/mock_parent_data.dart';

class AddParent extends StatefulWidget {
  final String? parentPhone; // null = add, not null = edit

  const AddParent({Key? key, this.parentPhone}) : super(key: key);

  @override
  State<AddParent> createState() => _AddParentState();
}

class _AddParentState extends State<AddParent> {
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

    if (isEdit) {
      final p = mockParents[widget.parentPhone]!;
      _nameCtrl.text = p["name"] ?? "";
      _emailCtrl.text = p["email"] ?? "";
      _phoneCtrl.text = widget.parentPhone!;
      _enrollCtrl.text = p["children"][0];
    }
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
                onPressed: _saveParent,
                child: Text(isEdit ? "Update Parent" : "Save Parent"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveParent() {
    if (!_formKey.currentState!.validate()) return;

    final phone = _phoneCtrl.text;

    mockParents[phone] = {
      "name": _nameCtrl.text,
      "email": _emailCtrl.text,
       "password": _passwordCtrl.text, 
      "children": [_enrollCtrl.text],
    };

    Navigator.pop(context);
  }

  Widget _field(TextEditingController c, String hint, IconData i,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        enabled: enabled,
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
