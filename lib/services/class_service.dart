import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class ClassService {
  static const String base = "${ApiConfig.baseUrl}/admin/classes";

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}",
      };

  /// GET CLASSES BY DEPARTMENT
  Future<List<Map<String, dynamic>>> getClassesByDepartment(
      String department) async {
    final response = await http.post(
      Uri.parse("$base/get_classes_by_department.php"),
      headers: headers,
      body: jsonEncode({"department": department}),
    );

    if (response.statusCode != 200 || response.body.isEmpty) {
      return [];
    }

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["classes"]);
    }

    return [];
  }

  /// ADD CLASS
  Future<bool> addClass({
    required String className,
    required String department,
    required int teacherId,
  }) async {
    final response = await http.post(
      Uri.parse("$base/add_class.php"),
      headers: headers,
      body: jsonEncode({
        "class_name": className,
        "department": department,
        "class_teacher": teacherId
      }),
    );

    final data = jsonDecode(response.body);

    return data["status"] ?? false;
  }

  /// UPDATE CLASS TEACHER
 
Future<bool> updateClassTeacher({
    required String className,
    required int teacherId,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/classes/update_class_teacher.php"),
      headers: headers,
      body: jsonEncode({"class_name": className, "class_teacher": teacherId}),
    );

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }
  Future<bool> updateClass({
    required String className,
    required int teacherId,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/classes/update_class.php"),
      headers: headers,
      body: jsonEncode({"class_name": className, "class_teacher": teacherId}),
    );

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }
}
