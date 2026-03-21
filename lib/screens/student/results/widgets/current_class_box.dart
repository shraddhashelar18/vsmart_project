import 'package:flutter/material.dart';

class CurrentClassBox extends StatelessWidget {
  final String className;

  const CurrentClassBox({super.key, required this.className});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Current Class",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 4),
              Text(
                className,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Icon(Icons.school, color: Colors.white),
        ],
      ),
    );
  }
}
