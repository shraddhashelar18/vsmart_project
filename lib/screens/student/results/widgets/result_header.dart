import 'package:flutter/material.dart';

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      decoration: const BoxDecoration(
        color: Color(0xFF009846),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.white),
              SizedBox(width: 10),
              Text("Results",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "View your exam performance and academic progress",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
