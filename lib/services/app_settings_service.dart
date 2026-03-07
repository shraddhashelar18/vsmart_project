import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class AppSettingsService {
  static const String base = ApiConfig.baseUrl;

  /* ================= GET ALL SETTINGS ================= */

  Future<Map<String, dynamic>> getSettings() async {
    final response = await http.post(
      Uri.parse("$base/setting/setting.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "settings"}),
    );

    final data = jsonDecode(response.body);
    return data;
  }

  /* ================= ACTIVE SEMESTER ================= */

  Future<String> getActiveSemester() async {
    final data = await getSettings();
    return data["activeSemester"];
  }

  /* ================= REGISTRATION ================= */

  Future<bool> getRegistrationStatus() async {
    final data = await getSettings();
    return data["registrationOpen"];
  }

  /* ================= ATTENDANCE LOCK ================= */

  Future<bool> getAttendanceLockStatus() async {
    final data = await getSettings();
    return data["attendanceLocked"];
  }

  /* ================= ATKT LIMIT ================= */

  Future<int> getAtktLimit() async {
    final data = await getSettings();
    return data["atktLimit"];
  }

  /* ================= UPDATE SETTINGS ================= */

  Future<void> updateAcademic({
    required String semester,
    required bool registrationOpen,
    required bool attendanceLocked,
    required int atktLimit,
  }) async {
    final response = await http.post(
      Uri.parse("$base/setting/setting.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({
        "action": "update_academic",
        "activeSemester": semester,
        "registrationOpen": registrationOpen ? 1 : 0,
        "attendanceLocked": attendanceLocked ? 1 : 0,
        "atktLimit": atktLimit
      }),
    );

    print("Settings update response: ${response.body}");
  }
  Future<int> getActiveSemesterNumber(int currentStudentSemester) async {
    final cycle = await getActiveSemester();

    if (cycle == "EVEN") {
      return currentStudentSemester.isEven
          ? currentStudentSemester
          : currentStudentSemester + 1;
    } else {
      return currentStudentSemester.isOdd
          ? currentStudentSemester
          : currentStudentSemester - 1;
    }
  }
  Future<void> logout() async {
    await http.post(
      Uri.parse("$base/setting/setting.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "logout"}),
    );
  }
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse("$base/setting/setting.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({
        "action": "change_password",
        "currentPassword": currentPassword,
        "newPassword": newPassword
      }),
    );

    return jsonDecode(response.body);
  }
}
