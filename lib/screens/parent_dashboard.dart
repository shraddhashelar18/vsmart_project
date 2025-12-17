import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentDashboard extends StatelessWidget {
  final String uid; // Parent Auth UID
  const ParentDashboard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("parent")
            .where("user_id", isEqualTo: uid)
            .snapshots(),
        builder: (context, parentSnap) {
          if (!parentSnap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (parentSnap.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Parent record not found.\nPlease check database.",
                style: TextStyle(fontSize: 18, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          var parent = parentSnap.data!.docs.first.data();
          String childId = parent["child_id"];

          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("student")
                .where("student_id", isEqualTo: childId)
                .snapshots(),
            builder: (context, childSnap) {
              if (!childSnap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (childSnap.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "Child record not found.",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              }

              var child = childSnap.data!.docs.first.data();

              return ListView(
                children: [
                  _header("Hi, ${parent["name"]}", "Child: ${child["name"]}"),

                  const SizedBox(height: 20),
                  _sectionTitle("Attendance"),
                  _attendanceCard(child["attendance"] ?? 0),

                  const SizedBox(height: 20),
                  _sectionTitle("Marks"),

                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("marks")
                        .where("student_id", isEqualTo: child["student_id"])
                        .get(),
                    builder: (context, markSnap) {
                      if (!markSnap.hasData) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (markSnap.data!.docs.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("No marks available."),
                        );
                      }

                      return Column(
                        children: markSnap.data!.docs.map((m) {
                          return _marksCard(
                            m["subject_id"],
                            m["exam_type"],
                            m["marks"],
                            m["max_marks"],
                          );
                        }).toList(),
                      );
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  // ---------------- UI WIDGETS ----------------

  Widget _header(String parent, String child) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pinkAccent, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(parent,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(child, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _attendanceCard(int value) {
    return _glassCard(
      child: ListTile(
        leading: const Icon(Icons.percent, color: Colors.purple, size: 30),
        title: const Text("Overall Attendance"),
        subtitle: Text("$value%"),
      ),
    );
  }

  Widget _marksCard(
      String subject, String type, int marks, int maxMarks) {
    return _glassCard(
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.deepPurple),
        title: Text(subject.toUpperCase()),
        subtitle: Text("$type: $marks / $maxMarks"),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        shadowColor: Colors.purple.withOpacity(0.3),
        child: Padding(padding: const EdgeInsets.all(8), child: child),
      ),
    );
  }
}
