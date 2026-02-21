import 'package:flutter/material.dart';
import '../../services/teacher_new_service.dart';
import '../../services/class_service.dart';

class AddClass extends StatefulWidget {
  final String? className;
  final String department; // 🔥 ADD THIS

  const AddClass({
    Key? key,
    this.className,
    required this.department,
  }) : super(key: key);

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final TeacherNewService _teacherService = TeacherNewService();
  final ClassService _classService = ClassService();
  static const green = Color(0xFF009846);

  final _formKey = GlobalKey<FormState>();
  final _classNameCtrl = TextEditingController();

  String? _selectedDepartment;
  String? _selectedTeacher;

  bool get isEdit => widget.className != null;

  @override
  void initState() {
    super.initState();

    // ALWAYS FROM PREVIOUS SCREEN
    _selectedDepartment = widget.department;

    if (isEdit) {
      final c = _classService.getClass(widget.className!) ?? {};
      _classNameCtrl.text = widget.className ?? "";
      _selectedTeacher = c["teacher"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> teacherList = _selectedDepartment == null
        ? <String>[]
        : _teacherService.getTeacherNamesByDepartment(_selectedDepartment!);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(isEdit ? "Edit Class" : "Add Class"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                isEdit ? "Update class details" : "Fill in class details",
                style: const TextStyle(color: Colors.white70, fontSize: 13),
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
              /// CLASS NAME
              _label("Class Name"),
              _textField(
                hint: "Enter class name (e.g. IF6KA)",
                icon: Icons.class_,
                controller: _classNameCtrl,
                enabled: true, // EDITABLE
              ),

              const SizedBox(height: 16),

              /// DEPARTMENT
              _label("Department"),

              TextFormField(
                enabled: false,
                initialValue: _selectedDepartment ?? "",
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.school),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// CLASS TEACHER
              _label("Class Teacher"),

              DropdownButtonFormField<String>(
                value: teacherList.contains(_selectedTeacher)
                    ? _selectedTeacher
                    : null,
                decoration: InputDecoration(
                  hintText: "Select class teacher",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: teacherList.map((teacherName) {
                  final assignedClass =
                      _classService.getClassWhereTeacherAssigned(teacherName);

                  final isAssignedElsewhere = assignedClass != null &&
                      assignedClass != widget.className;

                  return DropdownMenuItem<String>(
                    value: isAssignedElsewhere ? null : teacherName,
                    enabled: !isAssignedElsewhere,
                    child: Text(
                      isAssignedElsewhere
                          ? "$teacherName ($assignedClass)"
                          : teacherName,
                      style: TextStyle(
                        color: isAssignedElsewhere ? Colors.grey : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedTeacher = value);
                },
              ),
              const SizedBox(height: 16),

              /// NOTE BOX
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
                        "Students and teachers can be assigned later.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SAVE BUTTON
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

              /// CANCEL
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

    final name = _classNameCtrl.text.trim();

    _classService.saveClass(
      name: name,
      department: _selectedDepartment ?? "",
      teacher: _selectedTeacher ?? "",
    );

    Navigator.pop(context);
  }

  // ---------- UI HELPERS (UNCHANGED STYLE) ----------

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
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
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
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: enabled ? onChanged : null,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    );
  }
}
