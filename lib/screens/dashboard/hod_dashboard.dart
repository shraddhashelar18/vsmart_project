import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HodDashboard extends StatelessWidget {
  final String department;

  const HodDashboard({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF009846),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(today),
              Container(
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    _infoCard(
                      title: "Department",
                      value: department,
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle("Management"),

                    _actionGrid(),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔰 HEADER (SAME STYLE AS TEACHER / ADMIN)
  Widget _header(String today) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
      decoration: const BoxDecoration(
        color: Color(0xFF009846),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Vsmart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            today,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          const Text(
            "HOD Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ℹ️ INFO CARD
  Widget _infoCard({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 SECTION TITLE
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // 🧩 ACTION GRID (TEACHERS + STUDENTS)
  Widget _actionGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _actionCard(
            icon: Icons.person,
            label: "Manage Teachers",
          ),
          _actionCard(
            icon: Icons.school,
            label: "Manage Students",
          ),
        ],
      ),
    );
  }

  // 🟩 ACTION CARD
  Widget _actionCard({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 36,
            color: const Color(0xFF009846),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
