import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';

class HodDetained extends StatelessWidget {
  const HodDetained({Key? key}) : super(key: key);

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text("Detained Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _Entry(name: "Noah Davis", sem: "SEM 4"),
            _Entry(name: "Sophia Wilson", sem: "SEM 3"),
          ],
        ),
      ),
    );
  }
}

class _Entry extends StatelessWidget {
  final String name, sem;
  const _Entry({required this.name, required this.sem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("Detained in $sem"),
      ),
    );
  }
}
