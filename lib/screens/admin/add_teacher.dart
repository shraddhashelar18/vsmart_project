import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';
import '../../mock/mock_teacher_departments.dart';
import '../../mock/mock_teacher_classes.dart';
import '../../mock/mock_teacher_subjects.dart';
import '../../mock/mock_academics.dart';

class AddTeacher extends StatefulWidget {
  final String department;
  final int? teacherId;

  const AddTeacher({
    Key? key,
    required this.department,
    this.teacherId,
  }) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  List<String> selectedDepartments = [];
  List<String> selectedClasses = [];

  bool get isEdit => widget.teacherId != null;

  // 🔹 ALL CLASSES WITH A B C
  final List<String> allClasses = [
    "IF1KA",
    "IF1KB",
    "IF1KC",
    "IF2KA",
    "IF2KB",
    "IF2KC",
    "IF3KA",
    "IF3KB",
    "IF3KC",
    "IF4KA",
    "IF4KB",
    "IF4KC",
    "IF5KA",
    "IF5KB",
    "IF5KC",
    "IF6KA",
    "IF6KB",
    "IF6KC",
    "CO1KA",
    "CO1KB",
    "CO1KC",
    "CO2KA",
    "CO2KB",
    "CO2KC",
    "CO3KA",
    "CO3KB",
    "CO3KC",
    "CO4KA",
    "CO4KB",
    "CO4KC",
    "CO5KA",
    "CO5KB",
    "CO5KC",
    "CO6KA",
    "CO6KB",
    "CO6KC",
    "EJ1KA",
    "EJ1KB",
    "EJ1KC",
    "EJ2KA",
    "EJ2KB",
    "EJ2KC",
    "EJ3KA",
    "EJ3KB",
    "EJ3KC",
    "EJ4KA",
    "EJ4KB",
    "EJ4KC",
    "EJ5KA",
    "EJ5KB",
    "EJ5KC",
    "EJ6KA",
    "EJ6KB",
    "EJ6KC",
  ];

  final Map<String, List<String>> semesterSubjects = {
    "IF1K": ["Maths1", "Physics"],
    "IF2K": ["C", "Maths2"],
    "IF3K": ["DBMS"],
    "IF4K": ["Java"],
    "IF5K": ["OS"],
    "IF6K": ["Networking"],
    "CO4K": ["SOM"],
  };

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final t = mockTeachers[widget.teacherId]!;
      _nameCtrl.text = t["name"]!;
      _emailCtrl.text = t["email"]!;

      selectedDepartments =
          List.from(mockTeacherDepartments[widget.teacherId] ?? []);
      selectedClasses = List.from(mockTeacherClasses[widget.teacherId] ?? []);
    } else {
      selectedDepartments = [widget.department];
    }
  }

  List<String> _classesForDept(String dept) {
    return allClasses.where((c) {
      if (!c.startsWith(dept)) return false;

      final sem = int.parse(c[2]);

      if (activeSemType == "EVEN") {
        return sem % 2 == 0;
      } else {
        return sem % 2 != 0;
      }
    }).toList();
  }

  String _baseClass(String cls) {
    return cls.substring(0, cls.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final int teacherKey = widget.teacherId ?? -1;
    mockTeacherSubjects[teacherKey] ??= {};

    final visibleClasses =
        isEdit ? allClasses : _classesForDept(widget.department);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009846),
        title: Text(isEdit ? "Edit Teacher" : "Add Teacher"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Teacher Name"),
            _field(_nameCtrl, Icons.person, "Enter full name"),

            const SizedBox(height: 12),
            _label("Email"),
            _field(_emailCtrl, Icons.email, "teacher@email.com",
                enabled: !isEdit),

            if (!isEdit) ...[
              const SizedBox(height: 12),
              _label("Password"),
              _field(_passwordCtrl, Icons.lock, "Enter password"),
            ],

            const SizedBox(height: 16),
            _label("Departments"),
            Wrap(
              spacing: 8,
              children: ["IF", "CO", "EJ"].map((dept) {
                return FilterChip(
                  label: Text(dept),
                  selected: selectedDepartments.contains(dept),
                  onSelected: isEdit
                      ? (val) {
                          setState(() {
                            val
                                ? selectedDepartments.add(dept)
                                : selectedDepartments.remove(dept);
                          });
                        }
                      : null,
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            _label("Assign Classes"),
            Wrap(
              spacing: 8,
              children: visibleClasses.map((cls) {
                return FilterChip(
                  label: Text(cls),
                  selected: selectedClasses.contains(cls),
                  onSelected: (val) {
                    setState(() {
                      val
                          ? selectedClasses.add(cls)
                          : selectedClasses.remove(cls);
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            _label("Subjects"),
            ...selectedClasses.map((cls) {
              final base = _baseClass(cls);
              final subjects = semesterSubjects[base] ?? [];

              mockTeacherSubjects[teacherKey]![cls] ??= [];
              final selectedSubs = mockTeacherSubjects[teacherKey]![cls]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cls,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 8,
                    children: subjects.map((sub) {
                      return FilterChip(
                        label: Text(sub),
                        selected: selectedSubs.contains(sub),
                        onSelected: (val) {
                          setState(() {
                            val
                                ? selectedSubs.add(sub)
                                : selectedSubs.remove(sub);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }),

            const SizedBox(height: 20),

            // 🔹 FIXED SAVE BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                if (isEdit) {
                  final id = widget.teacherId!;
                  mockTeacherDepartments[id] = selectedDepartments;
                  mockTeacherClasses[id] = selectedClasses;
                } else {
                  final newId = mockTeachers.keys.isEmpty
                      ? 1
                      : mockTeachers.keys.last + 1;

                  mockTeachers[newId] = {
                    "name": _nameCtrl.text,
                    "email": _emailCtrl.text,
                    "phone": "0000000000",
                  };

                  mockTeacherDepartments[newId] = selectedDepartments;
                  mockTeacherClasses[newId] = selectedClasses;
                }

                Navigator.pop(context);
              },
              child: Text(isEdit ? "Update Teacher" : "Save Teacher"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) =>
      Text(t, style: const TextStyle(fontWeight: FontWeight.w600));

  Widget _field(TextEditingController c, IconData i, String h,
      {bool enabled = true}) {
    return TextField(
      controller: c,
      enabled: enabled,
      decoration: InputDecoration(
        prefixIcon: Icon(i),
        hintText: h,
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
