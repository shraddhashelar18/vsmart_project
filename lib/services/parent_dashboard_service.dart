import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';
import '../models/user_session.dart';

class ParentDashboardService {
  static const String base = "${ApiConfig.baseUrl}/parent";

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      };

  Future<Map<String, dynamic>?> fetchDashboard() async {
    final userId = UserSession.currentUser!.user_id;

    final response = await http.post(
      Uri.parse("$base/get_parent_dashboard.php"),
      headers: headers,
      body: jsonEncode({"user_id": userId}),
    );

    print("PARENT DASHBOARD RESPONSE: ${response.body}");

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
