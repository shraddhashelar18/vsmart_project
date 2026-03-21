import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class ReportService {
  static const String base = "${ApiConfig.baseUrl}/parent";

  Future<Map<String, dynamic>?> getReportByEnrollment(String enrollment) async {
    final response = await http.post(
      Uri.parse("$base/get_grades.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"enrollment": enrollment}),
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data;
    }

    return null;
  }
}
