import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class TeacherReportService {
  /// GET STUDENTS OF CLASS
  Future<List<Map<String, dynamic>>> getStudentsByClass(
      String className) async {
    final response = await http.post(
     Uri.parse("${ApiConfig.baseUrl}/teacher/get_students.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"class": className}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["students"]);
    }

    return [];
  }

  /// GET STUDENT REPORT (marks)
  Future<Map<String, dynamic>?> getStudentReport(String studentId) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/teacher/get_reports.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"user_id": studentId}),
    );
    print("REPORT RESPONSE: ${response.body}");

    if (response.body.isEmpty) {
      print("API returned empty body");
      return null;
    }

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data;
    }

    return null;
  }

  Future<Map<String, dynamic>?> getPreviousSemesters(String studentId) async {
    final response = await http.get(
      Uri.parse(
          "${ApiConfig.baseUrl}/teacher/get_previous_semesters.php?user_id=$studentId&token=${SessionManager.token}"),
    );

    print("PREVIOUS SEM RESPONSE: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["status"] == "success") {
      return Map<String, dynamic>.from(data["data"]);
    }

    return null;
  }
}
