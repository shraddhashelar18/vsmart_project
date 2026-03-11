import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';
import 'attendance_service.dart';

class PerformanceService {
  final AttendanceService _attendanceService = AttendanceService();

  Future<List<String>> getDepartments() async {
    return _attendanceService.getDepartments();
  }

  Future<List<String>> getClasses(String dept) async {
    return _attendanceService.getClasses(dept);
  }

  /* ===============================
     PERFORMANCE REPORT
  =============================== */

  Future<List<Map<String, dynamic>>> getPerformanceReport({
    required String className,
    required String exam,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/reports/get_performance_report.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({
        "class": className,
        "exam": exam,
      }),
    );

    final data = jsonDecode(response.body);

   if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["students"]);
    }

    throw Exception(data["message"]);

    
  }

  
}
