import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class TeacherAttendanceService {
  static const base = "${ApiConfig.baseUrl}/teacher";

  // GET STUDENTS
  Future<List<Map<String, dynamic>>> getStudentsByClass(
      String className) async {
    final response = await http.post(
      Uri.parse("$base/get_students.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"class": className}),
    );
    print(response.body);

    final data = jsonDecode(response.body);

    if (data["status"]) {
      return List<Map<String, dynamic>>.from(data["students"])
          .map((s) => {
                "user_id": s["user_id"],
                "name": s["full_name"],
                "roll": s["roll_no"],
                "status": null
              })
          .toList();
    }

    return [];
  }

  // MARK ATTENDANCE
  Future<bool> submitAttendance({
    required String className,
    required String subject,
    required String dateKey,
    required List<Map<String, dynamic>> students,
  }) async {
    final attendanceList = students
        .map((s) => {"user_id": s["user_id"], "status": s["status"] ?? "A"})
        .toList();

    final response = await http.post(
      Uri.parse("$base/mark_attendance.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({
        "class": className,
        "subject": subject,
        "date": dateKey,
        "attendance": attendanceList
      }),
    );
    print(response.body);

    final data = jsonDecode(response.body);

    return data["status"] ?? false;
  }
}
