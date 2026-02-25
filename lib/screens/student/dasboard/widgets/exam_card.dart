import 'package:flutter/material.dart';


class ExamCard extends StatelessWidget {
  final String title;
  final bool isDeclared; // 👈 ADD THIS

  const ExamCard({
    super.key,
    required this.title,
    required this.isDeclared, // 👈 ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- Title --------
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),

          // -------- Status text --------
          Text(
            isDeclared
                ? "Marks declared by subject teacher"
                : "Marks not declared yet",
            style: TextStyle(
              color: isDeclared ? Colors.green : Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),

          // -------- Status chip --------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Status"),
              Chip(
                label: Text(isDeclared ? "Declared" : "Pending"),
                backgroundColor:
                    isDeclared ? const Color(0xFFE6F4EA) : Colors.grey.shade200,
                labelStyle: TextStyle(
                  color: isDeclared ? const Color(0xFF009846) : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
        ),
      ],
    );
  }
}
