import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // --------------------------
  // Get device token
  // --------------------------
  Future<String?> getDeviceToken() async {
    return await _messaging.getToken();
  }

  // --------------------------
  // Request permission (iOS)
  // --------------------------
  Future<void> requestPermission() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  // --------------------------
  // Listen for foreground messages
  // --------------------------
  void onMessage(void Function(RemoteMessage message) callback) {
    FirebaseMessaging.onMessage.listen(callback);
  }

  // --------------------------
  // Listen for background/open messages
  // --------------------------
  void onMessageOpenedApp(void Function(RemoteMessage message) callback) {
    FirebaseMessaging.onMessageOpenedApp.listen(callback);
  }
}
