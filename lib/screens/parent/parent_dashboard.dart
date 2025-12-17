import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/info_card.dart';
import '../../widgets/section_title.dart';
import '../../services/firestore_service.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  Map<String, dynamic>? childData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadChildData();
  }

  Future<void> loadChildData() async {
    final parent = Provider.of<UserProvider>(context, listen: false).userData;

    if (parent == null || parent["childId"] == null) {
      setState(() => loading = false);
      return;
    }

    final data = await FirestoreService().getUserData(parent["childId"]);

    setState(() {
      childData = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      appBar: AppBar(
        title: const Text(
          "Parent Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : childData == null
              ? const Center(
                  child: Text(
                    "No child data found!",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ----------------------------------------
                      SectionTitle(title: "Child Information"),
                      InfoCard(
                        title: childData!["name"] ?? "Unknown",
                        subtitle: "Class: ${childData!["class"] ?? '--'}",
                        icon: Icons.person,
                        color: Colors.blueAccent,
                      ),

                      const SizedBox(height: 16),

                      // ----------------------------------------
                      SectionTitle(title: "Attendance"),
                      InfoCard(
                        title:
                            "${childData!["attendancePercent"]?.toString() ?? '0'}%",
                        subtitle: "Overall Attendance",
                        icon: Icons.calendar_month,
                        color: Colors.green,
                      ),

                      const SizedBox(height: 16),

                      // ----------------------------------------
                      SectionTitle(title: "Marks"),

                      InfoCard(
                        title:
                            "CT1: ${childData!["marks"]?["ct1"] ?? '--'}     "
                            "CT2: ${childData!["marks"]?["ct2"] ?? '--'}",
                        subtitle:
                            "Semester: ${childData!["marks"]?["semester"] ?? '--'}",
                        icon: Icons.bar_chart,
                        color: Colors.orange,
                      ),

                      const SizedBox(height: 16),

                      // ----------------------------------------
                      SectionTitle(title: "Teacher Suggestions"),
                      InfoCard(
                        title:
                            childData!["suggestion"] ?? "No suggestions yet.",
                        subtitle: "From Teachers",
                        icon: Icons.message,
                        color: Colors.purple,
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }
}
