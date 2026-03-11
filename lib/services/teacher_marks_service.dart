import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class TeacherMarksService {
  static const String base = "${ApiConfig.baseUrl}/teacher";

  /// GET STUDENTS WITH EXISTING MARKS
  Future<List<Map<String, dynamic>>> getStudents({
    required String className,
    required String subject,
    required String examType,
  }) async {
    final response = await http.get(
      Uri.parse(
        "$base/get_class_students_marks.php?class=$className&subject=$subject&exam_type=$examType",
      ),
      headers: {"Authorization": "Bearer ${SessionManager.token}"},
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<Map<String, dynamic>>.from(data["students"]);
    }

    return [];
  }

  /// SAVE OR PUBLISH MARKS
  Future<bool> saveMarks({
    required String className,
    required String subject,
    required String examType,
    required int totalMarks,
    required bool isDraft,
    required List<Map<String, dynamic>> marks,
  }) async {
    final response = await http.post(
      Uri.parse("$base/enter_marks.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({
        "class": className,
        "subject": subject,
        "exam_type": examType,
        "total_marks": totalMarks,
        "is_draft": isDraft,
        "marks": marks
      }),
    );

    final data = jsonDecode(response.body);

    return data["status"] ?? false;
  }

  Future<Map<String, dynamic>?> getMarksStats({
    required String className,
    required String subject,
    required String examType,
  }) async {
    final response = await http.get(
      Uri.parse(
          "$base/get_marks_stats.php?class=$className&subject=$subject&exam_type=$examType"),
      headers: {"Authorization": "Bearer ${SessionManager.token}"},
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return data;
    }

    return null;
  }
}
