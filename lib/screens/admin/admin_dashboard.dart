import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../theme/app_colors.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: const Text("Admin Dashboard"),
      ),
      body: FutureBuilder(
        future: loadAdminStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as Map<String, int>;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildStatCard("Total Students", data["students"]!, Colors.blue),
                const SizedBox(height: 12),
                buildStatCard(
                    "Total Teachers", data["teachers"]!, Colors.green),
                const SizedBox(height: 12),
                buildStatCard("Total Parents", data["parents"]!, Colors.orange),
                const SizedBox(height: 12),
                buildStatCard("Total Classes", data["classes"]!, Colors.purple),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildStatCard(String title, int value, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// READ ALL COLLECTION COUNTS FROM FIRESTORE
  Future<Map<String, int>> loadAdminStats() async {
    final students =
        await FirebaseFirestore.instance.collection("student").get();
    final teachers =
        await FirebaseFirestore.instance.collection("teacher").get();
    final parents = await FirebaseFirestore.instance.collection("parent").get();
    final classes =
        await FirebaseFirestore.instance.collection("classes").get();

    return {
      "students": students.size,
      "teachers": teachers.size,
      "parents": parents.size,
      "classes": classes.size,
    };
  }
}
