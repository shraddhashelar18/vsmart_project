import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';
import '../models/department_summary.dart';

class DepartmentService {
  static const String base = ApiConfig.baseUrl;
  Future<DepartmentSummary> getSummary(String department) async {
    final url = Uri.parse(
        "$base/hod/get_hod_dashboard.php?token=${SessionManager.token}");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"department": department}),
    );
    print("HOD DASHBOARD RESPONSE: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception("Failed to load dashboard");
    }

    final data = jsonDecode(response.body);

    return DepartmentSummary(
      totalStudents: data["totalStudents"] ?? 0,
      totalTeachers: data["totalTeachers"] ?? 0,
      promoted: data["promoted"] ?? 0,
      detained: data["detained"] ?? 0,
      promotedWithBacklog: data["promotedWithBacklog"] ?? 0,
    );
  }
}
