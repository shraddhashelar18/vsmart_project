import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';

class HodPromoted extends StatelessWidget {
  final String department;

  const HodPromoted({Key? key, required this.department}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("Promoted Students ($department)"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 1,
        department: department,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _Entry(name: "Emma Johnson", from: "SEM 3", to: "SEM 4"),
            _Entry(name: "Liam Smith", from: "SEM 3", to: "SEM 4"),
            _Entry(name: "Olivia Brown", from: "SEM 2", to: "SEM 3"),
          ],
        ),
      ),
    );
  }
}

class _Entry extends StatelessWidget {
  final String name, from, to;
  const _Entry({required this.name, required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("$from → $to"),
      ),
    );
  }
}
