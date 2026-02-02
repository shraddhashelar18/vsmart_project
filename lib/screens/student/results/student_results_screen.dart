
import 'package:flutter/material.dart';
import 'widgets/exam_card.dart';
import 'widgets/final_exam_card.dart';

class StudentResultsScreen extends StatelessWidget {
  const StudentResultsScreen({super.key});

  static const green = Color(0xFF009846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  ExamCard(
                    title: "Class Test 1 (CT1)",
                    grade: "A",
                    total: "89/100",
                    percent: "89%",
                    date: "January 15, 2026",
                  ),
                  SizedBox(height: 16),
                  ExamCard(
                    title: "Class Test 2 (CT2)",
                    grade: "A+",
                    total: "92/100",
                    percent: "92%",
                    date: "March 10, 2026",
                  ),
                  SizedBox(height: 16),
                  FinalExamCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      decoration: const BoxDecoration(
        color: green,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Results",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "View your exam performance and academic progress",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFF32B76C), green],
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Class",
                        style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 4),
                    Text("IF6KA",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
                Icon(Icons.school, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }
}
