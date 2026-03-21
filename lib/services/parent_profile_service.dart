import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class ParentProfileService {
  static const String base = "${ApiConfig.baseUrl}/parent";

  Future<Map<String, dynamic>?> getStudentProfile(String enrollment) async {
    final response = await http.post(
      Uri.parse("$base/get_student_profile.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "enrollment": enrollment,
      }),
    );

    print("PARENT PROFILE RESPONSE: ${response.body}");

    if (response.statusCode != 200 || response.body.isEmpty) {
      return null;
    }

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data;
    }

    return null;
  }
}
