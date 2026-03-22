import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class TeacherNewService {
  static const String base = "${ApiConfig.baseUrl}/admin";
  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
      };

  /// ===============================
  /// GET TEACHERS BY DEPARTMENT
  /// ===============================

  Future<List<Map<String, dynamic>>> getTeachers(String department) async {
    final response = await http.post(
     Uri.parse(
          "$base/teachers/get_teachers.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"department": department}),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RAW RESPONSE: ${response.body}");

    if (response.statusCode != 200 || response.body.isEmpty) {
      print("API error while fetching teachers");
      return [];
    }

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["teachers"]);
    }

    return [];
  }

  /// ===============================
  /// GET TEACHER DETAILS
  /// ===============================

Future<Map<String, dynamic>?> getTeacherDetail(int id) async {
    final response = await http.post(
      Uri.parse(
          "$base/teachers/get_teacher_detail.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"id": id}),
    );

    print("TEACHER DETAIL STATUS: ${response.statusCode}");
    print("TEACHER DETAIL BODY: ${response.body}");

    if (response.statusCode != 200 || response.body.isEmpty) {
      print("Teacher detail API error");
      return null;
    }

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return Map<String, dynamic>.from(data);
    }

    return null;
  }

  Future<List<String>> getClasses(String department) async {
    final response = await http.post(
   Uri.parse(
          "$base/classes/get_classes_by_department.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"department": department}),
    );

    print("CLASS API RESPONSE: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<String>.from(data["classes"].map((c) => c["class_name"]));
    }

    return [];
  }

 Future<List<Map<String, dynamic>>> getSubjects(String className) async {
    final response = await http.post(
      Uri.parse(
          "$base/subject/get_subjects_by_class.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"class_name": className}),
    );

    final data = jsonDecode(response.body);

    if (data["status"]) {
      final List subjects = data["subjects"];
      return subjects.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    return [];
  }
  /// ===============================
  /// ADD TEACHER
  /// ===============================

  Future<bool> addTeacher({
    required String name,
    required String email,
      required String employeeId,
    required String password,
    required String phone,
    required Map<String, Map<String, List<String>>> subjects,
  }) async {
    final response = await http.post(
     Uri.parse("$base/teachers/add_teacher.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({
        "employee_id": employeeId,
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
    Uri.parse(
          "$base/teachers/update_teacher.php?token=${SessionManager.token}"),
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
   Uri.parse(
          "$base/teachers/delete_teacher.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"id": id}),
    );

    print("DELETE STATUS: ${response.statusCode}");
    print("DELETE RESPONSE: ${response.body}");

    if (response.statusCode != 200 || response.body.isEmpty) {
      return false;
    }

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }
}
