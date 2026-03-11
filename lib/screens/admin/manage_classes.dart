import 'package:flutter/material.dart';
import 'admin_bottom_nav.dart';
import 'add_class.dart';
import '../../services/class_service.dart';

class ManageClasses extends StatelessWidget {
final ClassService _classService = ClassService();
final String department;


ManageClasses({Key? key, required this.department}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
backgroundColor: const Color(0xFF009846),
elevation: 0,
leading: IconButton(
icon: const Icon(Icons.arrow_back),
onPressed: () => Navigator.pop(context),
),
title: Text("Manage Classes - $department"),
bottom: const PreferredSize(
preferredSize: Size.fromHeight(20),
child: Padding(
padding: EdgeInsets.only(bottom: 8, left: 16),
child: Align(
alignment: Alignment.centerLeft,
child: Text(
"View, add and organize classes",
style: TextStyle(color: Colors.white70, fontSize: 13),
),
),
),
),
),


  bottomNavigationBar: const AdminBottomNav(currentIndex: 0),

  floatingActionButton: FloatingActionButton(
    backgroundColor: const Color(0xFF009846),
    child: const Icon(Icons.add),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddClass(department: department),
        ),
      );
    },
  ),

  body: FutureBuilder<List<Map<String, dynamic>>>(
    future: _classService.getClassesByDepartment(department),
    builder: (context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No classes found"));
      }

      final classes = snapshot.data!;

      return ListView(
        padding: const EdgeInsets.all(16),
        children: classes.map((c) {
         return ClassCard(
                className: c["class_name"] ?? "",
                dept: department,
                teacher: c["teacher_name"] ?? "",
                teacherId: c["teacher_id"],
                assignedClass: c["class_name"],
              );
        }).toList(),
      );
    },
  ),
);


}
}

class ClassCard extends StatelessWidget {
final String className;
final String dept;
final String teacher;
final String assignedClass;

  final int? teacherId;
const ClassCard({
    super.key,
    required this.className,
    required this.dept,
    required this.teacher,
    required this.teacherId,
    required this.assignedClass,
  });

@override
Widget build(BuildContext context) {
return Card(
margin: const EdgeInsets.only(bottom: 12),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
child: ListTile(
title: Text(
className,
style: const TextStyle(fontWeight: FontWeight.bold),
),
subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Department: $dept"),
Text("Class Teacher: $teacher"),
],
),
trailing: Row(
mainAxisSize: MainAxisSize.min,
children: [


        /// EDIT
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
              builder: (_) => AddClass(
                      className: className,
                      department: dept,
                      teacherId: teacherId,
                      assignedClass: assignedClass,
                    ),
              ),
            );
          },
        ),

        /// DELETE
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _confirmDelete(context, className),
        ),
      ],
    ),
  ),
);


}
}

/// DELETE CONFIRM POPUP
void _confirmDelete(BuildContext context, String className) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Delete"),
      content: Text("Delete class $className?"),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$className deleted")),
            );
          },
        ),
      ],
    ),
  );
}
