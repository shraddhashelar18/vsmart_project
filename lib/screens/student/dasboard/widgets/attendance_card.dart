import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../models/dashboard_model.dart';

class AttendanceCard extends StatelessWidget {
  final DashboardModel data;
  const AttendanceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF009846),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Attendance Overview",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const SizedBox(height: 20),
          CircularPercentIndicator(
            radius: 70,
            percent: data.attendancePercent / 100,
            lineWidth: 10,
            center: Text("${data.attendancePercent}%",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            progressColor: Colors.white,
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _box("Present", data.presentDays),
              _box("Absent", data.absentDays),
            ],
          )
        ],
      ),
    );
  }

  Widget _box(String title, int value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        Text("$value days",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
