import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final userDoc = await _firestore.collection("users").doc(uid).get();
      return userDoc.data();
    } catch (e) {
      print("Error loading user data: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getStudentDashboard(String uid) async {
    try {
      final doc = await _firestore.collection("students").doc(uid).get();
      return doc.data();
    } catch (e) {
      print("Dashboard fetch error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getParentDashboard(String uid) async {
    try {
      final doc = await _firestore.collection("parents").doc(uid).get();
      return doc.data();
    } catch (e) {
      print("Parent fetch error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTeacherDashboard(String uid) async {
    try {
      final doc = await _firestore.collection("teachers").doc(uid).get();
      return doc.data();
    } catch (e) {
      print("Teacher fetch error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getAdminDashboard() async {
    try {
      final doc = await _firestore.collection("admin").doc("dashboard").get();
      return doc.data();
    } catch (e) {
      print("Admin fetch error: $e");
      return null;
    }
  }
}
