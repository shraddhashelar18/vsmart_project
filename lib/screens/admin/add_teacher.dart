import 'package:flutter/material.dart';
import '../../services/app_settings_service.dart';
import '../../services/teacher_new_service.dart';
import '../../services/attendance_service.dart';
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
  final AppSettingsService _settingsService = AppSettingsService();
  final TeacherService _teacherService = TeacherService();
  final AttendanceService _attendanceService = AttendanceService();

  String activeSemester = "EVEN";

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  List<String> selectedDepartments = [];
  List<String> selectedClasses = [];
  List<String> visibleClasses = [];

  /// 🔥 Subjects stored locally (NO MOCK ACCESS)
  Map<String, List<String>> selectedSubjectsPerClass = {};

  bool get isEdit => widget.teacherId != null;

  /// Example Subject Mapping
  final Map<String, List<String>> semesterSubjects = {
    "IF1K": ["Maths1", "Physics"],
    "IF2K": ["C", "Maths2"],
    "IF3K": ["DBMS"],
    "IF4K": ["Java"],
    "IF5K": ["OS"],
    "IF6K": ["Networking", "JAVA"],
    "CO4K": ["SOM"],
  };

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    activeSemester = await _settingsService.getActiveSemester();

    if (isEdit) {
      final teacher = await _teacherService.getTeacherById(widget.teacherId!);

      if (teacher != null) {
        _nameCtrl.text = teacher["name"];
        _emailCtrl.text = teacher["email"];
        selectedDepartments = List<String>.from(teacher["departments"]);
        selectedClasses = List<String>.from(teacher["classes"]);

        /// 🔥 Load existing subjects
        selectedSubjectsPerClass =
            Map<String, List<String>>.from(teacher["subjects"]);
      }
    } else {
      selectedDepartments = [widget.department];
    }

    await _loadClasses();
    setState(() {});
  }

  Future<void> _loadClasses() async {
    List<String> result = [];

    for (String dept in selectedDepartments) {
      if (isEdit) {
        /// EDIT → show ALL classes
        final years = mockAcademics[dept] ?? {};
        years.forEach((year, sems) {
          sems.forEach((semName, classList) {
            result.addAll(classList);
          });
        });
      } else {
        /// ADD → only active semester
        final deptClasses = await _attendanceService.getClasses(dept);
        result.addAll(deptClasses);
      }
    }

    visibleClasses = result;
  }

  String _baseClass(String cls) {
    return cls.substring(0, cls.length - 1);
  }

  @override
  Widget build(BuildContext context) {
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
            /// =========================
            /// BASIC INFO
            /// =========================
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

            /// =========================
            /// DEPARTMENTS
            /// =========================
            /// =========================
            /// DEPARTMENTS
            /// =========================
            _label("Departments"),

            isEdit
                ? Wrap(
                    spacing: 8,
                    children: ["IF", "CO", "EJ"].map((dept) {
                      return FilterChip(
                        label: Text(dept),
                        selected: selectedDepartments.contains(dept),
                        onSelected: (val) async {
                          setState(() {
                            val
                                ? selectedDepartments.add(dept)
                                : selectedDepartments.remove(dept);

                            selectedClasses.removeWhere((cls) =>
                                !selectedDepartments
                                    .any((d) => cls.startsWith(d)));
                          });

                          await _loadClasses();
                          setState(() {});
                        },
                      );
                    }).toList(),
                  )
                : Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: Text(widget.department),
                        selected: true,
                        onSelected: null, // 🔒 LOCKED
                      ),
                    ],
                  ),

            const SizedBox(height: 16),

            /// =========================
            /// CLASSES
            /// =========================
            _label("Assign Classes"),
            const SizedBox(height: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedDepartments.map((dept) {
                final deptClasses =
                    visibleClasses.where((c) => c.startsWith(dept)).toList();

                if (deptClasses.isEmpty) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    /// 🔹 Department Title
                    Text(
                      "$dept Department",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 🔹 Classes
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: deptClasses.map((cls) {
                        return FilterChip(
                          label: Text(cls),
                          selected: selectedClasses.contains(cls),
                          onSelected: (val) {
                            setState(() {
                              if (val) {
                                selectedClasses.add(cls);
                                selectedSubjectsPerClass[cls] ??= [];
                              } else {
                                selectedClasses.remove(cls);
                                selectedSubjectsPerClass.remove(cls);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 12),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            /// =========================
            /// SUBJECTS PER CLASS
            /// =========================
            _label("Subjects"),
            ...selectedClasses.map((cls) {
              final base = _baseClass(cls);
              final subjects = semesterSubjects[base] ?? [];

              selectedSubjectsPerClass[cls] ??= [];
              final selectedSubs = selectedSubjectsPerClass[cls]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cls,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 8,
                    children: subjects.map((sub) {
                      final isTaken = _teacherService.isSubjectAlreadyAssigned(
                        className: cls,
                        subject: sub,
                        excludeTeacherId: widget.teacherId,
                      );

                      return FilterChip(
                        label: Text(sub),
                        selected: selectedSubs.contains(sub),
                        onSelected: isTaken
                            ? null // 🔒 disables chip
                            : (val) {
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

            /// =========================
            /// SAVE
            /// =========================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () async {
                int teacherId;

                if (isEdit) {
                  teacherId = widget.teacherId!;

                  await _teacherService.updateTeacher(
                    id: teacherId,
                    name: _nameCtrl.text,
                    phone: "0000000000",
                    departments: selectedDepartments,
                    classes: selectedClasses,
                  );
                } else {
                  await _teacherService.addTeacher(
                    name: _nameCtrl.text,
                    email: _emailCtrl.text,
                    phone: "0000000000",
                    departments: selectedDepartments,
                    classes: selectedClasses,
                  );

                  final teachers = await _teacherService.getAllTeachers();
                  teacherId = teachers.last["id"];
                }

                /// 🔥 Save Subjects Through Service
                await _teacherService.saveTeacherSubjects(
                  teacherId: teacherId,
                  subjectsPerClass: selectedSubjectsPerClass,
                );

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
