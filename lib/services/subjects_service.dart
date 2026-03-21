import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class SubjectsService {
  static const String base = "${ApiConfig.baseUrl}/parent";

  Future<List<String>> getSubjects(String className, String semester) async {
    final response = await http.post(
      Uri.parse("$base/get_subjects.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"class": className, "semester": semester}),
    );

    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<String>.from(data["subjects"]);
    }

    return [];
  }
}
