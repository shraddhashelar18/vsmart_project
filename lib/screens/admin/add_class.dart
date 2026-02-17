import 'package:flutter/material.dart';
import '../../mock/mock_class_data.dart';
import '../../mock/mock_teacher_data.dart';
import '../../mock/mock_teacher_departments.dart';

class AddClass extends StatefulWidget {
  final String? className; // null = add, not null = edit

  const AddClass({Key? key, this.className}) : super(key: key);

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  static const green = Color(0xFF009846);

  final _formKey = GlobalKey<FormState>();
  final _classNameCtrl = TextEditingController();

  String? _selectedDepartment;
  String? _selectedTeacher;

  bool get isEdit => widget.className != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final c = mockClasses[widget.className]!;
      _classNameCtrl.text = widget.className!;
      _selectedDepartment = c["department"];
      _selectedTeacher = c["teacher"];
    }
  }

  /// 🔥 TEACHERS ONLY OF SELECTED DEPARTMENT
  List<String> _teachersForDept(String? dept) {
    if (dept == null) return [];

    final ids = mockTeacherDepartments.entries
        .where((e) => e.value.contains(dept))
        .map((e) => e.key)
        .toList();

    return ids.map((id) => mockTeachers[id]!["name"]!).toList();
  }

  @override
  Widget build(BuildContext context) {
    final teacherList = _teachersForDept(_selectedDepartment);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: green,
        title: Text(isEdit ? "Edit Class" : "Add Class"),
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
                enabled: !isEdit, // 🔒 LOCK IN EDIT
              ),

              const SizedBox(height: 16),

              _label("Department"),
              _dropdown(
                hint: "Select department",
                items: const ["IF", "CO", "EJ"],
                value: _selectedDepartment,
                enabled: !isEdit, // 🔒 LOCK IN EDIT
                onChanged: (v) {
                  setState(() {
                    _selectedDepartment = v;
                    _selectedTeacher = null;
                  });
                },
              ),

              const SizedBox(height: 16),

              _label("Class Teacher"),
              _dropdown(
                hint: "Select class teacher",
                items: teacherList,
                value: _selectedTeacher,
                onChanged: (v) => setState(() => _selectedTeacher = v),
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
                        "Note: Students and teachers can be assigned later.",
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
                onPressed: _saveClass,
                child: Text(
                  isEdit ? "Update Class" : "Save Class",
                  style: const TextStyle(color: Colors.white),
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
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveClass() {
    if (!_formKey.currentState!.validate()) return;

    final name = _classNameCtrl.text;

    mockClasses[name] = {
      "department": _selectedDepartment ?? "",
      "teacher": _selectedTeacher ?? "",
    };

    Navigator.pop(context);
  }

  // ---------- UI WIDGETS (UNCHANGED STYLE) ----------

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      );

  Widget _textField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
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
    required Function(String?) onChanged,
    String? value,
    bool enabled = true,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: enabled ? onChanged : null,
    );
  }
}
