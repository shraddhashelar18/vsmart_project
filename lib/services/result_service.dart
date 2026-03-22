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
       Uri.parse(
            "${ApiConfig.baseUrl}/admin/reports/result_control.php?token=${SessionManager.token}"),
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
    await http.post(
        Uri.parse(
            "${ApiConfig.baseUrl}/admin/reports/result_control.php?token=${SessionManager.token}"),
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
        Uri.parse(
            "${ApiConfig.baseUrl}/admin/open_marksheet_upload.php?token=${SessionManager.token}"),
        headers: {"Authorization": "Bearer ${SessionManager.token}"});
  }

  /* ===============================
     PUBLISH FINAL RESULT
  =============================== */

  static Future publishFinalResult() async {
    await http.post(
        Uri.parse(
            "${ApiConfig.baseUrl}/admin/publish_final_results.php?token=${SessionManager.token}"),
        headers: {"Authorization": "Bearer ${SessionManager.token}"});
  }

  /* ===============================
     GET UPLOAD PROGRESS
  =============================== */

  static Future<List<dynamic>> getUploadProgress() async {
    final response = await http.post(
       Uri.parse(
            "${ApiConfig.baseUrl}/admin/reports/result_control.php?token=${SessionManager.token}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SessionManager.token}"
        },
        body: jsonEncode({"action": "upload_progress"}));

    final data = jsonDecode(response.body);

    return data["classes"];
  }

  static Future<List<String>> getClasses(String dept) async {
    final res = await http.get(
      Uri.parse(
          "${ApiConfig.baseUrl}/admin/classes/get_classes_filtered.php?token=${SessionManager.token}"),
    );

    if (res.body.isEmpty) return [];

    final data = jsonDecode(res.body);

    List all = data["classes"] ?? [];

    return all
        .where((c) => c.toString().startsWith(dept))
        .map<String>((e) => e.toString())
        .toList();
  }

  static Future<List<dynamic>> getUploadStatus(String className) async {
    final res = await http.post(
      Uri.parse(
          "${ApiConfig.baseUrl}/admin/reports/result_control.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "student_upload_status", "class": className}),
    );

    // 🔥 VERY IMPORTANT SAFETY
    if (res.body.isEmpty) return [];

    final data = jsonDecode(res.body);

    // 🔥 FIX: ALWAYS RETURN LIST
    return data["students"] ?? [];
  }
 static Future<List<String>> getDepartments() async {
    final res = await http.get(
      Uri.parse(
          "${ApiConfig.baseUrl}/admin/classes/get_classes_filtered.php?token=${SessionManager.token}"),
    );

    final data = jsonDecode(res.body);

    if (data["status"] != true || data["classes"] == null) {
      return [];
    }

    List classes = data["classes"];

    Set<String> depts = {};

    for (var c in classes) {
      if (c.length >= 2) {
        depts.add(c.substring(0, 2));
      }
    }

    return depts.toList();
  }
}
