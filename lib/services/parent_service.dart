import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';
import 'student_new_service.dart';

class ParentService {
  static const String base = "${ApiConfig.baseUrl}/admin/parents";

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      };

  final StudentNewService _studentService = StudentNewService();

  /* ===============================
     GET PARENTS BY CLASS
  =============================== */

  Future<List<Map<String, dynamic>>> getParentsByClass(String className) async {
    final response = await http.post(
    Uri.parse("$base/get_parents_by_class.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"className": className}),
    );

    print("PARENTS RESPONSE: ${response.body}");

    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body);

    if (data["status"]) {
      return List<Map<String, dynamic>>.from(data["parents"]);
    }

    return [];
  }

  /* ===============================
     ADD PARENT
  =============================== */

  Future<bool> addParent({
    required String name,
    required String email,
    required String phone,
    required List<String> children,
  }) async {
    final response = await http.post(
  Uri.parse("$base/add_parent.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode(
          {"name": name, "email": email, "phone": phone, "children": children}),
    );

    print("ADD PARENT RESPONSE: ${response.body}");

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }

  /* ===============================
     UPDATE PARENT
  =============================== */

  Future<bool> updateParent({
    required String name,
    required String phone,
      required String oldPhone,
  }) async {
    final response = await http.post(
    Uri.parse("$base/update_parent.php?token=${SessionManager.token}"),
      headers: headers,
     body: jsonEncode({"name": name, "phone": phone, "oldPhone": oldPhone}),
    );

    print("UPDATE PARENT RESPONSE: ${response.body}");

    if (response.statusCode != 200) return false;

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }

  /* ===============================
     DELETE PARENT
  =============================== */

  Future<bool> deleteParent(String phone) async {
    final response = await http.post(
     Uri.parse("$base/delete_parent.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"phone": phone}),
    );

    final data = jsonDecode(response.body);
    return data["status"] ?? false;
  }

  /* ===============================
     GET PARENT BY EMAIL
  =============================== */

  Future<Map<String, dynamic>?> getParentByEmail(String email) async {
    final response = await http.post(
      Uri.parse("$base/get_parent_by_email.php"),
      headers: headers,
      body: jsonEncode({"email": email}),
    );

    print("PARENT BY EMAIL RESPONSE: ${response.body}");

    if (response.statusCode != 200 || response.body.isEmpty) return null;

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data["parent"];
    }

    return null;
  }

  /* ===============================
     GET PARENT DETAIL
  =============================== */

  Future<Map<String, dynamic>?> getParent(String phone) async {
    final response = await http.post(
    Uri.parse("$base/get_parent_detail.php?token=${SessionManager.token}"),
      headers: headers,
      body: jsonEncode({"phone": phone}),
    );

    print("PARENT DETAIL RESPONSE: ${response.body}");

    if (response.statusCode != 200 || response.body.isEmpty) return null;

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data["parent"];
    }

    return null;
  }

  /* ===============================
     GET STUDENT
  =============================== */

  Future<Map<String, dynamic>?> getStudent(String enrollment) {
    return _studentService.getStudentByEnrollment(enrollment);
  }
}
