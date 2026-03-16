import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class ReportService {
  static const String base = "${ApiConfig.baseUrl}/parent";

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      };

  Future<Map<String, dynamic>?> getReportByEnrollment(String enrollment) async {
    final response = await http.post(
      Uri.parse("$base/get_grades.php"),
      headers: headers,
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
