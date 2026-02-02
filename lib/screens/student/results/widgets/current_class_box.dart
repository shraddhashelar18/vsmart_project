import 'package:flutter/material.dart';

class CurrentClassBox extends StatelessWidget {
  const CurrentClassBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3ECF8E), Color(0xFF009846)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current Class", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 4),
              Text("IF6KA",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Icon(Icons.school, color: Colors.white),
        ],
      ),
    );
  }
}
