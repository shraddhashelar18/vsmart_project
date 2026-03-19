import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../models/teacher.dart';
import '../core/session_manager.dart';

class TeacherService {
  static const String base = ApiConfig.baseUrl;
  Future<List<Teacher>> getTeachersByDepartment(String department) async {
    final url =
        Uri.parse("$base/hod/get_teachers.php?token=${SessionManager.token}");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"department": department}),
    );

    print("TEACHERS RESPONSE: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["status"] == false) {
      throw Exception(data["message"]);
    }

    List<Teacher> teachers = [];

    for (var t in data["teachers"]) {
      List<TeachingAssignment> assignments = [];

      for (var a in t["assignments"]) {
        assignments.add(
          TeachingAssignment(
            className: a["className"],
            subject: a["subject"],
          ),
        );
      }

      teachers.add(
        Teacher(
          id: t["id"],
          name: t["name"],
          email: t["email"],
          mobile: t["mobile"],
          department: t["department"],
          isClassTeacher: t["isClassTeacher"],
          classTeacherOf: t["classTeacherOf"],
          assignments: assignments,
        ),
      );
    }

    return teachers;
  }
}
