import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --------------------------
  // Get notifications for user
  // --------------------------
  Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    final snapshot = await _db
        .collection('notifications')
        .doc(userId)
        .collection(
          'user_notifications',
        ) // subcollection for multiple notifications
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // --------------------------
  // Add notification
  // --------------------------
  Future<void> addNotification(String userId, Map<String, dynamic> data) async {
    await _db
        .collection('notifications')
        .doc(userId)
        .collection('user_notifications')
        .add({
          ...data,
          'createdAt': FieldValue.serverTimestamp(),
          'read': false,
        });
  }

  // --------------------------
  // Mark notification as read
  // --------------------------
  Future<void> markNotificationRead(String userId, String notifId) async {
    await _db
        .collection('notifications')
        .doc(userId)
        .collection('user_notifications')
        .doc(notifId)
        .update({'read': true, 'updatedAt': FieldValue.serverTimestamp()});
  }
}
