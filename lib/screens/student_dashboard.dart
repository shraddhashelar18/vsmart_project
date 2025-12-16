import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDashboard extends StatelessWidget {
  final String uid;
  const StudentDashboard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("students")
            .where("user_id", isEqualTo: uid)
            .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var student = snap.data!.docs.first.data();

          return ListView(
            children: [
              _header(student["name"]),
              const SizedBox(height: 20),
              _sectionTitle("Attendance"),
              _attendanceCard(student["attendance"]),
              const SizedBox(height: 20),
              _sectionTitle("Marks"),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("marks")
                    .where("student_id", isEqualTo: student["student_id"])
                    .get(),
                builder: (context, snap2) {
                  if (!snap2.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var docs = snap2.data!.docs;

                  return Column(
                    children: docs.map((m) {
                      return _marksCard(m["subject_id"], m["exam_type"],
                          m["marks"], m["max_marks"]);
                    }).toList(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _header(String name) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome, $name",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text("Student Dashboard",
              style: TextStyle(color: Colors.white70))
        ],
      ),
    );
  }

  Widget _sectionTitle(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(t,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87)),
    );
  }

  Widget _attendanceCard(int attendance) {
    return _glassCard(
      child: ListTile(
        leading: const Icon(Icons.percent, color: Colors.indigo, size: 30),
        title: const Text("Overall Attendance"),
        subtitle: Text("$attendance%"),
      ),
    );
  }

  Widget _marksCard(String subject, String type, int marks, int max) {
    return _glassCard(
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.deepPurple),
        title: Text(subject.toUpperCase()),
        subtitle: Text("$type: $marks / $max"),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        shadowColor: Colors.indigo.withOpacity(0.3),
        child: Padding(padding: const EdgeInsets.all(8), child: child),
      ),
    );
  }
}
