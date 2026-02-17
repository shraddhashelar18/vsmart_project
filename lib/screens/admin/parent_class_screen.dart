import 'package:flutter/material.dart';
import 'package:vsmart_app/mock/mock_academics.dart';
import 'manage_parents.dart';

class ParentClassScreen extends StatelessWidget {
  final String department;
 ParentClassScreen({Key? key, required this.department})
      : super(key: key);

  static const green = Color(0xFF009846);

  final allClasses = [
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

   @override
  Widget build(BuildContext context) {
    final classes = allClasses.where((c) {
      if (!c.startsWith(department)) return false;

      final sem = int.parse(c[2]); // IF2KA → 2

      if (activeSemType == "EVEN") {
        return sem % 2 == 0;
      } else {
        return sem % 2 != 0;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title:  Text("$department Classes"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (_, i) {
          final cls = classes[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(cls),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ManageParents(className: cls),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
