import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/api_config.dart';
import '../core/session_manager.dart';
import '../screens/student/models/notification_model.dart';

class NotificationService {

  static Future<List<NotificationModel>> fetchNotifications() async {

    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/student/get_notifications.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
    );

    print("NOTIFICATION STATUS: ${response.statusCode}");
    print("NOTIFICATION BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["status"] != true) {
      return [];
    }

    final List list = data["data"];

    return list.map((e) => NotificationModel.fromJson(e)).toList();
  }
}