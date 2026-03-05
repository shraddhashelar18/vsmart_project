import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/session_manager.dart';
class AdminDashboardService {
  static const String base = "http://192.168.0.103:8080/vsmart_backend/api";

  Future<Map<String, dynamic>> getDashboardStats() async {
    print("TOKEN BEING SENT: ${SessionManager.token}");

    final response = await http.get(
      Uri.parse("$base/admin/dashboard.php"),
      headers: {
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      },
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RAW BODY: ${response.body}");

    return jsonDecode(response.body);
  }
}
