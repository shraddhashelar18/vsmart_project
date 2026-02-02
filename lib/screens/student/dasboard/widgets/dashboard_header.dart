import 'package:flutter/material.dart';
import '../../models/dashboard_model.dart';

class DashboardHeader extends StatelessWidget {
  final DashboardModel data;

  const DashboardHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
      decoration: const BoxDecoration(
        color: Color(0xFF009846),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.studentName,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Text(data.rollNo, style: const TextStyle(color: Colors.white70)),
              Text("${data.className} - Sem ${data.semester}",
                  style: const TextStyle(color: Colors.white70)),
            ],
          )
        ],
      ),
    );
  }
}
