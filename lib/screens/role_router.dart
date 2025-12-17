import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'student_dashboard.dart';
import 'teacher_dashboard.dart';
import 'parent_dashboard.dart';
import 'admin_dashboard.dart';

class RoleRouter extends StatelessWidget {
  const RoleRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").doc(uid).get(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snap.data!.data();
          if (data == null) {
            return const Center(child: Text("User record not found"));
          }

          String role = data["role"];

          // Redirect based on role
          if (role == "student") {
            return StudentDashboard(uid: uid);
          } else if (role == "teacher") {
            return TeacherDashboard(uid: uid);
          } else if (role == "parent") {
            return ParentDashboard(uid: uid);
          } else if (role == "admin") {
            return AdminDashboard(uid: uid);
          }

          return const Center(child: Text("Invalid role"));
        },
      ),
    );
  }
}
