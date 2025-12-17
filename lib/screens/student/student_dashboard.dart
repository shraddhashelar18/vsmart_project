import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  final String uid;
  const StudentDashboard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("student")
            .where("user_id", isEqualTo: uid)
            .snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snap.hasData || snap.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No student data found.",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }

          var student = snap.data!.docs.first.data();

          return ListView(
            children: [
              _header(student["name"]),
              const SizedBox(height: 20),

              // ---------------- ATTENDANCE SECTION ----------------
              _sectionTitle("Attendance"),
              _attendanceCard(student["overall_attendance"] ?? 0),
              const SizedBox(height: 20),

              // ---------------- MARKS SECTION ----------------
              _sectionTitle("Marks"),
              _marksList(student["student_id"]),
            ],
          );
        },
      ),
    );
  }

  // ---------------- HEADER UI ----------------
  Widget _header(String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius:
            BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome, $name 👋",
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Student Dashboard",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ---------------- SECTION TITLE ----------------
  Widget _sectionTitle(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Text(
        t,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // ---------------- ATTENDANCE CARD ----------------
  Widget _attendanceCard(int attendance) {
    return _glassCard(
      child: ListTile(
        leading: const Icon(Icons.bar_chart_rounded, size: 35, color: Colors.indigo),
        title: const Text("Overall Attendance"),
        subtitle: Text(
          "$attendance%",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ---------------- MARKS LIST ----------------
  Widget _marksList(String studentId) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("marks")
          .where("student_id", isEqualTo: studentId)
          .get(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var docs = snap.data!.docs;

        if (docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "No marks added yet.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return Column(
          children: docs.map(
            (m) {
              return _marksCard(
                m["subject_id"],
                m["exam_type"],
                m["marks"],
                m["max_marks"],
              );
            },
          ).toList(),
        );
      },
    );
  }

  // ---------------- MARKS CARD ----------------
  Widget _marksCard(String subject, String type, int marks, int max) {
    return _glassCard(
      child: ListTile(
        leading: const Icon(Icons.menu_book_rounded, size: 35, color: Colors.deepPurple),
        title: Text(subject),
        subtitle: Text("$type: $marks / $max"),
      ),
    );
  }

  // ---------------- GLASS CARD UI ----------------
  Widget _glassCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Card(
        elevation: 6,
        shadowColor: Colors.deepPurple.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: child,
        ),
      ),
    );
  }
}
