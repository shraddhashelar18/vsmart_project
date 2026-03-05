import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/session_manager.dart';

class TeacherNewService {
 static const String classBase =
      "http://192.168.0.103:8080/vsmart_backend/api/admin/";
  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}",
      };

  /// ===============================
  /// GET TEACHERS BY DEPARTMENT
  /// ===============================

  Future<List<Map<String, dynamic>>> getTeachers(String department) async {
    final response = await http.post(
      Uri.parse("$classBase/teachers/get_teachers.php"),
      headers: headers,
      body: jsonEncode({"department": department}),
    );

    final data = jsonDecode(response.body);

    if (data["status"]) {
      return List<Map<String, dynamic>>.from(data["teachers"]);
    }

    return [];
  }

  /// ===============================
  /// GET TEACHER DETAILS
  /// ===============================

  Future<Map<String, dynamic>?> getTeacherDetail(int id) async {
    final response = await http.post(
      Uri.parse("$classBase/teachers/get_teacher_detail.php"),
      headers: headers,
      body: jsonEncode({"id": id}),
    );

    final data = jsonDecode(response.body);

    if (data["status"]) {
      return data;
    }

    return null;
  }
Future<List<String>> getClasses(String department) async {
    final response = await http.post(
     Uri.parse("$classBase/classes/get_classes_by_departments.php"),
      headers: headers,
      body: jsonEncode({"department": department}),
    );

    final data = jsonDecode(response.body);

    if (data["status"]) {
      return List<String>.from(data["classes"]);
    }

    return [];
  }
  /// ===============================
  /// ADD TEACHER
  /// ===============================

  Future<bool> addTeacher({
    required String name,
    required String email,
    required String password,
    required String phone,
    required Map<String, List<String>> subjects,
  }) async {
    final response = await http.post(
      Uri.parse("$classBase/teachers/add_teacher.php"),
      headers: headers,
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "subjects": subjects
      }),
    );

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }

  /// ===============================
  /// UPDATE TEACHER
  /// ===============================

  Future<bool> updateTeacher({
    required int userId,
    required String name,
    required String phone,
    required Map<String, Map<String, List<String>>> subjects,
  }) async {
    final response = await http.post(
      Uri.parse("$classBase/teachers/update_teacher.php"),
      headers: headers,
      body: jsonEncode({
        "user_id": userId,
        "full_name": name,
        "mobile_no": phone,
        "subjects": subjects
      }),
    );

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }

  /// ===============================
  /// DELETE TEACHER
  /// ===============================

  Future<bool> deleteTeacher(int id) async {
    final response = await http.post(
      Uri.parse("$classBase/teachers/delete_teacher.php"),
      headers: headers,
      body: jsonEncode({"id": id}),
    );

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }
}
