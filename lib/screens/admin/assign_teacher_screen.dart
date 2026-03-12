import 'package:flutter/material.dart';
// contains UserAuth
import '../../services/app_settings_service.dart';
import '../../services/user_service.dart';
import '../../models/registration_request_model.dart';
import '../../services/teacher_assignment_service.dart';
class AssignTeacherScreen extends StatefulWidget {
  final RegistrationRequest request;
  final String department;

  const AssignTeacherScreen({
    Key? key,
    required this.request,
    required this.department,
  }) : super(key: key);

  @override
  State<AssignTeacherScreen> createState() => _AssignTeacherScreenState();
}


class _AssignTeacherScreenState extends State<AssignTeacherScreen> {
  String? selectedDept;
  String? selectedClass;
  List<String> selectedSubjects = [];

  final AppSettingsService _settingsService = AppSettingsService();
  String activeSemester = "EVEN";

final TeacherAssignmentService _service = TeacherAssignmentService();

 List<String> departments = ["IF", "CO", "EJ"];

  List<String> classes = [];
  List<String> subjects = [];
  List<String> allocatedSubjects = [];
  Future<void> loadClasses(String dept) async {
    final data = await _service.getClasses(dept);

    // filter using active semester
    List<String> filtered = data.where((cls) {
      int sem = int.parse(cls.substring(2, 3));

      if (activeSemester == "EVEN") {
        return sem.isEven;
      } else {
        return sem.isOdd;
      }
    }).toList();

    setState(() {
      classes = filtered;
      selectedClass = null;
      subjects.clear();
    });
  }
  Future<void> loadSubjects(String className) async {
    final subjectList = await _service.getSubjects(className);
    final allocated = await _service.getAllocated(className);

    print("SUBJECTS: $subjectList");
    print("ALLOCATED: $allocated");

    setState(() {
      subjects = subjectList;
      allocatedSubjects = allocated;
      selectedSubjects.clear();
    });
  }
@override
  void initState() {
    super.initState();
    loadSemester();
  }
  Future<void> loadSemester() async {
    final sem = await _settingsService.getActiveSemester();

    setState(() {
      activeSemester = sem;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Teacher"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Show Teacher Info
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF009846),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(widget.request.email),
                subtitle: const Text("Role: Teacher"),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Department Dropdown
          DropdownButtonFormField<String>(
              value: selectedDept,
              decoration: const InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
              items: departments
                  .map((d) => DropdownMenuItem(
                        value: d,
                        child: Text(d),
                      ))
                  .toList(),
              onChanged: (value) async {
                setState(() {
                  selectedDept = value;
                  selectedClass = null;
                  subjects.clear();
                });

                if (value != null) {
                  await loadClasses(value);
                }
              },
            ),
            const SizedBox(height: 20),
if (selectedDept != null)
              DropdownButtonFormField<String>(
                value: selectedClass,
                decoration: const InputDecoration(
                  labelText: "Class",
                  border: OutlineInputBorder(),
                ),
                items: classes
                    .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(c),
                        ))
                    .toList(),
                onChanged: (value) async {
                  setState(() {
                    selectedClass = value;
                  });

                  if (value != null) {
                    await loadSubjects(value);
                  }
                },
              ),
            // 🔹 Subjects (only after class selected)
          if (selectedClass != null)
              Expanded(
                child: ListView(
                  children: subjects.map((subject) {
                    bool isAllocated = allocatedSubjects.contains(subject);

                    return CheckboxListTile(
                      value: selectedSubjects.contains(subject),
                      onChanged: isAllocated
                          ? null
                          : (value) {
                              setState(() {
                                if (value == true) {
                                  selectedSubjects.add(subject);
                                } else {
                                  selectedSubjects.remove(subject);
                                }
                              });
                            },
                      title: Text(
                        isAllocated ? "$subject (Allocated)" : subject,
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 10),

            // 🔹 Assign Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009846),
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: selectedClass == null || selectedSubjects.isEmpty
                    ? null
                    : () async {
                        // Later you will save dept/class/subjects here

                       await _service.assignTeacher(
                          widget.request.requestId,
                          selectedDept!,
                          selectedClass!,
                          selectedSubjects,
                        );

                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                child: const Text(
                  "Assign & Approve",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
