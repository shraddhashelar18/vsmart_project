import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/session_manager.dart';
import '../models/user_session.dart';

class AppSettingsService {
  final String baseUrl =
      "http://192.168.0.102:8080/vsmart_backend/api/setting/setting.php";

  /* ================= GET ALL SETTINGS ================= */

  Future<Map<String, dynamic>> getSettings() async {
    final response = await http.post(
      Uri.parse(baseUrl),
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
      Uri.parse(baseUrl),
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

  /* ================= ACTIVE SEMESTER NUMBER ================= */

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
}
