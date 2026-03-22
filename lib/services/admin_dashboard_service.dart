import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class AdminDashboardService {
 static const String base = ApiConfig.baseUrl;

  Future<Map<String, dynamic>> getDashboardStats() async {
    print("TOKEN BEING SENT: ${SessionManager.token}");
final response = await http.get(
      Uri.parse("$base/admin/dashboard.php?token=${SessionManager.token}"),
      headers: {
        "x-api-key": "VSMART_API_2026",
      },
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RAW BODY: ${response.body}");

    return jsonDecode(response.body);
  }
}
