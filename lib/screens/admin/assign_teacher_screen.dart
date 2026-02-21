import 'package:flutter/material.dart';
// contains UserAuth
import '../../services/user_service.dart';
import '../../models/registration_request_model.dart';

class AssignTeacherScreen extends StatefulWidget {
  final RegistrationRequest request;

  const AssignTeacherScreen({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  State<AssignTeacherScreen> createState() => _AssignTeacherScreenState();
}

class _AssignTeacherScreenState extends State<AssignTeacherScreen> {
  String? selectedDept;
  String? selectedClass;
  List<String> selectedSubjects = [];

  final UserService _service = UserService();

  // 🔹 Mock Department → Classes
  final Map<String, List<String>> deptClasses = {
    "IF": ["IF6KA", "IF6KB"],
    "CO": ["CO6KA", "CO6KB"],
    "EJ": ["EJ6KA"],
  };

  // 🔹 Mock Class → Subjects
  final Map<String, List<String>> classSubjects = {
    "IF6KA": ["Java", "DBMS", "Python"],
    "IF6KB": ["Java", "DBMS", "Python"],
    "CO6KA": ["OS", "CN", "Java"],
    "CO6KB": ["OS", "CN", "Java"],
    "EJ6KA": ["Microprocessor", "Electronics"],
  };

  // 🔹 Mock Allocated Subjects (Per Class)
  final Map<String, List<String>> allocatedSubjects = {
    "IF6KA": ["Java"], // already allocated
  };

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
              items: deptClasses.keys
                  .map((dept) => DropdownMenuItem(
                        value: dept,
                        child: Text(dept),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDept = value;
                  selectedClass = null;
                  selectedSubjects.clear();
                });
              },
            ),

            const SizedBox(height: 16),

            // 🔹 Class Dropdown (only after dept selected)
            if (selectedDept != null)
              DropdownButtonFormField<String>(
                value: selectedClass,
                decoration: const InputDecoration(
                  labelText: "Class",
                  border: OutlineInputBorder(),
                ),
                items: deptClasses[selectedDept]!
                    .map((cls) => DropdownMenuItem(
                          value: cls,
                          child: Text(cls),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedClass = value;
                    selectedSubjects.clear();
                  });
                },
              ),

            const SizedBox(height: 20),

            // 🔹 Subjects (only after class selected)
            if (selectedClass != null)
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: classSubjects[selectedClass]!.map((subject) {
                  bool isAllocated =
                      allocatedSubjects[selectedClass]?.contains(subject) ??
                          false;

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

                        await _service.approveRequest(widget.request);

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
