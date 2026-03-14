import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../models/user_session.dart';
import '../screens/student/models/dashboard_model.dart';

class StudentDashboardService {
  Future<DashboardModel> getDashboard() async {
    final token = UserSession.token;

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/student/get_student_dashboard.php"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("DASHBOARD STATUS: ${response.statusCode}");
    print("DASHBOARD BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["status"] != true) {
      throw Exception(data["message"] ?? "Dashboard error");
    }

    return DashboardModel.fromJson(data);
  }
}
