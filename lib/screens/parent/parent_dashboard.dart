import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ParentDashboardScreen extends StatelessWidget {
  final String parentId;
  const ParentDashboardScreen({super.key, required this.parentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parent Dashboard")),
      body: const Center(
        child: Text("List of children and their attendance will appear here"),
      ),
    );
  }
}
