import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class ResultService {
  /* ===============================
     GET RESULT SETTINGS
  =============================== */

  static Future<Map<String, dynamic>> getSettings() async {
    final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/admin/result_control.php"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SessionManager.token}"
        },
        body: jsonEncode({"action": "get_settings"}));

    return jsonDecode(response.body);
  }

  /* ===============================
     UPDATE SETTINGS
  =============================== */

  static Future updateSettings(bool upload, bool publish) async {
    await http.post(Uri.parse("${ApiConfig.baseUrl}/admin/result_control.php"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SessionManager.token}"
        },
        body: jsonEncode({
          "action": "update_settings",
          "allow_upload": upload ? 1 : 0,
          "publish_result": publish ? 1 : 0
        }));
  }

  /* ===============================
     ENABLE MARKSHEET UPLOAD
  =============================== */

  static Future enableUpload() async {
    await http.post(
        Uri.parse("${ApiConfig.baseUrl}/admin/open_marksheet_upload.php"),
        headers: {"Authorization": "Bearer ${SessionManager.token}"});
  }

  /* ===============================
     PUBLISH FINAL RESULT
  =============================== */

  static Future publishFinalResult() async {
    await http.post(Uri.parse("${ApiConfig.baseUrl}/admin/publish_final_results.php"),
        headers: {"Authorization": "Bearer ${SessionManager.token}"});
  }

  /* ===============================
     GET UPLOAD PROGRESS
  =============================== */

  static Future<List<dynamic>> getUploadProgress() async {
    final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/admin/result_control.php"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SessionManager.token}"
        },
        body: jsonEncode({"action": "upload_progress"}));

    final data = jsonDecode(response.body);

    return data["classes"];
  }

  static Future<List<String>> getClasses(String dept) async {
    final res = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/result_control.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "classes", "department": dept}),
    );

    final data = jsonDecode(res.body);

    return List<String>.from(data["classes"]);
  }

  static Future<List<dynamic>> getUploadStatus(String className) async {
    final res = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/result_control.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "student_upload_status", "class": className}),
    );

    final data = jsonDecode(res.body);

    return data["students"];
  }
  static Future<List<String>> getDepartments() async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/admin/classes/get_classes.php"),
    );

    final data = jsonDecode(res.body);

    List classes = data["classes"];

    // extract departments from class codes
    Set<String> depts = {};

    for (var c in classes) {
      depts.add(c.substring(0, 2));
    }

    return depts.toList();
  }
  
}
