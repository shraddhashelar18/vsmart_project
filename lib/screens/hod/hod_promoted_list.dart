import 'package:flutter/material.dart';
import 'hod_bottom_nav.dart';

class HodPromoted extends StatelessWidget {
  final String department;

  const HodPromoted({Key? key, required this.department}) : super(key: key);

  static const green = Color(0xFF009846);

  // ---- Temporary Class-wise Mock Data ----
  final Map<String, List<Map<String, String>>> promotedData = const {
    "IF6K-A": [
      {"name": "Emma Johnson", "from": "SEM 3", "to": "SEM 4"},
      {"name": "Liam Smith", "from": "SEM 3", "to": "SEM 4"},
    ],
    "IF5K-B": [
      {"name": "Olivia Brown", "from": "SEM 2", "to": "SEM 3"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text("Promoted Students ($department)"),
      ),
      bottomNavigationBar: HodBottomNav(
        currentIndex: 0,
        department: department,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: promotedData.entries.map((entry) {
            final className = entry.key;
            final students = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  className,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 8),
                ...students.map((s) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(s["name"]!),
                        subtitle: Text("${s["from"]} → ${s["to"]}"),
                      ),
                    )),
                const SizedBox(height: 20),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
