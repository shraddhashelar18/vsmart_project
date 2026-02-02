import 'package:flutter/material.dart';
import '../../models/dashboard_model.dart';

class CTStatusSection extends StatelessWidget {
  final DashboardModel data;
  const CTStatusSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Current Semester Performance",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (!data.ct1Declared && !data.ct2Declared)
            const Text("No assessments conducted yet",
                style: TextStyle(color: Colors.grey)),
          if (data.ct1Declared) _row("CT-1 Declared"),
          if (data.ct2Declared) _row("CT-2 Declared"),
        ],
      ),
    );
  }

  Widget _row(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          const Icon(Icons.check_circle, color: Color(0xFF009846)),
        ],
      ),
    );
  }
}
