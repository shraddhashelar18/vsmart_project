import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class TeacherNotificationService {
  static const String base = ApiConfig.baseUrl;

  Future<bool> sendNotification({
    required String className,
    required String subject,
    required String message,
    required String notifyType,
    required List<String> selectedRecipients,
  }) async {
    final response = await http.post(
      Uri.parse("$base/teacher/send_notification.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({
        "class": className,
        "subject": subject,
        "message": message,
        "send_to": notifyType,
        "students": selectedRecipients
      }),
    );

    print(response.body);

    final data = jsonDecode(response.body);

    return data["status"] ?? false;
  }

  /// GET STUDENTS (GET API)
  Future<List<Map<String, dynamic>>> getStudentsByClass(
      String className) async {
    final response = await http.get(
      Uri.parse("$base/teacher/get_students.php?class=$className"),
      headers: {"Authorization": "Bearer ${SessionManager.token}"},
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["students"]);
    }

    return [];
  }

  /// GET PARENTS (POST API)
  Future<List<Map<String, dynamic>>> getParentsByClass(String className) async {
    final response = await http.post(
      Uri.parse("$base/teacher/get_parents.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"class": className}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["parents"]);
    }

    return [];
  }
}
