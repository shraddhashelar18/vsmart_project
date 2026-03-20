import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class TeacherDashboardService {
  static const String base = "${ApiConfig.baseUrl}/teacher";
  Future<List<String>> getAllocatedClasses(int teacherId) async {
    final response = await http.get(
     Uri.parse("$base/get_classes.php?token=${SessionManager.token}"),
      headers: {
              "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      return [];
    }
    final data = jsonDecode(response.body);

    if (data["status"]) {
      return List<String>.from(data["classes"]);
    }

    return [];
  }

  Future<List<String>> getSubjects(int teacherId, String className) async {
    final response = await http.get(
      Uri.parse("$base/get_subjects.php?class=$className&token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    final data = jsonDecode(response.body);

    if (data["status"]) {
      return List<String>.from(data["subjects"]);
    }

    return [];
  }
}
