
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';
import 'app_settings_service.dart';

class AttendanceService {
  final AppSettingsService _settingsService = AppSettingsService();

  Future<String> _getActiveSemester() async {
    return await _settingsService.getActiveSemester();
  }

  /* ===============================
     FETCH DEPARTMENTS FROM BACKEND
  =============================== */

  Future<List<String>> getDepartments() async {
    final response = await http.post(
    Uri.parse(
          "${ApiConfig.baseUrl}/admin/reports/attendance_report.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "departments"}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<String>.from(data["departments"]);
    }

    return [];
  }

  /* ===============================
     FETCH CLASSES FROM BACKEND
  =============================== */

  Future<List<String>> getClasses(String department) async {
    final response = await http.post(
    Uri.parse(
          "${ApiConfig.baseUrl}/admin/reports/attendance_report.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "classes", "department": department}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<String>.from(data["classes"]);
    }

    return [];
  }

  /* ===============================
     FETCH MONTHS FROM BACKEND
  =============================== */

  Future<List<String>> getMonths() async {
    final response = await http.post(
     Uri.parse(
          "${ApiConfig.baseUrl}/admin/reports/attendance_report.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "months"}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<String>.from(data["months"]);
    }

    return [];
  }

  /* ===============================
     ATTENDANCE REPORT
  =============================== */

  Future<List<dynamic>> getAttendanceReport({
    required String className,
    required int month,
  }) async {
    final response = await http.post(
    Uri.parse(
          "${ApiConfig.baseUrl}/admin/reports/attendance_report.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body:
          jsonEncode({"action": "report", "class": className, "month": month}),
    );

    print("Attendance API response:");
    print(response.body);

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data["students"];
    }

    return [];
  }
  Future<bool> isMonthEnabled(int monthNumber) async {
    final response = await http.post(
   Uri.parse(
          "${ApiConfig.baseUrl}/admin/reports/attendance_report.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"action": "check_month", "month": monthNumber}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data["enabled"];
    }

    return false;
  }
}
