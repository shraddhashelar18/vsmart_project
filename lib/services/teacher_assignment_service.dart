import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class TeacherAssignmentService {
  Map<String, String> get headers => {
        "Authorization": "Bearer ${SessionManager.token}",
        "x-api-key": "VSMART_API_2026"
      };

  /* -------------------------
  GET CLASSES BY DEPARTMENT
  ------------------------- */

  Future<List<String>> getClasses(String dept) async {
    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/admin/reports/teacher_assign.php?action=get_classes&department=$dept",
      ),
      headers: headers,
    );

    final data = jsonDecode(res.body);

    if (data["status"] == true) {
      return List<String>.from(data["classes"]);
    }

    return [];
  }

  /* -------------------------
  GET SUBJECTS BY CLASS
  ------------------------- */

  Future<List<String>> getSubjects(String className) async {
    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/admin/reports/teacher_assign.php?action=get_subjects&class=$className",
      ),
      headers: headers,
    );

    final data = jsonDecode(res.body);

    if (data["status"] == true) {
      return List<String>.from(data["subjects"]);
    }

    return [];
  }

  /* -------------------------
  GET ALLOCATED SUBJECTS
  ------------------------- */

  Future<List<String>> getAllocated(String className) async {
    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/admin/reports/teacher_assign.php?action=get_allocated&class=$className",
      ),
      headers: headers,
    );

    final data = jsonDecode(res.body);

    if (data["status"] == true) {
      return List<String>.from(data["allocated_subjects"]);
    }

    return [];
  }

  /* -------------------------
  ASSIGN TEACHER
  ------------------------- */

  Future<bool> assignTeacher(
    int userId,
    String department,
    String className,
    List<String> subjects,
  ) async {
    final res = await http.post(
      Uri.parse(
        "${ApiConfig.baseUrl}/admin/reports/teacher_assign.php?action=assign_teacher",
      ),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}",
        "x-api-key": "VSMART_API_2026"
      },
      body: jsonEncode({
        "user_id": userId,
        "department": department,
        "class": className,
        "subjects": subjects
      }),
    );

    final data = jsonDecode(res.body);

    return data["status"] == true;
  }
}
