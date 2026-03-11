import 'package:flutter/material.dart';
import '../../services/app_settings_service.dart';
import '../../services/teacher_new_service.dart';
import '../../services/attendance_service.dart';
import 'package:flutter/services.dart';

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
  final TeacherNewService _teacherService = TeacherNewService();
 

  String activeSemester = "EVEN";

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
final _phoneCtrl = TextEditingController();
final _employeeCtrl = TextEditingController();

  List<String> selectedDepartments = [];
  List<String> selectedClasses = [];
  List<String> visibleClasses = [];

  /// 🔥 Subjects stored locally (NO MOCK ACCESS)
  Map<String, List<String>> selectedSubjectsPerClass = {};
Map<String, List<String>> subjectCache = {};
  bool get isEdit => widget.teacherId != null;

  /// Example Subject Mapping
  

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    activeSemester = await _settingsService.getActiveSemester();

    if (isEdit) {
      final teacher = await _teacherService.getTeacherDetail(widget.teacherId!);

      if (teacher != null) {
        _nameCtrl.text = teacher["name"];
        _emailCtrl.text = teacher["email"];
_phoneCtrl.text = teacher["phone"] ?? "";
_employeeCtrl.text = teacher["employee_id"] ?? "";
        selectedDepartments = List<String>.from(teacher["departments"] ?? []);

        selectedClasses = List<String>.from(teacher["classes"] ?? []);

        /// FIX SUBJECT MAP CONVERSION
        final subjects = teacher["subjects"] ?? {};

        selectedSubjectsPerClass = {};

        subjects.forEach((className, subs) {
          selectedSubjectsPerClass[className] = List<String>.from(subs);
        });
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
      final deptClasses = await _teacherService.getClasses(dept);

      for (var cls in deptClasses) {
        int sem = int.parse(cls.substring(2, 3));

        if (!isEdit) {
          // ADD screen → only current semester
          if (activeSemester == "ODD" && sem.isOdd) {
            result.add(cls);
          } else if (activeSemester == "EVEN" && sem.isEven) {
            result.add(cls);
          }
        } else {
          // EDIT screen → current semester classes
          if (activeSemester == "ODD" && sem.isOdd) {
            result.add(cls);
          } else if (activeSemester == "EVEN" && sem.isEven) {
            result.add(cls);
          }
        }
      }
    }

    /// 🔥 IMPORTANT: also include previously assigned classes
    for (var cls in selectedClasses) {
      if (!result.contains(cls)) {
        result.add(cls);
      }
    }

    visibleClasses = result;
  }
  String _baseClass(String cls) {
    return cls.substring(0, cls.length - 1);
  }
Future<List<String>> _getSubjects(String className) async {
    if (subjectCache.containsKey(className)) {
      return subjectCache[className]!;
    }

    final subjects = await _teacherService.getSubjects(className);

    subjectCache[className] = subjects;

    return subjects;
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
const SizedBox(height: 12),
            _label("Phone"),
            TextField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 10,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                hintText: "Enter phone number",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
           _label("Employee ID"),
            TextField(
              controller: _employeeCtrl,
              enabled: !isEdit,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 10,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.badge),
                hintText: "Enter 10 digit employee ID",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

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
                                _getSubjects(cls);
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
              selectedSubjectsPerClass[cls] ??= [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cls,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  FutureBuilder<List<String>>(
                    future: _getSubjects(cls),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        );
                      }

                      final subjects = snapshot.data!;
                      final selectedSubs = selectedSubjectsPerClass[cls]!;

                      return Wrap(
                        spacing: 8,
                        children: subjects.map((sub) {
                          return FilterChip(
                            label: Text(sub),
                            selected: selectedSubs.contains(sub),
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  selectedSubs.add(sub);
                                } else {
                                  selectedSubs.remove(sub);
                                }
                              });
                            },
                          );
                        }).toList(),
                      );
                    },
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
                if (_nameCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter teacher name")),
                  );
                  return;
                }
                if (_emailCtrl.text.isEmpty || !_emailCtrl.text.contains("@")) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter valid email")),
                  );
                  return;
                }
                if (_phoneCtrl.text.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Enter valid 10 digit phone number")),
                  );
                  return;
                  
                }
                if (!isEdit && _passwordCtrl.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Password must be at least 6 characters")),
                  );
                  return;
                }
                if (_employeeCtrl.text.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Employee ID must be 10 digits")),
                  );
                  return;
                }
                int teacherId;

                if (isEdit) {
                  teacherId = widget.teacherId!;

                  await _teacherService.updateTeacher(
                    userId: teacherId,
                    name: _nameCtrl.text,
                    phone: _phoneCtrl.text,
                    subjects: _formatSubjectsForUpdate(),
                  );
                } else {
                  await _teacherService.addTeacher(
                    employeeId: _employeeCtrl.text,
                    name: _nameCtrl.text,
                    email: _emailCtrl.text,
                    password: _passwordCtrl.text,
                    phone: _phoneCtrl.text,
                    subjects: _formatSubjectsForUpdate(),
                  );

                  teacherId = 0;
                }

                /// 🔥 Save Subjects Through Service
               
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
  
  Map<String, Map<String, List<String>>> _formatSubjectsForUpdate() {
    Map<String, Map<String, List<String>>> result = {};

    selectedSubjectsPerClass.forEach((className, subjects) {
      String dept = className.substring(0, 2); // IF, CO, EJ

      result.putIfAbsent(dept, () => {});
      result[dept]![className] = subjects;
    });

    return result;
  }
}
