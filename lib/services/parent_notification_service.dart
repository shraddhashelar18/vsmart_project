import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class ParentNotificationService {
  static Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final response = await http.get(
      Uri.parse(
          "${ApiConfig.baseUrl}/parent/get_notifications.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["data"]);
    }

    return [];
  }
}
