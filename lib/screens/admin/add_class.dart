import 'package:flutter/material.dart';
import '../../services/teacher_new_service.dart';
import '../../services/class_service.dart';

class AddClass extends StatefulWidget {
final String? className;
final String department;
  final int? teacherId;
  final String? assignedClass;
const AddClass({
  Key? key,
  this.className,
  required this.department,
  this.teacherId,
  this.assignedClass,
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

List<Map<String, dynamic>> _teachers = [];
bool _loadingTeachers = true;

String? _selectedDepartment;
String? _selectedTeacher;

bool get isEdit => widget.className != null;
@override
  void initState() {
    super.initState();

    _selectedDepartment = widget.department;
_selectedTeacher = widget.teacherId?.toString();
    _loadTeachers();

    if (isEdit) {
      _classNameCtrl.text = widget.className ?? "";
    }
  }

Future<void> _loadTeachers() async {
final teachers =
await _teacherService.getTeachers(_selectedDepartment ?? "");


setState(() {
  _teachers = teachers;
  _loadingTeachers = false;
});

}

@override
Widget build(BuildContext context) {
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

          _loadingTeachers
              ? const Center(child: CircularProgressIndicator())
              : DropdownButtonFormField<int>(
                isExpanded: true,
                 value:
                          (_selectedTeacher == null || _selectedTeacher == "0")
                              ? null
                              : int.tryParse(_selectedTeacher!),
                  decoration: InputDecoration(
                    hintText: "Select class teacher",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                 items: _teachers.map((teacher) {
                        final teacherId = teacher["id"];
                        final teacherName = teacher["name"];

                        final isAssigned = teacherId != widget.teacherId &&
                            teacher["class_name"] != null &&
                            teacher["class_name"] != "";

                        return DropdownMenuItem<int>(
                          value: teacherId,
                          enabled: !isAssigned,
                          child: Text(
                            isAssigned
                                ? "$teacherName (Assigned to ${teacher["class_name"]})"
                                : teacherName,
                            style: TextStyle(
                              color: isAssigned ? Colors.grey : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedTeacher = value.toString());
                  },
                ),

          const SizedBox(height: 16),

          /// INFO BOX
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

Future<void> _saveClass() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedTeacher == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select class teacher")),
      );
      return;
    }

    final name = _classNameCtrl.text.trim();

    if (isEdit) {
      await _classService.updateClassTeacher(
        className: name,
        teacherId: int.parse(_selectedTeacher!),
      );
    } else {
      await _classService.addClass(
        className: name,
        department: _selectedDepartment!,
        teacherId: int.parse(_selectedTeacher!),
      );
    }

    Navigator.pop(context);
  }
/// UI HELPERS

Widget _label(String text) => Padding(
padding: const EdgeInsets.only(bottom: 6),
child: Text(
text,
style: const TextStyle(fontWeight: FontWeight.w600),
),
);

Widget _textField({
required String hint,
required IconData icon,
required TextEditingController controller,
}) {
return TextFormField(
controller: controller,
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
}
