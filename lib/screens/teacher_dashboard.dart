import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherDashboard extends StatelessWidget {
  final String uid;
  const TeacherDashboard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("teachers")
            .where("user_id", isEqualTo: uid)
            .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());

          var t = snap.data!.docs.first.data();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text("Welcome Teacher",
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _btn("Take Attendance"),
              _btn("Enter Marks"),
              _btn("Analytics"),
            ],
          );
        },
      ),
    );
  }

  Widget _btn(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: Colors.deepPurple),
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
