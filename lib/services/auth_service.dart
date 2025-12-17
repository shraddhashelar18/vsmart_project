import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Login using Firestore dummy users collection
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return snapshot.docs.first.data();
    } catch (e) {
      print("LOGIN ERROR: $e");
      return null;
    }
  }
}
