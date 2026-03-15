import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/api_config.dart';
import '../core/session_manager.dart';

class StudentResultsService {
  Future<Map<String, dynamic>> getSemesterDetails(
    int studentId,
    int semester,
  ) async {
    final response = await http.get(
      Uri.parse(
          "${ApiConfig.baseUrl}/student/get_semester_details.php?user_id=$studentId&semester=$semester"),
      headers: {"Authorization": "Bearer ${SessionManager.token}"},
    );

    print("SEMESTER DETAIL RESPONSE: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return Map<String, dynamic>.from(data["data"]);
    }

    return {};
  }
}
